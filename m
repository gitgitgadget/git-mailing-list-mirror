X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 12:46:07 +0100
Message-ID: <20061201114607.GN18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011029.28059.andyparkins@gmail.com> <20061201104256.GQ12463MdfPADPa@greensroom.kotnet.org> <200612011102.17079.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/t6ASE28jIy1gGy9"
NNTP-Posting-Date: Fri, 1 Dec 2006 11:46:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612011102.17079.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32902>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq6qR-0004bZ-TE for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936471AbWLALqK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936472AbWLALqJ
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:46:09 -0500
Received: from agent.admingilde.org ([213.95.21.5]:57804 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S936471AbWLALqI (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:46:08 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq6qF-00058Z-Ei; Fri, 01 Dec 2006 12:46:07 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--/t6ASE28jIy1gGy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 11:02:15AM +0000, Andy Parkins wrote:
> On Friday 2006 December 01 10:42, Sven Verdoolaege wrote:
>=20
> > He showed it to you in the example.  The "submodule object" is the COMM=
IT
> > of the submodule itself.
>=20
> That's no different from mine.

Well, there simply is no proxy object inbetween.

> Is that commit in the submodule or the supermodule?

Well, logically that commit belongs to the submodule and is referenced
by the tree in the supermodule.
Phyisically it is stored in the projects object database which is
shared between the supermodule and all submodules (at least in my
implementation).

> I also want to know how we tell the difference between a
> commit-in-supermodule and a
> commit-in-supermodule-which-is-actually-in-submodule.

There is no difference.

--=20
Martin Waitz

--/t6ASE28jIy1gGy9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcBX/j/Eaxd/oD7IRAvjnAJ0bg7Sy47d82P9MI5PM3ch4uvp8JACfTP4b
T8IBure9Pq3xoukDAG62cqQ=
=gzlc
-----END PGP SIGNATURE-----

