From: Keith Packard <keithp@keithp.com>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sat, 11 Feb 2006 20:11:49 -0800
Message-ID: <1139717510.4183.34.camel@evo.keithp.com>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
	 <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>
	 <1139685031.4183.31.camel@evo.keithp.com>  <43EEAEF3.7040202@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wqwhkGkMYB2aaSgQv2+h"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Feb 12 05:12:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F88b0-0007BC-DH
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 05:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWBLEMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 23:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWBLEMM
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 23:12:12 -0500
Received: from home.keithp.com ([63.227.221.253]:3340 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750984AbWBLEMM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2006 23:12:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 598CC130023;
	Sat, 11 Feb 2006 20:12:09 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 11357-03-2; Sat, 11 Feb 2006 20:12:09 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id EC96313001F; Sat, 11 Feb 2006 20:12:08 -0800 (PST)
Received: from evo.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id E4F6014001;
	Sat, 11 Feb 2006 20:12:08 -0800 (PST)
Received: from keithp by evo.keithp.com with local (Exim 4.60)
	(envelope-from <keithp@keithp.com>)
	id 1F88aW-0006jT-Uh; Sat, 11 Feb 2006 20:11:53 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43EEAEF3.7040202@op5.se>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15980>


--=-wqwhkGkMYB2aaSgQv2+h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-02-12 at 04:43 +0100, Andreas Ericsson wrote:

> A weird oddity; Cloning is faster over rsync, day-to-day pulling is not.

Precisely. If the protocol could deliver existing packs instead of
unpacking and repacking them, then git would be as fast as rsync and I
wouldn't have to worry about supporting two protocols.

--=20
keith.packard@intel.com

--=-wqwhkGkMYB2aaSgQv2+h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD7rWFQp8BWwlsTdMRAqt+AJ9ReuM8r6QSsqgrpc8T1V2meUnHlACcCv8B
CyfzKhNhjikYBRpk1XTefzw=
=kYuF
-----END PGP SIGNATURE-----

--=-wqwhkGkMYB2aaSgQv2+h--
