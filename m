X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 21:24:28 +0100
Message-ID: <20061202202428.GT18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <20061201221230.GM18810@admingilde.org> <200612020017.44275.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OFqRauS4h7B9gLIC"
NNTP-Posting-Date: Sat, 2 Dec 2006 20:24:44 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612020017.44275.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33043>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqbPV-0005q2-Ar for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162140AbWLBUYa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031781AbWLBUYa
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:24:30 -0500
Received: from agent.admingilde.org ([213.95.21.5]:26548 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031780AbWLBUYa
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:24:30 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqbPQ-0004cR-Rj; Sat, 02 Dec 2006 21:24:28 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org


--OFqRauS4h7B9gLIC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 02, 2006 at 12:17:44AM +0100, Josef Weidendorfer wrote:
> After some thinking, a submodule namespace even is important for checking
> out only parts of a supermodule, exactly because the root of a submodule
> potentially can change at every commit.

have you ever thought about the idea that the location may be an
important thing to consider for your decision.

Perhaps the submodule is now used for something else (this is why it was
moved) and that now you'd like to keep it?

Anyway, you can just create several supermodules or implement generic
partial tree support for git.  I do not see any reason to special case
submodules here.

--=20
Martin Waitz

--OFqRauS4h7B9gLIC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFceD8j/Eaxd/oD7IRAhVxAJ9Q2X8Ck0znmLAj6PbtvumpAA6ZzACeKStn
IHmDEApV/omkeTA8HfZPEz0=
=rgG0
-----END PGP SIGNATURE-----

