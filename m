X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 07:27:53 +0100
Message-ID: <20061121062753.GG20736@admingilde.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <7v4pstzmk5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
NNTP-Posting-Date: Tue, 21 Nov 2006 06:28:05 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v4pstzmk5.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31972>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmP6s-0002qp-Kn for gcvg-git@gmane.org; Tue, 21 Nov
 2006 07:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934347AbWKUG14 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 01:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934348AbWKUG1z
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 01:27:55 -0500
Received: from agent.admingilde.org ([213.95.21.5]:734 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S934347AbWKUG1z (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 01:27:55 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmP6n-0007Ur-Bc; Tue, 21 Nov 2006 07:27:53 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Nov 20, 2006 at 04:10:50PM -0800, Junio C Hamano wrote:
> However, if I recall correctly, it was rather nightmarish to
> make this also work for reachability traversal necessary for
> pack generation.  It was painful enough even when the bind was
> at the commit level (which was way simpler to handle), but to do
> this the right way, the bind needs to be done at the tree level,
> and "rev-list --objects foo..bar" would need some way to limit
> the commit ancestry chain of subproject at the same time, by
> computing the commit ancestry of the embedded commits in the
> trees.

This at least seems to work already.
The UNINTERESTING flag is recursively set for the submodule
commits while walking the object chain.

But I must admit that I only did very simple tests up to now.
Do you have any special constellations in mind which were
difficult to support?

--=20
Martin Waitz

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFYpxpj/Eaxd/oD7IRAurHAJ4oCdOl7EKEoL5bT0nWhTySEzlzsQCdF+63
oyXcZZdRxb6weESZP9vTQz0=
=Ofq+
-----END PGP SIGNATURE-----

