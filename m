Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B81EB64D7
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 00:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjFVA7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 20:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFVA7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 20:59:11 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE9197
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 17:59:10 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 30B4B5A1A8;
        Thu, 22 Jun 2023 00:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687395550;
        bh=wKt380P15+1prv/cxNbVrra1urpm50Fzfl8o3sAnxqw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oPk5R47GDCHNQ9KC1LgluNVmhDV15aS4XLKikUM8xshkEtYZQUi9VBV3s9Fwc1V/6
         jEN93RTHMs4dP7zMUU8Gmo9oxdidMIDCQRZKu0F1BrbTIndhmcCc/Oa3hJJFN8mslY
         bKA5u/8PWANOpRjkMUyp3JQvAE2HSw0b3mPd63vsegxnLCUhQVsQm8RSyMA9y5oIHW
         OZpbks3jiILMg/x9huj3bxexJUu6+EcVXwMIbwEKsMs1k7IeuugayhWlTSSjoUyAJW
         JMjkMbJS2HSxBDvM1pKjcZlx2KdeZFRGxsFiIHyEZFBu6oOaB3/16eE1sqoAxsA58N
         uX1DwP1nHCKfcUT3wrCRr973cWJO/gJfP8YgOT8Vl6wfC9lMMSuuQ3FjwTw5+7uY79
         ZQEKiFrqMG/may9YJ0v7ZD77wYSVRBLLh3ibEnC/JQlYfvGd06pcEB/02rfwIysVCe
         8KV2X5mEfkRtcYGiNwrBDTMGKKrg8VGNZnP0F3TjhUxJ6T2TbH/
Date:   Thu, 22 Jun 2023 00:59:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] docs: add git-hash-object -t option's possible values
Message-ID: <ZJOc3Kd0vEEO6bUr@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
References: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wkLjcrrfqAvxa9nx"
Content-Disposition: inline
In-Reply-To: <pull.1533.git.git.1687394795009.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wkLjcrrfqAvxa9nx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-22 at 00:46:34, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>=20
> For newer users of Git, the possible values of -t in git-hash-object may
> not be apparent. In fact the current verbiage under NAME could
> lead one to conclude that git-hash-object(1) can only be used to create
> blobs.
>=20
> Update the verbiage to make it clear the command can be used to write
> objects, not just blobs. Also add the possible values for -t.

Sure, I think this is a good change.  I'm of the opinion we should tell
people explicitly what the valid values are whenever there are a
reasonable number.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--wkLjcrrfqAvxa9nx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJOc2wAKCRB8DEliiIei
gTS7AQDTQW/Fs3R7FlFYvBTlXHUjBLtioprGQmUcUUA9jUBOEwD+L+bkUyA9LjmF
riQH4yDFLoId3jNkYaC2QuTAlinYbwI=
=nK+Q
-----END PGP SIGNATURE-----

--wkLjcrrfqAvxa9nx--
