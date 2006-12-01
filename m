X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 13:11:10 +0100
Message-ID: <20061201121110.GP18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se> <45701A24.5060500@b-i-t.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f9b3biUB1f7FHqGn"
NNTP-Posting-Date: Fri, 1 Dec 2006 12:11:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45701A24.5060500@b-i-t.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32907>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7Eo-0002WR-Dv for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030905AbWLAMLM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030917AbWLAMLM
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:11:12 -0500
Received: from agent.admingilde.org ([213.95.21.5]:48362 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1030915AbWLAMLL
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:11:11 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gq7EU-0005LK-DA; Fri, 01 Dec 2006 13:11:10 +0100
To: sf <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org


--f9b3biUB1f7FHqGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 01:03:48PM +0100, sf wrote:
> Andreas Ericsson wrote:
> 2. You can never prune the main (the supermodule's) repository, at least=
=20
> not with what git provides today.

It even already works (well, not with what git provides today, but with
my implementation). git-prune simply walks all the submodules, too, when
doing it's reachability analysis.

What does not work is a prune inside the submodule, because it does not
know about all the commits used by the supermodule.

--=20
Martin Waitz

--f9b3biUB1f7FHqGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcBvej/Eaxd/oD7IRAq/kAJ4uTjNb+W3fGcL94cUdwMyvXqAvgwCff014
21idO+IiiKa1YrT4LHiVBy8=
=Ursm
-----END PGP SIGNATURE-----

