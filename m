X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 22:37:23 +0100
Message-ID: <20061201213722.GK18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612011917.19252.andyparkins@gmail.com> <20061201193802.GI18810@admingilde.org> <200612012104.39897.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e7MbhXUj+2isZwqc"
NNTP-Posting-Date: Fri, 1 Dec 2006 21:37:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612012104.39897.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32968>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqG4V-0004jS-Vv for gcvg-git@gmane.org; Fri, 01 Dec
 2006 22:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161912AbWLAVhZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 16:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161927AbWLAVhY
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 16:37:24 -0500
Received: from agent.admingilde.org ([213.95.21.5]:2956 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1161912AbWLAVhY
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 16:37:24 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqG4R-0001oZ-58; Fri, 01 Dec 2006 22:37:23 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--e7MbhXUj+2isZwqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 09:04:37PM +0000, Andy Parkins wrote:
> > It may be possible to use two object stores and still do the common
> > object traversal but I do not think that gives you any benefits.
>=20
> There is one benefit - you can git-clone the submodule just as you
> would if it were not a submodule.  In fact, from the submodule's point
> of view it knows nothing about the supermodule.

The submodule repository obviously has to able to reach all its objects.
This is easily doable with the shared object database.

So you can already clone the submodule standalone.

> I'm going to guess by reachability analysis, you mean that the
> submodule doesn't know that some of it's commits are referenced by the
> supermodule.  As I suggested elsewhere in the thread, that's easily
> fixed by making a refs/supermodule/commitXXXX file for each
> supermodule commit that references as particular submodule commit.

I wouldn't call this "easily".

--=20
Martin Waitz

--e7MbhXUj+2isZwqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcKCSj/Eaxd/oD7IRAn3EAJ0VWTFhN1VGs6/1e4WZ1GQecjRF6wCdHlzJ
6nQoz8Lvy7u2aLlFwnahJ/k=
=+u2r
-----END PGP SIGNATURE-----

