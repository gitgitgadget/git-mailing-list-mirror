From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] format-patch: Update the `-3` example
Date: Sat, 21 Aug 2010 03:23:59 -0700 (PDT)
Message-ID: <m3sk28nu24.fsf@localhost.localdomain>
References: <1282382819-25097-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 12:24:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmlFO-00033T-GG
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682Ab0HUKYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:24:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57224 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0HUKYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:24:01 -0400
Received: by wyb32 with SMTP id 32so4701783wyb.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 03:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=e3zdGzonG/faocFnQ7yiv04eBSTjaGGYVFDKm1otQzs=;
        b=CIFI6jJRG9eSxqShqs5box+K0lJmNXpnYy8XmEbs195LldC2wswJbo667c6QpdZFkm
         SenVK+P1hK2rXZHh50qLBPP3dwDCZHPJRj1wWY+jCEskIQixHgRdFDtdDkVsTGJ4B90m
         Un3qCx9aX8shKiTAQ7W0BOG7dis6FNFg8zzvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=S+butL8z0hqG6QuZ/4I2a5aPVx4GBIpic5LX2Q91Ki+bOSTL/cqJwRcYHWiP//NUfU
         Jgh9gJkwK1dX2bxCr7//08QxsolUd5LXp0PO9ggePOxH+zr9VfukmPqnrE3wWXyE0spi
         RASOkB+TQipWAWZoxyf2xmPV7vHabSaL1hZjQ=
Received: by 10.216.17.194 with SMTP id j44mr2322609wej.68.1282386239879;
        Sat, 21 Aug 2010 03:23:59 -0700 (PDT)
Received: from localhost.localdomain (aeho172.neoplus.adsl.tpnet.pl [79.186.196.172])
        by mx.google.com with ESMTPS id k83sm2376736weq.38.2010.08.21.03.23.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 03:23:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7LANVpC031546;
	Sat, 21 Aug 2010 12:23:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7LANFWA031542;
	Sat, 21 Aug 2010 12:23:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1282382819-25097-1-git-send-email-artagnon@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154136>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In the EXAMPLES section, `git-format-patch -3` doesn't work
> anymore. Update it to read `git format-patch HEAD~3`. The example was
> introduced in 7c49628 and had not been updated since.
> 
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-format-patch.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 4b3f5ba..2a44472 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -271,7 +271,7 @@ use it only when you know the recipient uses git to apply your patch.
>  as e-mailable patches:
>  +
>  ------------
> -$ git format-patch -3
> +$ git format-patch HEAD~3
>  ------------

Works for me:

  5031:[gitweb/split@git]# git format-patch -3
  0001-gitweb-Prepare-for-splitting-gitweb.txt
  0002-gitweb-Create-Gitweb-Git-module.txt

  5034:[gitweb/split@git]# git version
  git version 1.7.2.1


The -3 is git-log option:

  -<n>   Limits the number of commits to show.

and also git-format-patch option:

  -<n>   Limits the number of patches to prepare.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
