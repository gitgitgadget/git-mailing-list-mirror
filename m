X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 21:12:42 +0100
Message-ID: <20061202201242.GQ18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de> <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org> <4570AF8F.1000801@stephan-feder.de> <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PVGnt3hziMCGXk95"
NNTP-Posting-Date: Sat, 2 Dec 2006 20:12:59 +0000 (UTC)
Cc: sf <sf-gmane@stephan-feder.de>, sf <sf@b-i-t.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33038>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqbED-0003P9-6F for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031735AbWLBUMo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031762AbWLBUMo
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:12:44 -0500
Received: from agent.admingilde.org ([213.95.21.5]:3782 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031735AbWLBUMn
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:12:43 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqbE2-0004Wq-Df; Sat, 02 Dec 2006 21:12:42 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


--PVGnt3hziMCGXk95
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 03:09:40PM -0800, Linus Torvalds wrote:
> On Fri, 1 Dec 2006, sf wrote:
> > If you do not want to fetch all of the supermodule then do not fetch the
> > supermodule.
>=20
> So why do you want to limit it? There's absolutely no cost to saying "I=
=20
> want to see all the common shared infrastructure, but I'm actually only=
=20
> interested in this one submodule that I work with".

An interesting way to support this "only fetch some modules" use-case is
to use several supermodules.

So you could have one supermodule which is geared towards developers and
only contains the modules they use.  Another supermodule contails all
the toolchain sources.  And then there is the supermodule used for
releases which is just a merge of all the other supermodules.

The concept is so flexible that you don't have to introduce lots of
other things as module namespaces.  Just use the tools you have in a
creative way ;-)

--=20
Martin Waitz

--PVGnt3hziMCGXk95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcd46j/Eaxd/oD7IRAgR7AJwPmCF2IidSF4cVj+bC4kPfKsNkowCdGUP8
UJAnseC/u6kPxRwIBmeImzc=
=vj+U
-----END PGP SIGNATURE-----

