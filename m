X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florent Thoumie <flz@xbsd.org>
Subject: Re: Problem with git-push
Date: Wed, 01 Nov 2006 19:57:15 +0000
Message-ID: <1162411035.93716.14.camel@localhost>
References: <1162306098.41547.4.camel@mayday.esat.net>
	 <7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tiEeu+9skTWmV7T4UAsJ"
NNTP-Posting-Date: Wed, 1 Nov 2006 18:58:11 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.8.1 FreeBSD GNOME Team Port 
X-Virus-Scanned: amavisd-new at xbsd.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30651>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfLHl-0007tl-7M for gcvg-git@gmane.org; Wed, 01 Nov
 2006 19:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992551AbWKAS56 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 13:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992554AbWKAS56
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 13:57:58 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:33753 "EHLO
 smtp3-g19.free.fr") by vger.kernel.org with ESMTP id S2992551AbWKAS55 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 13:57:57 -0500
Received: from smtp.xbsd.org (unknown [82.233.2.192]) by smtp3-g19.free.fr
 (Postfix) with ESMTP id C04354A385; Wed,  1 Nov 2006 19:57:47 +0100 (CET)
Received: from localhost (localhost.xbsd.org [127.0.0.1]) by smtp.xbsd.org
 (Postfix) with ESMTP id 711D81141F; Wed,  1 Nov 2006 19:57:47 +0100 (CET)
Received: from smtp.xbsd.org ([127.0.0.1]) by localhost (srv1.xbsd.org
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 73524-04; Wed,  1 Nov
 2006 19:57:21 +0100 (CET)
Received: from [193.120.13.130] (cream.xbsd.org [193.120.13.130]) by
 smtp.xbsd.org (Postfix) with ESMTP id A8655114F6; Wed,  1 Nov 2006 19:57:20
 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


--=-tiEeu+9skTWmV7T4UAsJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-31 at 15:39 -0800, Junio C Hamano wrote:

> A quick workaround until we sort this out would be:
>=20
>  - make sure all your developers have umask suitable for group
>    work (i.e. second octal-digit from the right should be zero
>    to give group members the same rights as you do).
>=20
>  - run "chmod g+w .git/objects/??" in the shared repository.

I thought I checked on the remote (guess I only looked at my local
repo), but that was it, wrong perms.

Sorry if this is a dumb question but assuming i did 3 successive
git-push's, why is the object name changing from a try to another?

Thanks for the answer.

Florent


--=-tiEeu+9skTWmV7T4UAsJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (FreeBSD)

iD8DBQBFSPwbMxEkbVFH3PQRAozTAJ9fphmrJdr+rLll7YJaBLEdp/pxfQCfY2M0
HFYXtCf7gzbHbO5DKFJjxCo=
=Ye+w
-----END PGP SIGNATURE-----

--=-tiEeu+9skTWmV7T4UAsJ--
