From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: When to repack?
Date: Fri, 29 Feb 2008 05:22:40 -0800 (PST)
Message-ID: <m3prufkicm.fsf@localhost.localdomain>
References: <47C7E4AD.6030509@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Fri Feb 29 14:23:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV5Cp-0001jO-Vp
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 14:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbYB2NWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 08:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbYB2NWp
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 08:22:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:26801 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbYB2NWn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 08:22:43 -0500
Received: by ug-out-1314.google.com with SMTP id z38so286818ugc.16
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=nB6cKKFfY1OZRBDhfkULT7La5h+3L9FhOBTU9syDVmM=;
        b=DSC/3XtJZKvRC80IisDLj2+gHVCy08lbQIuRpcaz7sj6FPKIZ3P29YFJNMFG+8TTS0fzso6qgiSudUyJJBZT+GtqNhWg3J3qTxP4So1VNEWr8zLVqXV6pJPg3Roo5UBw6wx9/xRE1yhRdpdhnJcTENV4QQP2HGPtKAlp8kQMxwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=mQlSfgGkI5/mkYjceVH8zbaGJI6V5LWghqZCThuhwOv/Z4Tt3R3VTsJ0H71ZRM0MANnXN8DYrKmfUcpKoPHqsP8H5Ju8jUj7EDH7zxSSRp7gSpfCykDnNdDF3d3eAltXrIFC45YDOJqndlUGYrp39GWR4ys/VueBC80gbEGOI/c=
Received: by 10.78.122.16 with SMTP id u16mr9985907huc.11.1204291361745;
        Fri, 29 Feb 2008 05:22:41 -0800 (PST)
Received: from localhost.localdomain ( [83.8.217.18])
        by mx.google.com with ESMTPS id k5sm18186543nfd.23.2008.02.29.05.22.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Feb 2008 05:22:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1TDMcfp023727;
	Fri, 29 Feb 2008 14:22:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1TDMXZ2023722;
	Fri, 29 Feb 2008 14:22:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <47C7E4AD.6030509@glidos.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75534>

Paul Gardiner <osronline@glidos.net> writes:

> There's advantage to repacking a repository after using git-fast-import.
> If that repacked repository is then git-pushed to another, is there
> any point in repacking the other afterwards? I'm guessing not, but
> just checking.

Yes, there is, to concatenate packs. But this should be less urgent.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
