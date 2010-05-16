From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Has anyone looked at Gettext support for Git itself?
Date: Sat, 15 May 2010 17:03:15 -0700 (PDT)
Message-ID: <m3pr0wd880.fsf@localhost.localdomain>
References: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 02:03:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODRKL-0007Mp-B0
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 02:03:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab0EPADT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 May 2010 20:03:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:1281 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0EPADS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 May 2010 20:03:18 -0400
Received: by fg-out-1718.google.com with SMTP id 22so11912fge.1
        for <git@vger.kernel.org>; Sat, 15 May 2010 17:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=kgj6VkLn/lec4GPpen8711OMeYUkOF22DY7n8XFfwjc=;
        b=siEOnSNA88FMYCah4z/ZzdNCeytM37IMURtsJXG5a7HqZxtqNGzTlOI1HMYg71erve
         T8EL2KHCmSwqeeDmg+H3rzlCTfRcZ5BXlHi0D0CRHAQ3G9tGBI8xwGHdS9pTApww0QiV
         yNjXI3kzK9MYhc8Ni/BjVb5ZHqSDGerzbO8qM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=YNME0EQ1Juo35CcxT4lakN3UaCXWz9+s9F26DnAzNm4WxI436WDeSmNZdEeUuTNtSL
         /JufSTRlmGzL4ryCws0iyx2r5Gc+rMkS0rJ1VXlwTvuQdgXbRdX9vAqwHgcs2MLDl7gt
         OSF+WOXY9rKaKFriHX+FR/FUas+vy8WHFo/ks=
Received: by 10.86.124.35 with SMTP id w35mr5616359fgc.49.1273968196360;
        Sat, 15 May 2010 17:03:16 -0700 (PDT)
Received: from localhost.localdomain (absh50.neoplus.adsl.tpnet.pl [83.8.127.50])
        by mx.google.com with ESMTPS id 18sm5506038fks.5.2010.05.15.17.03.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 17:03:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4G02pAU013266;
	Sun, 16 May 2010 02:03:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4G02eq2013262;
	Sun, 16 May 2010 02:02:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinlDF-aKDjwvgZEqtUgzW7MCIuElQ_RfJn_RkZp@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147169>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> I couldn't find anything about this in the list archives. Have there
> been any discussions of adding internationalization support to Git
> itself? I.e. the interface messages that the core Git utilities emit.
>=20
> I tried to get started with integrating GNU Gettext, but gnuish
> assumptions it makes about building make it a bit hard.
>=20
> Is there perhaps another gettext implementation that would be more
> suitable for Git?
>=20
> I'd be interested in submitting patches to make the existing strings
> translatable if someone could get the tool + build skeleton going.

=46irst, git uses multiple programming languages: you would need a
solution that would work for programs in C (gettext), for Perl
(Locale::Maketext or less known Data::Localize), probably for Python,
and what would probably give most problems for shell scripts.

Second, you would need to take care that changing locale wouldn't
break git.  It can be done either via setting LC_ALL=3DC in
git-sh-setup, or by translation only porcelain, and leaving plumbing
unchanged.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
