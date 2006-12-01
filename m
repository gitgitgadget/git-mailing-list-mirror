X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 13:34:47 +0100
Message-ID: <20061201123447.GS18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011102.17079.andyparkins@gmail.com> <20061201114607.GN18810@admingilde.org> <200612011216.04555.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XAEV7zm15O60d1Zf"
NNTP-Posting-Date: Fri, 1 Dec 2006 12:36:08 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612011216.04555.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32914>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7c4-00085P-FX for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:35:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031212AbWLAMeu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031214AbWLAMeu
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:34:50 -0500
Received: from agent.admingilde.org ([213.95.21.5]:11932 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031212AbWLAMes
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:34:48 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq7bL-0005XK-Ev; Fri, 01 Dec 2006 13:34:47 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--XAEV7zm15O60d1Zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 12:16:00PM +0000, Andy Parkins wrote:
> That's fine, I was only using the proxy object to allow additional
> information into the submodule object.  Actually, I think it would
> always be better to use a proxy object otherwise you have an error in
> the tree object, because it will refer to an object that does not
> exist.  The proxy object is allowed to refer to objects that don't
> exist because it's not a tree object.

It is exactly the aim of my implementation to not have any reference to
something that is not accessible in the supermodule repository.

> > > Is that commit in the submodule or the supermodule?
> >
> > Well, logically that commit belongs to the submodule and is referenced
> > by the tree in the supermodule.
> > Phyisically it is stored in the projects object database which is
> > shared between the supermodule and all submodules (at least in my
> > implementation).
>=20
> Hmmm, "shared"?  It must still be in the submodule physically though,
> and presumably the supermodule uses alternatives to get access to it?
> Otherwise the submodule will be impossible to separate from the
> supermodule.

Yes, you can't separate it my just moving it out of the supermodule,
but you can always clone the submodule alone.

> Okay.  I think I'm still a bit lost then.  I suppose I'll wait for your
> patches to understand.

have a look at http://git.admingilde.org/tali/git.git/module2.
If you want to try it out, have a look at t/t7500-submodule.sh on how to
create submodules.

--=20
Martin Waitz

--XAEV7zm15O60d1Zf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcCFnj/Eaxd/oD7IRAh4cAJ9B8+wW+Gc3XB9LxFgsJZo0RU9RXgCfcfgD
C0QCUjVtp1dPADW65ee9550=
=IB6M
-----END PGP SIGNATURE-----

