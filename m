From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git svn relocate [SCRIPT]
Date: Tue, 22 Jun 2010 06:15:06 -0700 (PDT)
Message-ID: <m3r5jznr9z.fsf@localhost.localdomain>
References: <20100622114043.1419733jtkx6m0co@webmail.tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Stimming <christian@cstimming.de>
X-From: git-owner@vger.kernel.org Tue Jun 22 15:15:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR3Jt-0003uk-M8
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 15:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab0FVNPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 09:15:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65115 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab0FVNPK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 09:15:10 -0400
Received: by fxm10 with SMTP id 10so2406460fxm.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 06:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=i7ZYbhpeiYJeLqWNRTaUhaOESt13hGpnqFVX4XjDaX8=;
        b=U8xJDMwCCO4BahjkIsCYRv37F/12aVc+4s6i99G+QQW8IqqsYEcp58HXi0Z6hODD2G
         7GWQezZmnDL5qOOGPclrAzoFZO/hVNHpYEr7AKtsCuTrwSKtSWb5JkJ+f/ei/Ps3i307
         K2XTBISHkdCwtJj1cb+S1iEQCuYCQ6WL0j1EU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OfPxP7xPPYJ/Ahq17C0C6OU/XiODpBzxbtLcgb7NSysaM9PO2w6cdRjm1RdS0Oq7hX
         iHUadyo1Mm2aSxO5ThN3zTX+2x0nn13B1ErdnfydDthmGRDwt/IDG4eIGuIYqVZLS/DG
         +o27G8jiCYmGKvEfl77YbEyRdWp1nvLDJri2Y=
Received: by 10.87.2.15 with SMTP id e15mr10391043fgi.23.1277212507810;
        Tue, 22 Jun 2010 06:15:07 -0700 (PDT)
Received: from localhost.localdomain (abvn56.neoplus.adsl.tpnet.pl [83.8.211.56])
        by mx.google.com with ESMTPS id e20sm9175787fga.21.2010.06.22.06.15.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 06:15:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5MDEZpW019702;
	Tue, 22 Jun 2010 15:14:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o5MDEHjx019698;
	Tue, 22 Jun 2010 15:14:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100622114043.1419733jtkx6m0co@webmail.tu-harburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149480>

Christian Stimming <christian@cstimming.de> writes:

> Dear all,
> 
> I haven't found an easy solution for when a git-svn SVN server changes
> its address, but I think the attached patch implements a solution
> useful for others as well.
> 
> In plain svn this is the "svn switch --relocate URL1 URL2" command to
> change the URL of a working copy from URL1 to URL2. In git-svn, there
> didn't seem to be a suitable command available. What I found were the
> instructions here
> http://translate.org.za/blogs/wynand/en/content/changing-your-svn-repository-address-git-svn-setup
> and some other google hits related to this one. The instructions from
> the wynand blog uses git-filter-branch, and the instructions were
> complete enough so that an all-in-one shell script wasn't too
> difficult to write. So the attached script implements this: Just call
> "git-svn-relocate URL1 URL2" and all the rest should happen
> automatically.

If you can put this script somewhere (e.g. GitHub, or repo.or.cz), could you
please add information about it to InterfacesFriontendsAndTools page on Git
Wiki (http://git.wiki.kernel.org)?

Alternatively, perhaps you could send it as a patch adding it to somwehere
in the contrib/

-- 
Jakub Narebski
Poland
ShadeHawk on #git
