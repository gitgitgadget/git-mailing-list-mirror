X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 16:12:23 +0100
Message-ID: <20061201151223.GB18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011212.35656.andyparkins@gmail.com> <20061201122854.GR18810@admingilde.org> <200612011411.20113.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tK3TaB1xs9ylLrl6"
NNTP-Posting-Date: Fri, 1 Dec 2006 15:12:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612011411.20113.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32935>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqA3v-0006qH-JG for gcvg-git@gmane.org; Fri, 01 Dec
 2006 16:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759111AbWLAPMY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 10:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759290AbWLAPMY
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 10:12:24 -0500
Received: from agent.admingilde.org ([213.95.21.5]:55256 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1759111AbWLAPMX
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 10:12:23 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqA3r-0006yM-3p; Fri, 01 Dec 2006 16:12:23 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--tK3TaB1xs9ylLrl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 02:11:19PM +0000, Andy Parkins wrote:
> If I've understood; while the objects themselves are stored in the
> supermodule ODB, they are still independent.  In fact, they're only in
> the supermodule tree because it's most convenient to keep them there;
> it sounds like it's very easy to strip them out again.

Yes.

> Again, if I'm understanding, it's a bit like when you have an
> additional root in a normal git repository, for example:
>
>  * -- * -- * -- * (project1)
>        \
>         * -- * -- * (project1/stable)
>
>    * -- * -- * -- * (project2)
>=20
> Then to make project2 a submodule of project1, one of the project1
> trees simply refers to a commit in project2.

Exactly.


--=20
Martin Waitz

--tK3TaB1xs9ylLrl6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcEZXj/Eaxd/oD7IRAgIBAJwL6ZNlnY5/qoDBTCBLLgSRU6roHQCfU/jW
W8WW2A/2q2H7AvJWwjAS5Q8=
=P7sU
-----END PGP SIGNATURE-----

