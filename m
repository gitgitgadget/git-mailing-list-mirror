X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 07:21:58 +0100
Message-ID: <20061121062158.GF20736@admingilde.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <7v4pstzmk5.fsf@assigned-by-dhcp.cox.net> <ejthuh$fn8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
NNTP-Posting-Date: Tue, 21 Nov 2006 06:22:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ejthuh$fn8$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31971>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmP1M-0001kR-5J for gcvg-git@gmane.org; Tue, 21 Nov
 2006 07:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934338AbWKUGWA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 01:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934339AbWKUGWA
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 01:22:00 -0500
Received: from agent.admingilde.org ([213.95.21.5]:51146 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S934338AbWKUGV7 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 01:21:59 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmP14-0007SL-DA; Tue, 21 Nov 2006 07:21:58 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Nov 21, 2006 at 01:42:22AM +0100, Jakub Narebski wrote:
> Perhaps it would be best to join those two subproject support
> solutions together: "bind" tree/commit mount header in commit
> object, and "commit" entry in a tree.

But which is the autoritative source then?
Does it give any more information?

The advantage in your proposal would be that submodules would
be visible immediately when looking at the commit,
without having to traverse the entire tree.
This may be worthwhile when showing the combined history of parent
and submodules.

But still this looks like "caching submodule information in the
commit object" and I do not know if we really want to do that.

--=20
Martin Waitz

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFYpsFj/Eaxd/oD7IRAot9AJ9YbToh3Ur2GGJsLukoM4IVWl2LAACePk9C
unoBHZm6JZ7vidffPz6BgTI=
=JtK2
-----END PGP SIGNATURE-----

