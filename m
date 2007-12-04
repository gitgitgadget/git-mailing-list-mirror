From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Not a valid object name refs/heads/t20050127-arm during git-cvsimport
Date: Tue, 04 Dec 2007 10:06:10 -0800 (PST)
Message-ID: <m38x4auyga.fsf@roke.D-201>
References: <20071204171833.GD29315@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Baurzhan Ismagulov <ibr@radix50.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 19:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzcAH-00022w-Vq
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 19:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbXLDSGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 13:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbXLDSGU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 13:06:20 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:43558 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbXLDSGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 13:06:19 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1283119mue
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=0EozuqqCVxMLb5blB6y8OvTxYzoApjjWcjHcjuMOGEo=;
        b=qpmo8cwv8wNuLqySA2SI0cy7FSVdPG1pu/PlCb58SzeucGBbyfXL361NxhCocUowjF+6jr1U28gq6AIeXMEAc27Q8j5UxI4zsZz+afp445bGJNSWwMvX97HPYNV8ljx2x/7jiUjEB1q+atNC+qyXX+m9ghkmLaRVhMzisXF+tVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=IDYDlqIRoS1eJLVXx+9dMAs9S6Ww8UTmyRSNQkrpee+LFJTjGr//QOSi4Xl9FSSx9Vaov/x96voU07RVFLtOFYi1sQanrlwMDUUXakc7BPOu/G2o/twfItAyx4HKE6jyna58cJ8F1TwxHLGDGy+etjHU0WFk2FYLJP4iG47lJd4=
Received: by 10.82.173.19 with SMTP id v19mr2466624bue.1196791572491;
        Tue, 04 Dec 2007 10:06:12 -0800 (PST)
Received: from roke.D-201 ( [83.8.233.204])
        by mx.google.com with ESMTPS id y18sm317723fkd.2007.12.04.10.06.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2007 10:06:10 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB4I6Eto018850;
	Tue, 4 Dec 2007 19:06:15 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB4I6EDC018847;
	Tue, 4 Dec 2007 19:06:14 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071204171833.GD29315@radix50.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67071>

Baurzhan Ismagulov <ibr@radix50.net> writes:

> I want to import a CVS repo myrepo into git. I copied CVSHEAD and myrepo
> dirs from the cvs server to /home/ibr/tmp and issued the following
> command:
> 
> git-cvsimport -p x -k -o cvshead -d/home/ibr/tmp -C zzz myrepo/drv
> 
> It fails [...]

You can try to use other CVS importers, for example parsecvs from
Freedesktop project; see InterfaceFrontendsAndTools page on git wiki:
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

-- 
Jakub Narebski
