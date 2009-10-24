From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Stacked Git 0.15
Date: Sat, 24 Oct 2009 16:20:30 -0700 (PDT)
Message-ID: <m34opoe5t6.fsf@localhost.localdomain>
References: <b0943d9e0910241541n7b1091ecp6b21fa896405afa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 01:27:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1q11-0004Po-Ui
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 01:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbZJXXUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 19:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbZJXXUf
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 19:20:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:45663 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbZJXXUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 19:20:34 -0400
Received: by fg-out-1718.google.com with SMTP id d23so675621fga.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 16:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7VC2iYjwcj3hbSzX/Npv2KfaXjV4MThqlS2SSXN73eY=;
        b=h6lg1WI43i4l8swpJZCHURCfG8Za/+JsBiGiYj49mofLZRHsJj4SiKbq93A6CA383k
         4Ime3+pISxHJkPad7eEJOIoQw9G70TLKmhgTIiFzR3gwhQvZnxTF1e/VV9vaFV9auOVP
         z7Pc9oelWGYduyIiIH3OMr7Npzh/bEsSoDRDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=R40D2+n7sSjGYt49fgxO2LK/5fl8uKJMamSY7VOM0Cnz1h/xKfInSfSBVcaCkBa4Vc
         3oY+4T+wpHMF+z7hpO9+NyO9Aq0bVnWgcGX+40AbowBRJy3J34bS2QA+iVhXOu5SnTke
         WuRWYrt9It6NK/ptnD2m1FTIsE2LpsO9844ms=
Received: by 10.86.231.13 with SMTP id d13mr2186838fgh.41.1256426437738;
        Sat, 24 Oct 2009 16:20:37 -0700 (PDT)
Received: from localhost.localdomain (abvo67.neoplus.adsl.tpnet.pl [83.8.212.67])
        by mx.google.com with ESMTPS id d6sm3512321fga.15.2009.10.24.16.20.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 16:20:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9ONLwCR029007;
	Sun, 25 Oct 2009 01:21:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9ONLvWF029004;
	Sun, 25 Oct 2009 01:21:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <b0943d9e0910241541n7b1091ecp6b21fa896405afa0@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131183>

Catalin Marinas <catalin.marinas@gmail.com> writes:

> StGit is a Python application providing functionality similar to Quilt
> (i.e. pushing/popping patches to/from a stack) on top of Git. These
> operations are performed using Git commands, and the patches are
> stored as Git commit objects, allowing easy merging of the StGit
> patches into other repositories using standard Git functionality.
> 
>   Download:         http://download.gna.org/stgit/stgit-0.15.tar.gz
>   Main repository:  git://repo.or.cz/stgit.git
>   Project homepage: http://www.procode.org/stgit/
>   Mailing list:     git@vger.kernel.org (please use "StGit" in the subject)
>   Bug tracker:      https://gna.org/bugs/?group=stgit

Is there RPM or SRPM (src.rpm) available somewhere? Or does tarball
include *.spec file, or an rpm target?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
