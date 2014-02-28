From: Thomas Schwinge <thomas@codesourcery.com>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Fri, 28 Feb 2014 11:58:59 +0100
Message-ID: <878usvo64s.fsf@kepler.schwinge.homeip.net>
References: <cover.1393257006.git.kirr@mns.spb.ru> <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Feb 28 13:09:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJMG1-0003Mq-7i
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 13:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbaB1MJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 07:09:33 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:42815 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbaB1MJc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 07:09:32 -0500
X-Greylist: delayed 4216 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Feb 2014 07:09:32 EST
Received: from svr-orw-fem-01.mgc.mentorg.com ([147.34.98.93])
	by relay1.mentorg.com with esmtp 
	id 1WJL9r-0003d5-Ed from Thomas_Schwinge@mentor.com ; Fri, 28 Feb 2014 02:59:11 -0800
Received: from SVR-IES-FEM-01.mgc.mentorg.com ([137.202.0.104]) by svr-orw-fem-01.mgc.mentorg.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 28 Feb 2014 02:59:11 -0800
Received: from feldtkeller.schwinge.homeip.net (137.202.0.76) by
 SVR-IES-FEM-01.mgc.mentorg.com (137.202.0.104) with Microsoft SMTP Server id
 14.2.247.3; Fri, 28 Feb 2014 10:59:08 +0000
In-Reply-To: <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
User-Agent: Notmuch/0.9-101-g81dad07 (http://notmuchmail.org) Emacs/23.4.1 (i486-pc-linux-gnu)
X-OriginalArrivalTime: 28 Feb 2014 10:59:11.0342 (UTC) FILETIME=[1C5818E0:01CF3474]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242945>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, 24 Feb 2014 20:21:49 +0400, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> Both autoconf and config.mak.uname configurations were updated. For
> autoconf, we are not bothering considering cases, when no alloca.h is
> available, but alloca() works some other way - its simply alloca.h is
> available and works or not, everything else is deep legacy.

Sounds good for GNU Hurd, or any system using glibc (but have not
explicitly tested your patch).

> For config.mak.uname, I've tried to make my almost-sure guess for where
> alloca() is available, but since I only have access to Linux it is the
> only change I can be sure about myself, with relevant to other changed
> systems people Cc'ed.

> diff --git a/config.mak.uname b/config.mak.uname
> index 7d31fad..71602ee 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -239,6 +243,7 @@ ifeq ($(uname_S),AIX)
>  endif
>  ifeq ($(uname_S),GNU)
>  	# GNU/Hurd
> +	HAVE_ALLOCA_H =3D YesPlease
>  	NO_STRLCPY =3D YesPlease
>  	NO_MKSTEMPS =3D YesPlease
>  	HAVE_PATHS_H =3D YesPlease

Acked-by: Thomas Schwinge <thomas@codesourcery.com> (GNU Hurd changes)


Gr=C3=BC=C3=9Fe,
 Thomas

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQEcBAEBAgAGBQJTEGvzAAoJEK3/DN1sMFFt7RcH/jWSFkynceXUbi8yJ5y3yO8y
oDeKCICq3pLUs+fd4xyvT7nwv+F7bdvH2u4z+SV+GIlK1EukpeeaaHgCR5er+W1j
Yjy6aMKd7Y/5zHKBVzihqAuwcCee6bJ8QmTYDRKCfxSgoYhv9ncqhPT0bK+CMhs+
Zr6tCFgdlUGzVgKDm/vXyLEkupmmuTW54ExZAYbtJhx5tZeS3ejA0uwMUP74qzNm
/EGebWYCWtCkofIayXlcKg8JXpVKrTLo+tnggY1n2n2jHXpNwasZk5zMklxW0ZLL
RjQ5dm7nWCk1rmenyBcMhZWip2kP/CM5SAyTJXAiOMC//VmwvQjaCzsFC4WeZKM=
=kV4K
-----END PGP SIGNATURE-----
--=-=-=--
