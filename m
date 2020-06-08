Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A444C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D012074B
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gS7bKY1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgFHWhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:37:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39118 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726782AbgFHWhU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jun 2020 18:37:20 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 88DF160436;
        Mon,  8 Jun 2020 22:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1591655808;
        bh=0ggFMuN0zYsYBU0Og0oKsLdsT/L80X9LhvVF+DENe3k=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gS7bKY1EnQ8VfetECpnF1ZBLSCagvnhHSiXYiib0vYcOeR2SmUE3snyEinWbfOvjC
         zdMQCYnbHJefsKHVoplOApUD6YgI4BlgW8lALhAJm4hpTRFy3aEzdHx0oTpCD/DLZI
         VVAhmOHM5FuCpa0nRE/97am6aR+jbbIaLtnyj+PT0JpSWoQFFP5K8y3/r44Dv+kX+p
         pMOafSHTldMMtfZ1dDNrWzgnqpMWexjbPPkOnzx39TQNrtt2T5zW0NAIpQQX95poNL
         Tl4Xysg5l/Ae3sDS9ddmWLVTfse+fObjgjgf6YuMEP2YDlPr7zOMdx6UpLyIdh6eIo
         DC7guprVWta85cIUhjCahUJNJjfmtsrwdhpFtxuHj3uLTPmap8nG0YOqbyqbrNxhq2
         +XBdeDtpCe6wvt77FdNKwCTkGLQJh6U5E/h8sYSCi4lgSWyryJ5C3wYerN55px1Esj
         Q3uVSSNOWsBR3OJwwFntSbi9Xxp5BXiLvPMZ9xCHrwCli5nKiEe
Date:   Mon, 8 Jun 2020 22:36:43 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Soni \"They/Them\" L." <fakedme@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fetching a lot of repos
Message-ID: <20200608223643.GL6569@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Soni \"They/Them\" L." <fakedme@gmail.com>, git@vger.kernel.org
References: <ef6f2275-536b-f4dc-9012-0467b1a4134a@gmail.com>
 <20200607210344.GK6569@camp.crustytoothpaste.net>
 <62cee46f-d37d-0e51-143e-b2e9c10f5b0f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WkHPBKJ2pKcVUM5H"
Content-Disposition: inline
In-Reply-To: <62cee46f-d37d-0e51-143e-b2e9c10f5b0f@gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-2-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WkHPBKJ2pKcVUM5H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-06-08 at 16:03:37, Soni "They/Them" L. wrote:
> Relatedly, but not relevant for my use-case: Is it safe to assume that
> currently git breaks if multiple ppl push into the same repo at the same
> time, and they have not-yet-upstreamed shared commits, in particular if
> they're pushing to different branches?

No, if they're pushing to different branches, it's not a problem on the
server side.  The server side should be reasonably robust about this.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--WkHPBKJ2pKcVUM5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXt69ewAKCRB8DEliiIei
gf53AP9VQesk3XDqHlbtdrTneGrOP8eFhIinVSLaTmiL6cqS7QD/Rx+MNkXBLbxW
+BMno1mGfTYWNK83Ad7yc7Wlpy8RGgM=
=y4We
-----END PGP SIGNATURE-----

--WkHPBKJ2pKcVUM5H--
