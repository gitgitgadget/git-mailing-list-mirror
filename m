X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 00:52:56 +0100
Message-ID: <20061120235256.GE20736@admingilde.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <ejtc3e$tod$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
NNTP-Posting-Date: Mon, 20 Nov 2006 23:53:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ejtc3e$tod$2@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31961>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmIwf-0007Z3-6P for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966883AbWKTXw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966880AbWKTXw5
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:52:57 -0500
Received: from agent.admingilde.org ([213.95.21.5]:47531 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S966883AbWKTXw5 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:52:57 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GmIwa-0004LP-Bq; Tue, 21 Nov 2006 00:52:56 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Nov 21, 2006 at 12:02:34AM +0100, Jakub Narebski wrote:
> By the way, what permissions get the subproject tree?

In my approach no permissions are saved in the object database,
only the special bit to mark the submodule.
When checking out, the directory is created 0777 modulo umask,
just as other directories.  Then the submodule contents
are checked out with their normal permissions.

--=20
Martin Waitz

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFYj/Yj/Eaxd/oD7IRAniXAJ4zZPGwTPLojG9cnGNGsXcqUjAsxQCff3hp
uW75d8QDLAFvlidV1Yy6nwc=
=FvQi
-----END PGP SIGNATURE-----

