X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 23:40:22 +0100
Message-ID: <20061201224021.GN18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612012306.41410.Josef.Weidendorfer@gmx.de> <20061201221230.GM18810@admingilde.org> <200612012326.22779.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lPld9KzQhYxXHcUh"
NNTP-Posting-Date: Fri, 1 Dec 2006 22:40:33 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf@b-i-t.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612012326.22779.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32978>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqH3T-0005r7-91 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 23:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031774AbWLAWkX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 17:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935586AbWLAWkX
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 17:40:23 -0500
Received: from agent.admingilde.org ([213.95.21.5]:60567 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031774AbWLAWkX
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 17:40:23 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqH3O-0002IL-2p; Fri, 01 Dec 2006 23:40:22 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org


--lPld9KzQhYxXHcUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 11:26:22PM +0100, Josef Weidendorfer wrote:
> It's not about checking out part of the tree, it's about fetching only
> part of the objects: If you have a slow modem and want to clone a
> supermodule, you are not interested in fetching all the objects from
> some submodules.

So when you want to suppress one submodule, how is this not about only
checking out part of the tree?
Ok, you also want to avoid downloading the submodule, but you first have
to solve the partial checkout.

> BTW: In your submodule implementation, is the user allowed to change the
> relative path of the root of some submodule, e.g. with "git-mv" ?

In principle: yes.
However there are some links between both repositories that have to be
updated manually (for the shared object repository and for ignoring
submodule files in the supermodule).
But I expect that much of this configuration stuff will vanish when
submodules are better integrated in git.

Rename detection for submodules would be another interesting thing to
have. It should be much easier as for files because we can simply check
for common ancestors and do not have to guess based on the diff.

--=20
Martin Waitz

--lPld9KzQhYxXHcUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcK9Vj/Eaxd/oD7IRAi+KAJ9KmRHCgHD51Tm6vzyzpuXxFWMIpACeLzWZ
EBMGW+Ukjzh4v1ruLNHfMLs=
=k/pm
-----END PGP SIGNATURE-----

