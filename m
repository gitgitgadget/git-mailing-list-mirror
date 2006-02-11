From: Keith Packard <keithp@keithp.com>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 11:10:29 -0800
Message-ID: <1139685031.4183.31.camel@evo.keithp.com>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
	 <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RjT1XOfeM6XyBQDVQbRT"
Cc: keithp@keithp.com, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Feb 11 20:10:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F808z-00073r-NE
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 20:10:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWBKTKu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 14:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWBKTKu
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 14:10:50 -0500
Received: from home.keithp.com ([63.227.221.253]:8202 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S964776AbWBKTKu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 14:10:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 38B4B130023;
	Sat, 11 Feb 2006 11:10:49 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07325-03; Sat, 11 Feb 2006 11:10:48 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 9E60113001F; Sat, 11 Feb 2006 11:10:48 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 8C2E114001;
	Sat, 11 Feb 2006 11:10:48 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F808f-0004ZR-CF; Sat, 11 Feb 2006 11:10:33 -0800
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15959>


--=-RjT1XOfeM6XyBQDVQbRT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-02-11 at 09:45 -0800, Linus Torvalds wrote:

> More importantly, it really wouldn't have helped that much in this=20
> situation. At least for me, the network is 90% of the problem, the=20
> pack-file generation is at most 10%. So cached packfiles really only=20
> matter for server-side problems (high CPU load, or lack of memory, or=20
> heavy disk activity).

I'd like to see git use less CPU than CVS does on my distribution host;
some mechanism for re-using either existing or cached packs would help a
whole lot with that. The alternative is to see people switch to rsync
instead, which seems like a far worse idea.  =20

--=20
keith.packard@intel.com

--=-RjT1XOfeM6XyBQDVQbRT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD7jalQp8BWwlsTdMRAmNsAKDmFrUxKX/HD7Hjz+60z2bjU/i8BwCg0KFP
KSWHMC1lyTeufP9XfUMQCDc=
=OZYk
-----END PGP SIGNATURE-----

--=-RjT1XOfeM6XyBQDVQbRT--
