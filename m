X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 20:54:17 +0100
Message-ID: <20061217195417.GI12411@admingilde.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612171401.10585.jnareb@gmail.com> <20061217134848.GH12411@admingilde.org> <200612171529.03165.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
NNTP-Posting-Date: Sun, 17 Dec 2006 19:54:25 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612171529.03165.jnareb@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34704>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw25W-0001tM-B8 for gcvg-git@gmane.org; Sun, 17 Dec
 2006 20:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751017AbWLQTyT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 14:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWLQTyT
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 14:54:19 -0500
Received: from mail.admingilde.org ([213.95.32.147]:42032 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751012AbWLQTyS (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 14:54:18 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gw25R-0007Z2-Ed; Sun, 17 Dec 2006 20:54:17 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Dec 17, 2006 at 03:29:02PM +0100, Jakub Narebski wrote:
> By the way, should this ref be in submodule, or in supermodule, e.g. in
> refs/modules/<name>/HEAD? And there is a problam _what_ branch should
> be that.

At the moment I simply use refs/heads/master of the submodule
repository, just because it is the default branch anyway.

In order to make the submodule refs which are not added to the
supermodule available to the supermodule anyway (for fsck and prune),
I added a symlink .git/refs/module/<submodule> -> <submodule>/.git/refs,
so that the submodule branch is also available as
refs/module/<submodule>/heads/master in the supermodule.

But I expect that all this setup stuff can be greatly simplified with a
little bit more knowledge of submodules in the core.  But this cleanup
is for later, when the basis is settled.

--=20
Martin Waitz

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFhaBpj/Eaxd/oD7IRAj7SAJ9dfq5GTKpCsFYZ4X+NsP5MFW4yeQCcDETw
PvW4j6qaWLHh/1eUgJtcRUE=
=TAUt
-----END PGP SIGNATURE-----

