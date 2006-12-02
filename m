X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 21:58:53 +0100
Message-ID: <20061202205853.GW18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612020036.08826.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <200612021232.08699.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0612021144520.3476@woody.osdl.org> <20061202202103.GS18810@admingilde.org> <Pine.LNX.4.64.0612021245081.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7rOJgaucv5jay56"
NNTP-Posting-Date: Sat, 2 Dec 2006 20:59:05 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	sf <sf-gmane@stephan-feder.de>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612021245081.3476@woody.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33048>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqbwp-00040Q-Bk for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031792AbWLBU6z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031793AbWLBU6z
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:58:55 -0500
Received: from agent.admingilde.org ([213.95.21.5]:4042 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031792AbWLBU6y
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:58:54 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gqbwj-0004qH-9K; Sat, 02 Dec 2006 21:58:53 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


--w7rOJgaucv5jay56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 02, 2006 at 12:46:01PM -0800, Linus Torvalds wrote:
> On Sat, 2 Dec 2006, Martin Waitz wrote:
> >=20
> > What makes a submodule so special that now we suddenly have to store
> > those stuff in the object database?
>=20
> I'm not sure it is. I suspect a pure commit link with just a CVS-style=20
> "modules" file is sufficient. I'm just saying that I don't think it is=20
> _wrong_ to possibly want to expand it.

If we later see that we really want to have it we can always introduce
it later.  I don't think we should do it now if we don't see clear
benefits _now_.

So I was not against the link object itself (initially I wanted to do it
this way, too), only agains the information which was proposed to be
stored there.  Up to now I haven't found anything which makes sense to
store next to the submodule commit to define the identity of the
submodule.

--=20
Martin Waitz

--w7rOJgaucv5jay56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcekNj/Eaxd/oD7IRAm6GAJ9fSDOCaqo6Vzfy0hfno+8gnKwjkwCeLowl
jIlA052DVIa2TTBhAsI/sKk=
=aPhR
-----END PGP SIGNATURE-----

