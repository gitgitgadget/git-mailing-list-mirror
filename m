From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [RFC] faking cvs annotate
Date: Fri, 16 Dec 2005 10:05:59 -0500
Message-ID: <43A2D7D7.1060506@michonline.com>
References: <46a038f90512151713i118e58acia466d0f65ff91383@mail.gmail.com> <7vpsnxlsw7.fsf@assigned-by-dhcp.cox.net> <20051216060953.GA22150@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9DD4597339B7ABA5E52D0B8D"
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 16:09:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnHA7-0002ts-BM
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 16:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVLPPGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 10:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVLPPGU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 10:06:20 -0500
Received: from mail.autoweb.net ([198.172.237.26]:2456 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S932307AbVLPPGU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 10:06:20 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1EnH9v-0001xp-8C; Fri, 16 Dec 2005 10:06:12 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1EnH9o-0008DV-9Q; Fri, 16 Dec 2005 10:06:10 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EnH9n-0006Uf-EE; Fri, 16 Dec 2005 10:06:03 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051216060953.GA22150@mail.yhbt.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13737>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9DD4597339B7ABA5E52D0B8D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Eric Wong wrote:

> #!/usr/bin/env perl
> # Copyright (c) 2005, Eric Wong <normalperson@yhbt.net>
> #
> # This file is licensed under the GPL v2, or a later version
> # at the discretion of Linus.

Please use full names for this kind of authority delegation.

> # Read git-whatchanged output and let all Algorithm::Annotate do all
> # the hard work for us.  Thanks to Chia-liang Kao for the awesome 
> # Algorithm::Annotate module.
> #

You'll want to add libalgorithm-annotate-perl to the Debian/control
Depends: line when you submit this as a patch.  (I dont' have an
RPM-based machine handy, so I can't doublecheck that.)

I was going to comment on the rest, but I don't really have time to play
with it at the moment.


-- 

Ryan Anderson
  sometimes Pug Majere

--------------enig9DD4597339B7ABA5E52D0B8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDotfbfhVDhkBuUKURAnLlAKCIJLdOHoFt26aOREz8gnWonqACLgCeNqk9
LT7hW7vqoQ0ZeHQFTcnpkUg=
=sMc8
-----END PGP SIGNATURE-----

--------------enig9DD4597339B7ABA5E52D0B8D--
