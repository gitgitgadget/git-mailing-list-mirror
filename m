Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9765C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 22:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCBWQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjCBWQk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 17:16:40 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2949129E1C
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 14:16:39 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 420345A1AB;
        Thu,  2 Mar 2023 22:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1677795398;
        bh=cjwIYVB3Cr/54TYEmd/G4IX/tUEgiYhA1z2YjQxcYJg=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=B5c6qYISdy5rrxnKod1SO8ZXXqGPCDOWHkPdOUKXGYHkw2lFF1hBYSkezw0m7ZKcg
         9DtQacE/4GdcBth5lmndlHHuqIObE6v/BQTLEV5bM6vIvokpdFkZzWG29UJmrWS/FO
         bdRJvSQKwyQl6aOjS4WP92pC55r5veK5DMf37cNe/3dm8eIPSwAwPyZvulD2vExxAK
         RLstIx/Izcn2lj/S1Gsbe/nqDuBi1zj+SgQxNiKVz286S1yZv4BHh2HaeWHQhkJBGV
         jZ3TQQhlIekeVHcA2mHaidea4L9+ALQMEgSPo+9IGAIkT2k3CU5CmNL3k5ZBU4r5kV
         8iRlrMRhqAu7bOPvyxwa533tLqvKNK0A81FmOZeNRVsQfhdK00tGWZUxSgZSOo00QG
         6fzcyfD5l7vJ7yPWHST3d0ACIyjZqPDvHwDgTgNQJRL89lBQU72dSqkVlbMVx8r8Mp
         kO7u8/iuSOuERw2oPQItRMBTRcQTxzuImrGaeZDJNY1ToFWma5K
Date:   Thu, 2 Mar 2023 22:16:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Dinesh Dharmawardena <dinesh_dh@outlook.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Let us not call it git blame
Message-ID: <ZAEgRDelTlNZRJ5J@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Dinesh Dharmawardena <dinesh_dh@outlook.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <SY6P282MB3782FD975E6F39951C5A43DA92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
 <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mP+c4DptnwytltjP"
Content-Disposition: inline
In-Reply-To: <SY6P282MB378273980F5BC9084EEF74EF92B29@SY6P282MB3782.AUSP282.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mP+c4DptnwytltjP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-03-02 at 22:00:59, Dinesh Dharmawardena wrote:
> Hi
>=20
> I am writing to you to request that the term blame in git blame be replac=
ed with something that does not sound so blameful. I=E2=80=99m an SRE and w=
e actively try promote a blameless culture as such industry tooling should =
also follow suit imo. Progressively phasing this term out with a better ali=
as would be great.

I believe there's already an alias for it, git annotate, if you'd prefer
to use that.  The name "blame" came in with CVS, with the synonym
"annotate", so it's well understood, but you can use whichever alias you
prefer.

I do think there may some differences in the defaults between git
annotate and git blame, but if someone wanted to send in a patch for an
option to make annotate produce identical output to blame, then I think
it could be a full replacement.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--mP+c4DptnwytltjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZAEgRAAKCRB8DEliiIei
gTFBAP9bvJE1y3OqtDpEfyHjOb3iDOPbq3W/9hFBWPSMADLrFQD/QHeUP4fuO/F9
igU7thXThUfJKPLo+KiPj7/s5hV4CAE=
=7Cyo
-----END PGP SIGNATURE-----

--mP+c4DptnwytltjP--
