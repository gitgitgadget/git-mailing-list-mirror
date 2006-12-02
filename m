X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 22:06:40 +0100
Message-ID: <20061202210640.GX18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <4570AF8F.1000801@stephan-feder.de> <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org> <200612020036.08826.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <20061202201826.GR18810@admingilde.org> <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ttZyFY8Q/ImP0sT1"
NNTP-Posting-Date: Sat, 2 Dec 2006 21:06:54 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33051>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqc4K-00052y-LL for gcvg-git@gmane.org; Sat, 02 Dec
 2006 22:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162471AbWLBVGm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 16:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162475AbWLBVGm
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 16:06:42 -0500
Received: from agent.admingilde.org ([213.95.21.5]:34529 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1162471AbWLBVGl
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 16:06:41 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gqc4G-0004uT-8X; Sat, 02 Dec 2006 22:06:40 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


--ttZyFY8Q/ImP0sT1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 02, 2006 at 12:44:20PM -0800, Linus Torvalds wrote:
> On Sat, 2 Dec 2006, Martin Waitz wrote:
> >=20
> > I don't buy your scalability argument.
>=20
> Try it.
>=20
> Really. Get the mozilla import (450MB project), and clone it on a machine=
=20
> with half a gig of RAM or less.
>=20
> Then, clone a couple of smaller archives that end up being 450MB=20
> _combined_, but clone them separately.
>=20
> And watch the memory usage.

Do I understand you correctly that the problem is not the algorithmic
complexity but that you have to map the objects at once instead of map
them in small parts one after the other?

--=20
Martin Waitz

--ttZyFY8Q/ImP0sT1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcergj/Eaxd/oD7IRAkkXAJ4qENe8tB7Be2H0GsWmIdttkk0jjwCZAeUp
5jWZfSXTzSGmVyFojrU+h0U=
=jzWh
-----END PGP SIGNATURE-----

