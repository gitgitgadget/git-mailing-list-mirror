X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: Subprojects tasks
Date: Mon, 18 Dec 2006 08:45:56 +0100
Message-ID: <20061218074556.GK12411@admingilde.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612171529.03165.jnareb@gmail.com> <20061217195417.GI12411@admingilde.org> <200612180027.25308.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
NNTP-Posting-Date: Mon, 18 Dec 2006 07:46:02 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612180027.25308.Josef.Weidendorfer@gmx.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34723>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwDCC-00089q-Uf for gcvg-git@gmane.org; Mon, 18 Dec
 2006 08:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753470AbWLRHp6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 02:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbWLRHp6
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 02:45:58 -0500
Received: from mail.admingilde.org ([213.95.32.147]:43627 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753470AbWLRHp5 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 02:45:57 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GwDC9-0004Wd-0g; Mon, 18 Dec 2006 08:45:57 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2006 at 12:27:25AM +0100, Josef Weidendorfer wrote:
> On Sunday 17 December 2006 20:54, Martin Waitz wrote:
> > I added a symlink .git/refs/module/<submodule> -> <submodule>/.git/refs,
> > so that the submodule branch is also available as
> > refs/module/<submodule>/heads/master in the supermodule.
>=20
> Ah.
> What is "<submodule>" in your implementation?
> Is this some encoding of the path where the submodule currently lives
> in the supermodule, or are you giving the submodules unique names
> in the context of the supermodule?

At the moment, it's just the path inside the parent.

--=20
Martin Waitz

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFhkc0j/Eaxd/oD7IRAtoCAJ9qIsU+7T9kJPfbpW6JKOYTElDDRQCffQN9
+iD3LYsdGI6udolAe/6pXHE=
=0GdE
-----END PGP SIGNATURE-----

