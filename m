X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 16:00:46 +0100
Message-ID: <20061201150045.GZ18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se> <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5iovQLtJQXc0+Hs"
NNTP-Posting-Date: Fri, 1 Dec 2006 15:01:13 +0000 (UTC)
Cc: sf <sf@b-i-t.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <457041AD.4010601@op5.se>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32931>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq9sg-0003aF-Gk for gcvg-git@gmane.org; Fri, 01 Dec
 2006 16:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759299AbWLAPAr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 10:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759285AbWLAPAr
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 10:00:47 -0500
Received: from agent.admingilde.org ([213.95.21.5]:34256 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1759299AbWLAPAq
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 10:00:46 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq9sc-0006sX-2s; Fri, 01 Dec 2006 16:00:46 +0100
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org


--q5iovQLtJQXc0+Hs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 03:52:29PM +0100, Andreas Ericsson wrote:
> >Remember: if you git-pull in the supermodule, you want to update the
> >whole thing, including all submodules.
> >
>=20
> Only if the new commits I pull into the supermodule DAG has commits=20
> which includes a new shapshot of the submodule, otherwise it wouldn't be=
=20
> necessary.

Of course.

But if the supermodule contains changes to the submodule, you still
have to change the submodule.  And this implies changing the submodule
HEAD or some branch.

--=20
Martin Waitz

--q5iovQLtJQXc0+Hs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcEOdj/Eaxd/oD7IRAjqjAJ9viCE8E9wRZrYePKZVX9uQe0IMdACeJ3Hd
gufJ4yRrIL+yPyXcTxsQbLE=
=Y8NO
-----END PGP SIGNATURE-----

