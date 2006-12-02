X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 21:43:50 +0100
Message-ID: <20061202204350.GV18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <20061201220821.GL18810@admingilde.org> <200612021004.22236.andyparkins@gmail.com> <200612021450.46005.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hWA99UP51iQRyIL4"
NNTP-Posting-Date: Sat, 2 Dec 2006 20:44:02 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612021450.46005.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33045>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqbiF-0001P8-58 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031784AbWLBUnv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031785AbWLBUnv
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:43:51 -0500
Received: from agent.admingilde.org ([213.95.21.5]:34724 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031784AbWLBUnv
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:43:51 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqbiA-0004jr-Bs; Sat, 02 Dec 2006 21:43:50 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org


--hWA99UP51iQRyIL4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 02, 2006 at 02:50:45PM +0100, Josef Weidendorfer wrote:
> On Saturday 02 December 2006 11:04, Andy Parkins wrote:
> > > So what do you do with deleted submodules?
> > > You wouldn't want them to still sit around in your working directory,
> > > but you still have to preserve them.
> >=20
> > Now that is a tricky one.  Mind you, I think that problem exists for an=
y=20
> > implementation.  I haven't got a good answer for that.
>=20
> That suggests that it is probably better to separate submodule repositori=
es
> from their checked out working trees. Why not put the GITDIRs of the subm=
odules
> in subdirectories of the supermodules GITDIR instead?

Why not simply use a shared object database instead?

You can still have an alternative to some standalone bare repository of
the submodule if you do not like to store submodule objects in the
supermodule repository.

--=20
Martin Waitz

--hWA99UP51iQRyIL4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFceWGj/Eaxd/oD7IRAr9yAJ44AvADJrzop9x8qU1Rxg2V0Gfh4ACfXedl
iEu2oEEtux4KC6nqUBxwVFc=
=0FMe
-----END PGP SIGNATURE-----

