From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log --graph
Date: Sun, 11 Oct 2009 13:30:12 -0700 (PDT)
Message-ID: <m3ws31fzbp.fsf@localhost.localdomain>
References: <c94f8e120910111127q102aa6a1qc3c0850f8a8a1509@mail.gmail.com>
	<fabb9a1e0910111135v4f3c75a7v6657f5dcfacf13ac@mail.gmail.com>
	<vpqhbu5zplr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dilip M <dilipm79@gmail.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Oct 11 22:33:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx56j-0003yh-4Q
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 22:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbZJKUav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 16:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbZJKUav
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:30:51 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:63231 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbZJKUau (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 16:30:50 -0400
Received: by ewy4 with SMTP id 4so2006669ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Y3M8Hq9dDXwfpsE8CAFYGVkznkOJ7bn9b1P94rM1R6Y=;
        b=ugigEmO0/Ck8y4WVBiBtu5uchJi5c+OSxupMXwzpa3ckuq0yIJCbWi9q/jR6efgr6/
         9aGvmk2mxXEH59CQZG7QSkeWNuabcTNchIObuIjs5p1130q49KRWtuO2cITtVL5gKUog
         QyeQbKq++KwJdrxKK3b12k7IO/CNyqoG48rwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=WGBTwXJAfuYiigf3rhQzlROC+5BO9G9nIec6BL6R0ufiRnw/xyMVmR5eQGTYCblTLm
         tgWWRJk5euby443NvNOocm4RbZ2xHH40lTCWqQcaRPMI7EOW9PuPHBrwaUBPpyE3jspK
         vHhjwO/7KQjEPl7qupE8H/QDlLekUZVNgxJfM=
Received: by 10.210.9.5 with SMTP id 5mr3105727ebi.78.1255293013881;
        Sun, 11 Oct 2009 13:30:13 -0700 (PDT)
Received: from localhost.localdomain (abva84.neoplus.adsl.tpnet.pl [83.8.198.84])
        by mx.google.com with ESMTPS id 10sm126118eyd.46.2009.10.11.13.30.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 13:30:12 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9BKUo3t012704;
	Sun, 11 Oct 2009 22:30:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9BKUYQ4012698;
	Sun, 11 Oct 2009 22:30:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <vpqhbu5zplr.fsf@bauges.imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129949>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I personnally like the format of
> 
>  $ git log --graph --pretty=oneline --abbrev-commit
>
> with ui.color set to true in ~/.gitconfig.

You can use

  $ git log --graph --oneline

nowadays for that.  A bit shorter.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
