X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 00:07:32 +0100
Message-ID: <20061201230732.GO18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org> <200612012355.03493.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4mzJX4knSlzCkV+j"
NNTP-Posting-Date: Fri, 1 Dec 2006 23:07:44 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612012355.03493.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32982>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqHTl-0001i0-Es for gcvg-git@gmane.org; Sat, 02 Dec
 2006 00:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161145AbWLAXHf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 18:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWLAXHe
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 18:07:34 -0500
Received: from agent.admingilde.org ([213.95.21.5]:38860 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1161145AbWLAXHe
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 18:07:34 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqHTg-0002dx-I6; Sat, 02 Dec 2006 00:07:32 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org


--4mzJX4knSlzCkV+j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 11:55:03PM +0100, Josef Weidendorfer wrote:
> What about my other argument for a submodule namespace:
> You want to be able to move the relative root path of a submodule
> inside of your supermodule, but yet want to have a unique name
> for the submodule:
> - to be able to just clone a submodule without having to know
> the current position in HEAD
> - more practically, e.g. to be able to name a submodule
> independent from any current commit you are on in the supermodule,
> e.g. to be able to store some meta information about a submodule:
> - "Where is the official upstream of this submodule?"

you can always have a bare repository for all used modules lying around
in some defined location.  There is no need for a unique submodule-name.

--=20
Martin Waitz

--4mzJX4knSlzCkV+j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcLWzj/Eaxd/oD7IRAr15AJ0cg59w49qpcBt6CaD1w79gp72xxACfXqFO
j3/E/HE4bm2f0TS10ISbxpA=
=KuSw
-----END PGP SIGNATURE-----

