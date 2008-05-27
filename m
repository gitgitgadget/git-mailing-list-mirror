From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Reverting to old commit
Date: Tue, 27 May 2008 11:09:40 -0700 (PDT)
Message-ID: <m3bq2r39gh.fsf@localhost.localdomain>
References: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcus <prima@wordit.com>
X-From: git-owner@vger.kernel.org Tue May 27 20:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K13d4-00061M-Ub
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 20:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863AbYE0SJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 14:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755852AbYE0SJn
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 14:09:43 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:15734 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbYE0SJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 14:09:43 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1362139ika.5
        for <git@vger.kernel.org>; Tue, 27 May 2008 11:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=JCIQuphgBrXu4dbHCktRX9+I0Jzm4M53hvcuhefRtmE=;
        b=cu7bIbFr54S8KScTE9PvKWCaHwYE86dpD/hFJT2wamIyyAFtz4ua3bEFkrV7mjnKv9U4MsbP10kJQG8HMWNOS71BUKX0xcrWASiGzZsCtLicV4VUHa1KJHD1D28Up33MfQhZlcAt/wfl2zfFiBs9UNaeVF9Hra/jEWadm7d9sb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=bSjTxaveuWDLAFJbSIzaNgXznNQxOwvJT4zM5J/AoQ83monNcKshVsy2rL3M6dOQW8NMVgHIF6HEZmLeiItakktjYdYQo4wS7ISbIpbuHuDJ5cHqJTLbKIge5hQzSymxQMmIylWil1286ORaMZMC+tJtspubrSVBAITdDP0btLE=
Received: by 10.86.23.17 with SMTP id 17mr849017fgw.44.1211911781552;
        Tue, 27 May 2008 11:09:41 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.174])
        by mx.google.com with ESMTPS id 4sm13494962fgg.6.2008.05.27.11.09.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 11:09:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4RI9bJi029465;
	Tue, 27 May 2008 20:09:37 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4RI9Ytw029462;
	Tue, 27 May 2008 20:09:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83036>

Marcus <prima@wordit.com> writes:

> Newbie question: What's the simplest way to find an old commit and revert?
> 
> Say you have a version from yesterday which worked and today's
> experiments failed, so you want to go back to that working version.
> Unfortunately, it's not tagged. Instead you need to actually view the
> code to identify the version you want. I thought maybe gitk might
> help, but I can't find my way with gitk. I hoped you could browse
> revisions easier in a GUI and tell gitk or git-gui to revert?

Errr... isn't it what git-bisect is for?

If it is not, viewing git-log, or git-reflog output should help...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
