From: Keith Packard <keithp@keithp.com>
Subject: Re: [RFC] Make dot-counting ignore ".1" at the end
Date: Wed, 22 Mar 2006 23:17:50 -0800
Message-ID: <1143098270.6850.29.camel@neko.keithp.com>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org>
	 <Pine.LNX.4.64.0603221746300.26286@g5.osdl.org>
	 <1143095182.6850.23.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0603222232210.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-J3MKJ6sGm1ptNnGdgAqG"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 23 08:18:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMK5L-0005ON-Ps
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 08:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290AbWCWHSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 02:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965291AbWCWHSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 02:18:16 -0500
Received: from home.keithp.com ([63.227.221.253]:23819 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S965290AbWCWHSQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 02:18:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id BE2AD130020;
	Wed, 22 Mar 2006 23:18:14 -0800 (PST)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 02219-03; Wed, 22 Mar 2006 23:18:14 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1033)
	id 0888B13001F; Wed, 22 Mar 2006 23:18:13 -0800 (PST)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id D0AC214001;
	Wed, 22 Mar 2006 23:18:13 -0800 (PST)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 4FD8E6AC1BF; Wed, 22 Mar 2006 23:17:51 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603222232210.26286@g5.osdl.org>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17857>


--=-J3MKJ6sGm1ptNnGdgAqG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-22 at 22:34 -0800, Linus Torvalds wrote:

> With that in place (the "make sure we have a proper ancestor branch"=20
> thing), a "git cvsimport" of the binutils tree seems to be working, at=20
> least to the point that it seems to have imported 1400+ commits without=20
> undue complaints. But hey, I'm looking forward to something less=20
> hacked-together.

Yeah, me too. Attempts at importing some of the X.org trees have
resulted in 'less than ideal' repositories.

I stuck a couple of hacks in cvsps myself to get it to deal with=20
X.org trees; the first was to increase a static buffer to 'large enough'
to hold X.org-style commit messages (which are enormous).

http://gitweb.freedesktop.org/?p=3Dfreedesktop-cvsps;a=3Dsummary

shows both minor patches. I should have let people know about these
earlier...

--=20
keith.packard@intel.com

--=-J3MKJ6sGm1ptNnGdgAqG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEIkueQp8BWwlsTdMRAjLeAJ40vdgRECN1VVizl+Gqt6T4t9bwGQCfSAtb
gfaW1Pg/64gDIVniEHlkOMc=
=oSdP
-----END PGP SIGNATURE-----

--=-J3MKJ6sGm1ptNnGdgAqG--
