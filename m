X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 08:55:38 +0100
Message-ID: <20061121075538.GH20736@admingilde.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <7v4pstzmk5.fsf@assigned-by-dhcp.cox.net> <20061121062753.GG20736@admingilde.org> <7vr6vxxnc8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
NNTP-Posting-Date: Tue, 21 Nov 2006 07:56:11 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vr6vxxnc8.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31977>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmQU6-0003OZ-0S for gcvg-git@gmane.org; Tue, 21 Nov
 2006 08:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966896AbWKUHzl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 02:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966909AbWKUHzk
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 02:55:40 -0500
Received: from agent.admingilde.org ([213.95.21.5]:18316 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S966896AbWKUHzj (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 02:55:39 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmQTi-0008NM-9t; Tue, 21 Nov 2006 08:55:38 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Nov 20, 2006 at 11:36:55PM -0800, Junio C Hamano wrote:
> I think that is fine as long as we somehow enforce the topology
> of submodule to be similar to the toplevel topology.  Otherwise
> I suspect it leads to unintuitive behaviour.
>=20
> Suppose that the ancestry chain for the toplevel are A, A~1, A~2
> and you asked for "A~2..A".  A submodule is bound at tree "sub/"
> and suppose A:sub/ =3D=3D B, A~1:sub/ =3D=3D C, and A~2:sub/ =3D=3D D.
>=20
> Now further suppose the ancestry chain for B, C and D are like
> this:
>=20
>               o---C
>              /     \
>      ...o---o---D---B
>=20
> A naive implementation of "--objects A~2..A" would propagate
> UNINTERESTING to D and mark B and C unmarked.  Would it however
> be reasonable to include commits marked as 'o'?

I think it is reasonable to just go on as in a normal repository.
That is, pretend we want to list D..B and mark all commits which
are reachable.

--=20
Martin Waitz

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFYrD6j/Eaxd/oD7IRAhzDAJ40EPMAEC2foddZrTrAHp5m0FORowCeLFme
BakdgOKQTO8iAuAa0rnUWsU=
=ErGz
-----END PGP SIGNATURE-----

