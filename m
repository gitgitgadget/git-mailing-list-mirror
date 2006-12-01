X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 17:57:08 +0100
Message-ID: <20061201165708.GE18810@admingilde.org>
References: <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se> <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se> <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iig7nzZQzi/oiJm2"
NNTP-Posting-Date: Fri, 1 Dec 2006 16:57:51 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45705A94.2070509@op5.se>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32946>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqBhK-00052l-0n for gcvg-git@gmane.org; Fri, 01 Dec
 2006 17:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031618AbWLAQ5L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 11:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031633AbWLAQ5K
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 11:57:10 -0500
Received: from agent.admingilde.org ([213.95.21.5]:56712 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031618AbWLAQ5J
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 11:57:09 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqBhE-0007pd-Ai; Fri, 01 Dec 2006 17:57:08 +0100
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org


--iig7nzZQzi/oiJm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2006 at 05:38:44PM +0100, Andreas Ericsson wrote:
> >But if the supermodule contains changes to the submodule, you still
> >have to change the submodule.  And this implies changing the submodule
> >HEAD or some branch.
> >
>=20
> Not really. I fail to see why HEAD needs to be changed so long as the=20
> commit is in the submodule's odb.

Because I want the submodule to act as a normal git repository.
Please note that I also voted against changing HEAD directly, but that
the new commit which came from the supermodule is just stored in one
branch of the submodule, as part of the supermodule checkout.

--=20
Martin Waitz

--iig7nzZQzi/oiJm2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcF7kj/Eaxd/oD7IRAn3jAJ9CzaL+kjzg8GMPa0m5iqSx63UW/QCaA6Fc
sJeqD4kCgqiaB017sd1/OYs=
=S/CJ
-----END PGP SIGNATURE-----

