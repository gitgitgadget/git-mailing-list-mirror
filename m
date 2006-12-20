X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit hooks
Date: Wed, 20 Dec 2006 14:36:48 +0100
Message-ID: <20061220133648.GQ12411@admingilde.org>
References: <200612201309.02119.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MsEL38XAg4rx1uDx"
NNTP-Posting-Date: Wed, 20 Dec 2006 13:37:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612201309.02119.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34927>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx1d3-0001MF-2j for gcvg-git@gmane.org; Wed, 20 Dec
 2006 14:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965049AbWLTNgu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 08:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWLTNgu
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 08:36:50 -0500
Received: from mail.admingilde.org ([213.95.32.147]:43471 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965049AbWLTNgt (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 08:36:49 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gx1cm-0000oH-MZ; Wed, 20 Dec 2006 14:36:48 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--MsEL38XAg4rx1uDx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Dec 20, 2006 at 01:09:01PM +0000, Andy Parkins wrote:
>=20
> You've now got poor-man's submodule support.  Any commits to the
> submodule will change the hash and hence the .gitmodules file will be
> different and therefore will show up as "modified" to git.

I started with something similiar, too.
You can have a look at http://git.admingilde.org/tali/git.git/module
which tries to implement submodules without changing the core.

--=20
Martin Waitz

--MsEL38XAg4rx1uDx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFiTxwj/Eaxd/oD7IRAjmeAJsEEsh0Py+a/J7O7W2TJVpA0D7gxwCfUPmQ
tGRPT9rEkhvAyoigb1fWTTQ=
=3IYG
-----END PGP SIGNATURE-----

