From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] Fix git-completion.bash for use in zsh
Date: Sat, 7 Apr 2012 16:09:35 +0300
Message-ID: <CAMP44s1H74_2pewqLrkz9cmiguxH1=Ayz-5fn5_HgUCqbbB9rw@mail.gmail.com>
References: <1332327960-5208-1-git-send-email-dev@randomguy3.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Merry <dev@randomguy3.me.uk>
X-From: git-owner@vger.kernel.org Sat Apr 07 15:10:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGVPD-0004Pu-QT
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 15:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754060Ab2DGNJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Apr 2012 09:09:38 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59711 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab2DGNJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 09:09:37 -0400
Received: by eaaq12 with SMTP id q12so830039eaa.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 06:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YwwPRBJXYKW83h0D+7hM6c0MYh1Yu6GOu3ZezpjC7h0=;
        b=kXvRRBtNS6x/AsHH/2YSR0suYAkYmOFPlXDyDLXMVhTYjgMS7+5bOJJ/IhQnacXIee
         zOwoBopxhxN6KQCs/tT94o5VIbw6R3PGcyl4KGHW4rHwnock25fsX9fkVXS+axUlWT0L
         QWGX3VEIs9aRyZUSHtuVIGcGvWqka6nsKzwJK3b+79rYrlOOLZ13QyVP/Ic77Rcw9lxU
         t4nogekGL7uD3klLwuZCWebjv2YnJ/1mwpHKIUkz+VLF6NbTK2HSoLi9DR5HU49S5He+
         3ixXjxUDuJFm0VMXv1pAMh0qO4E9fKUug7UJ4jyCNRUJx0aLODCVu4OyXQj0aeMNCOZA
         2hhA==
Received: by 10.213.35.196 with SMTP id q4mr83613ebd.29.1333804175966; Sat, 07
 Apr 2012 06:09:35 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Sat, 7 Apr 2012 06:09:35 -0700 (PDT)
In-Reply-To: <1332327960-5208-1-git-send-email-dev@randomguy3.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194949>

On Wed, Mar 21, 2012 at 1:06 PM, Alex Merry <dev@randomguy3.me.uk> wrot=
e:

> =C2=A0__git_ps1_show_upstream ()
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local key value
> - =C2=A0 =C2=A0 =C2=A0 local svn_remote=3D() svn_url_pattern count n
> + =C2=A0 =C2=A0 =C2=A0 local svn_remote svn_url_pattern count n
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local upstream=3Dgit legacy=3D"" verbose=3D=
""
> + =C2=A0 =C2=A0 =C2=A0 svn_remote=3D()
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# get some config options from git-config
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local output=3D"$(git config -z --get-rege=
xp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n'=
 '\n ')"
> --

Actually, a more proper way to do this is 'local -a svn_remote'.

Cheers.

--=20
=46elipe Contreras
