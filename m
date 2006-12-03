X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 07:29:16 +0100
Message-ID: <20061203062916.GY18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612020017.44275.Josef.Weidendorfer@gmx.de> <20061202202428.GT18810@admingilde.org> <200612030155.09630.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cy0BeJHB1CR/AQ7b"
NNTP-Posting-Date: Sun, 3 Dec 2006 06:29:30 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612030155.09630.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33098>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqkqo-0000KQ-E4 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 07:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936673AbWLCG3T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 01:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936675AbWLCG3T
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 01:29:19 -0500
Received: from agent.admingilde.org ([213.95.21.5]:30139 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S936673AbWLCG3S (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 01:29:18 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gqkqi-00016e-Vg; Sun, 03 Dec 2006 07:29:17 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org


--cy0BeJHB1CR/AQ7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Dec 03, 2006 at 01:55:08AM +0100, Josef Weidendorfer wrote:
> On Saturday 02 December 2006 21:24, Martin Waitz wrote:
> > On Sat, Dec 02, 2006 at 12:17:44AM +0100, Josef Weidendorfer wrote:
> > > After some thinking, a submodule namespace even is important for chec=
king
> > > out only parts of a supermodule, exactly because the root of a submod=
ule
> > > potentially can change at every commit.
> >=20
> > have you ever thought about the idea that the location may be an
> > important thing to consider for your decision.
>=20
> Which decision, for what? Sorry, I do not understand.

to check out, or not to check out.

> What should such a general partial tree support look like? I suppose you
> want to configure paths which should not be checked out. As long as you
> say that a given submodule always has to exist at a given path, you are
> right: then, you can say: "Please, do not check out this submodule" which
> is the same as "Do not check out this path".=20

You could say something like "do not check out anything below "test/".
If then some submodule moves from "test/foo" to "build/foo", it will be
checked out, because this module is now not only used for testing, but
is needed for building in the new version of the supermodule.

--=20
Martin Waitz

--cy0BeJHB1CR/AQ7b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcm68j/Eaxd/oD7IRAl1CAJ4p7WpTQOSehAEMnLfzEoS8tl9F/ACfcCzj
YTk48P7CwW/5toA+w+VOmWo=
=tiVq
-----END PGP SIGNATURE-----

