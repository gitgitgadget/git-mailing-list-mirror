Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B081F6C1
	for <e@80x24.org>; Thu, 18 Aug 2016 14:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1950153AbcHROp5 (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 10:45:57 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:31876 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768039AbcHROpx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 10:45:53 -0400
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; t=1471531466; l=756;
	s=domk; d=aepfle.de;
	h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
	bh=z0j9oVi9HpVre1Z/LJHZcVcvO1/6TprE+odCeTELaJ8=;
	b=cmx446+hGa1QdUOhWhSGOjUskLQE3MhXpWPNfPdIEHA0wuPSN8Jz4WSGU9oGfsup7iF
	yG+YawWGOn19dQ/pEQN3JQFJYZbnYhdNxTK4hXbzHRIBTtGMphT55qN6oyND9SV7PFnPl
	9saBzNOuHvLAo1uGaDwEtGrv3fxgNo32xgc=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi5z/J1IL7CYRxLEwpkY2XtLzyRUcY=
X-RZG-CLASS-ID:	mo00
Received: from aepfle.de (nat.nue.novell.com [IPv6:2620:113:80c0:5::2222])
	by smtp.strato.de (RZmta 38.13 AUTH)
	with ESMTPSA id j0ae42s7IEiPIam
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <git@vger.kernel.org>;
	Thu, 18 Aug 2016 16:44:25 +0200 (CEST)
Date:	Thu, 18 Aug 2016 16:44:21 +0200
From:	Olaf Hering <olaf@aepfle.de>
To:	git@vger.kernel.org
Subject: git format-patch --break-rewrites broken in 2.9.3
Message-ID: <20160818144421.GA9062@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.6.2 (6759)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This command used to create a diff which can be consumed by patch. But
at least with 2.9.3 it just gives a rename output:

 git format-patch \
        --no-signature \
        --stdout \
        --break-rewrites \
        --keep-subject \
 95fa0405c5991726e06c08ffcd8ff872f7fb4f2d^..95fa0405c5991726e06c08ffcd8ff872f7fb4f2d


What must be done now to get a usable patch?

Olaf

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAle1ycEACgkQXUKg+qaYNn6yawCg2bE+BlmjgPJaUZ9PVrfdCmuh
FIMAn2Lrg59u3RHWrdmJ2PcaXJ7h9NEk
=8j5p
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
