X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 20:32:48 +0100
Message-ID: <20061121193248.GJ20736@admingilde.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <20061120232507.GH12285@fieldses.org> <20061120233333.GD20736@admingilde.org> <20061121180127.GB27221@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="va4/JQ6j8/8uipEp"
NNTP-Posting-Date: Tue, 21 Nov 2006 19:33:03 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061121180127.GB27221@fieldses.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32027>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmbMU-0006Cv-0u for gcvg-git@gmane.org; Tue, 21 Nov
 2006 20:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031333AbWKUTcv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 14:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031334AbWKUTcv
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 14:32:51 -0500
Received: from agent.admingilde.org ([213.95.21.5]:14484 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031333AbWKUTcu
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 14:32:50 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmbMO-0005Yn-PI; Tue, 21 Nov 2006 20:32:48 +0100
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org


--va4/JQ6j8/8uipEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2006 at 01:01:27PM -0500, J. Bruce Fields wrote:
> On Tue, Nov 21, 2006 at 12:33:34AM +0100, Martin Waitz wrote:
> > On Mon, Nov 20, 2006 at 06:25:07PM -0500, J. Bruce Fields wrote:
> > > Would it also be possible to allow the "Tree:" line in the commit obj=
ect
> > > to refer to a commit, or does the root of the project need to be a
> > > special case?
> >=20
> > this would then be something like the branch-archival proposal.
>=20
> Do you have any pointers to previous discussion?  (A couple obvious
> searches don't turn up anything for me.)

Aug 04 Eric W. Biederman    [RFC][PATCH] Branch history

I really think that using subprojects can be used for this workflow, too.
But adding a submodule directly to the root is not really possible,
we'd have to use special user interfaces for that, even when the
git-core might be able to handle it.
But what might be possible is to have one toplevel history-tracking
repository in e.g. ~/src and then add all the repositories you work
with as a submodule.  Whenever you want to record the history of
some project, you can simply commit it to ~/src.

--=20
Martin Waitz

--va4/JQ6j8/8uipEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFY1Rgj/Eaxd/oD7IRAgxMAJ9Et/iW0pXO/F8aHiaTtJym9ant6QCfS5N9
v87Q5LagD+pHIgxhmiLIwxE=
=Irpg
-----END PGP SIGNATURE-----

