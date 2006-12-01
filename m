X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 23:12:30 +0100
Message-ID: <20061201221230.GM18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de> <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org> <200612012306.41410.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+8GP5RjC/E7LQ/F"
NNTP-Posting-Date: Fri, 1 Dec 2006 22:12:43 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612012306.41410.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32972>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqGcV-0001Wt-On for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162073AbWLAWMd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162074AbWLAWMc
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:12:32 -0500
Received: from agent.admingilde.org ([213.95.21.5]:43435 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1162073AbWLAWMc
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:12:32 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqGcQ-00025f-RU; Fri, 01 Dec 2006 23:12:30 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org


--k+8GP5RjC/E7LQ/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 11:06:40PM +0100, Josef Weidendorfer wrote:
> > Well, I would actually argue that you may often want to have a
> > supermodule and then at least have the _option_ to decide to not
> > fetch all the submodules.
>=20
> If you want to allow this, you have to be able to cut off fetching the
> objects of the supermodule at borders to given submodules, the ones you
> do not want to track. With "border" I mean the submodule commit in some
> tree of the supermodule.

I don't think this is something special to submodules.  There has been
interest in checking out only a part of the tree even before talking
about submodules and I really think this feature should be independent
to submodules.

--=20
Martin Waitz

--k+8GP5RjC/E7LQ/F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcKjOj/Eaxd/oD7IRAvFUAJ9LIuS4kAhj5RCTlcFQhcEd+H7E6ACdH4Nn
tVBwwO5QwdXmeQPsLtEvrYI=
=TcNK
-----END PGP SIGNATURE-----

