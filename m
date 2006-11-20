X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 00:29:07 +0100
Message-ID: <20061120232904.GC20736@admingilde.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
NNTP-Posting-Date: Mon, 20 Nov 2006 23:29:42 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31957>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmIZg-0002CO-0R for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030375AbWKTX3M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbWKTX3M
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:29:12 -0500
Received: from agent.admingilde.org ([213.95.21.5]:60298 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1030375AbWKTX3M
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:29:12 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmIZY-00049A-VJ; Tue, 21 Nov 2006 00:29:09 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Nov 20, 2006 at 03:05:47PM -0800, Linus Torvalds wrote:
> Now, to get everything to work seamlessly within such a commit thing=20
> might be a fair amount of work, but I'm not sure you even _need_ to. It=
=20
> might be ok to just say "subproject 'xyzzy' differs" in the diff, for=20
> example, and have some rudimentary support for "git status" etc talking=
=20
> about subprojects that need to be committed.

this is exactly the status of my implementation at the moment ;-)

Well, it does not yet explicitly tell that a subproject diffs,
but it just creates a diff of the two commit objects.

I guess we need some command line option to say if we only want
to know about that the submodule changes or if the diff should
recurse into it.

--=20
Martin Waitz

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFYjpAj/Eaxd/oD7IRApi7AJ0b+SQR5lTy9vMqE9xSBwIQ2D9YSACdHU/r
Fkl8UixrighAoR6io1Vpt4k=
=ySBz
-----END PGP SIGNATURE-----

