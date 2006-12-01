X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 23:08:21 +0100
Message-ID: <20061201220821.GL18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612012104.39897.andyparkins@gmail.com> <20061201213722.GK18810@admingilde.org> <200612012154.33834.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uvMug2t/eFzFwVce"
NNTP-Posting-Date: Fri, 1 Dec 2006 22:08:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612012154.33834.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32971>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqGYU-0000sh-0k for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162055AbWLAWIX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162058AbWLAWIX
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:08:23 -0500
Received: from agent.admingilde.org ([213.95.21.5]:29825 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1162055AbWLAWIW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:08:22 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqGYP-00023Y-GL; Fri, 01 Dec 2006 23:08:21 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--uvMug2t/eFzFwVce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 09:54:32PM +0000, Andy Parkins wrote:
> On Friday 2006, December 01 21:37, Martin Waitz wrote:
>=20
> > > I'm going to guess by reachability analysis, you mean that the
> > > submodule doesn't know that some of it's commits are referenced by the
> > > supermodule.  As I suggested elsewhere in the thread, that's easily
> > > fixed by making a refs/supermodule/commitXXXX file for each
> > > supermodule commit that references as particular submodule commit.
> >
> > I wouldn't call this "easily".
>=20
> Of course it is; when you write a supermodule commit you have it's hash,=
=20
> $SUPERMODULE_HASH, you have the commit-hash of the submodule commit you'r=
e=20
> referencing, $SUBMODULE_HASH.  It's not really hard to do
>=20
> echo $SUBMODULE_HASH >=20
> submodule/.git/refs/supermodules/commit$SUPERMODULE_HASH

I guess you are aware that you have to scan _all_ trees inside _all_
supermodule commits for possible references.

So what do you do with deleted submodules?
You wouldn't want them to still sit around in your working directory,
but you still have to preserve them.

--=20
Martin Waitz

--uvMug2t/eFzFwVce
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcKfVj/Eaxd/oD7IRAkj1AJ9Z+XGe2glbswKtHAnjVzN4EQ4emQCfeg4Y
NosrQSYRvwOvEmJNDf7SFPY=
=Mnco
-----END PGP SIGNATURE-----

