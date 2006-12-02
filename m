X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 21:21:03 +0100
Message-ID: <20061202202103.GS18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612020036.08826.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <200612021232.08699.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612021144520.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ewIlFbbLnYFKahON"
NNTP-Posting-Date: Sat, 2 Dec 2006 20:21:20 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612021144520.3476@woody.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33042>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqbME-00059u-Ia for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:21:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161346AbWLBUVH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031779AbWLBUVH
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:21:07 -0500
Received: from agent.admingilde.org ([213.95.21.5]:22196 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031777AbWLBUVE
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:21:04 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqbM7-0004at-6p; Sat, 02 Dec 2006 21:21:03 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


--ewIlFbbLnYFKahON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 02, 2006 at 11:52:13AM -0800, Linus Torvalds wrote:
> I don't think it would be wrong at all to have a "link object" type, and=
=20
> have the "link" tree entry actually point to that "link object" instead o=
f=20
> pointing directly to the commit in the submodule.
>=20
> And yes, that extra indirection would allow for more flexibility (the=20
> "link object" can contain comments about the particular version used,=20
> pointers to where you can get it - whether human-readable or strictly=20
> meant for automation - etc etc).

What makes a submodule so special that now we suddenly have to store
those stuff in the object database?

Storing a fetch location would grossly contradict the distributed nature
of git.  I really do not see _any_ reason to store more information than
the commit sha1 of the submodule.

--=20
Martin Waitz

--ewIlFbbLnYFKahON
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFceAvj/Eaxd/oD7IRApb3AJ9PwoVV/HqAGZNJJuZjbNOpvKqxRwCePyRO
waPSV092xrhv6YuuF3RQzLM=
=RPVd
-----END PGP SIGNATURE-----

