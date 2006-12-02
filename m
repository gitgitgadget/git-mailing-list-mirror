X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 21:18:26 +0100
Message-ID: <20061202201826.GR18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <4570AF8F.1000801@stephan-feder.de> <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org> <200612020036.08826.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXAqmCxJPvkQLT2P"
NNTP-Posting-Date: Sat, 2 Dec 2006 20:18:36 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33041>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqbJe-0004Xj-ET for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031762AbWLBUS2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031777AbWLBUS2
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:18:28 -0500
Received: from agent.admingilde.org ([213.95.21.5]:51645 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031762AbWLBUS1
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:18:27 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqbJa-0004Zr-By; Sat, 02 Dec 2006 21:18:26 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


--AXAqmCxJPvkQLT2P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 04:12:10PM -0800, Linus Torvalds wrote:
> It only gets interesting for commands that fetch new objects, ie do a=20
> "pull/fetch" op, and you'd need to know where/how to fetch new objects fo=
r=20
> the xyzzy subproject, so that's a "naming" issue. You have a few choices:
>=20
>  - get all the objects directly from the subproject as if it was one big=
=20
>    project.
>=20
>    I actually think this sucks. Why? Because it puts an insane load on th=
e=20
>    server side, which basically needs to traverse the object list of the=
=20
>    _sum_ of all projects. An initial clone (or a really big pull, which=
=20
>    comes to the same thing) would be absolutely horrendous

I don't buy your scalability argument.
By dividing the object traversal in separate steps you do not win
anything.  The complexity of the operation still stays the same, as you
still have to traverse the exact same amount of objects.

By separating the repositories you just make reachability analyis be
totally awkward, without winning anything.

--=20
Martin Waitz

--AXAqmCxJPvkQLT2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcd+Sj/Eaxd/oD7IRAikDAKCCUEFmVNvoTFD9ieksQGAsxH5b2wCbBr3P
m8knHdN5cvTE+uxPKZItBGY=
=r77N
-----END PGP SIGNATURE-----

