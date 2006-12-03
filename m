X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 21:46:44 +0100
Message-ID: <20061203204644.GZ18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <4570AF8F.1000801@stephan-feder.de> <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org> <200612020036.08826.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <20061202201826.GR18810@admingilde.org> <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="muH0jftA0RW8bb09"
NNTP-Posting-Date: Sun, 3 Dec 2006 20:47:06 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612021242080.3476@woody.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33142>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqyEn-0005He-ET for gcvg-git@gmane.org; Sun, 03 Dec
 2006 21:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760087AbWLCUqr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 15:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757961AbWLCUqq
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 15:46:46 -0500
Received: from agent.admingilde.org ([213.95.21.5]:31707 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1760087AbWLCUqq
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 15:46:46 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqyEW-0007rN-L5; Sun, 03 Dec 2006 21:46:44 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


--muH0jftA0RW8bb09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 02, 2006 at 12:44:20PM -0800, Linus Torvalds wrote:
> And watch the memory usage.

hmm, really sad, it was such a nice concept until now...
You are right, I have to think more about scalability. O(N) anywhere is
really bad for submodules.  They really should be able to bundle the kernel,
mozilla, qt and whatnot into one project and that will get huge.

--=20
Martin Waitz

--muH0jftA0RW8bb09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcze0j/Eaxd/oD7IRApyxAJ9aaaovXI2kWWu4SCPbaKQ++Z0f5gCcCKeu
gx34fc8D6A3lZDyTzWUAbOA=
=n2s2
-----END PGP SIGNATURE-----

