From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [PATCH] fix mktemp (remove mktemp ;)
Date: Sun, 17 Apr 2005 01:36:26 +0200
Message-ID: <20050416233626.GV9461@lug-owl.de>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Apr 17 01:33:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwmP-0004pF-5G
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:32:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVDPXga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 16 Apr 2005 19:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVDPXga
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:36:30 -0400
Received: from lug-owl.de ([195.71.106.12]:60868 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261200AbVDPXg0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 19:36:26 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 1B99819027E; Sun, 17 Apr 2005 01:36:26 +0200 (CEST)
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 2005-04-16 16:27:43 -0700, Paul Jackson <pj@sgi.com>
wrote in message <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.=
com>:
> Index: git-pasky-0.4/gitcommit.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- git-pasky-0.4.orig/gitcommit.sh	2005-04-12 10:39:14.000000000 -07=
00
> +++ git-pasky-0.4/gitcommit.sh	2005-04-16 13:17:49.000000000 -0700
> @@ -60,7 +60,9 @@ for file in $commitfiles; do
>  	echo $file;
>  done
>  echo "Enter commit message, terminated by ctrl-D on a separate line:=
"
> -LOGMSG=3D`mktemp -t gitci.XXXXXX`
> +t=3D${TMPDIR:-/usr/tmp}/gitapply.$$

/usr/tmp/ ??? Hey, /usr may be mounted read-only!  Why not just use /tm=
p ?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481         =
    _ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Kri=
eg  _ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im=
 Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | T=
CPA));
