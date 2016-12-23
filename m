Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DD8820968
	for <e@80x24.org>; Fri, 23 Dec 2016 07:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759462AbcLWHGY (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 02:06:24 -0500
Received: from hetzner.fladi.at ([144.76.17.165]:51536 "EHLO hetzner.fladi.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757862AbcLWHGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 02:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=@; s=rsa1;
         h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:
        To:Subject:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l1Wxc46nnqvfGCKwwh9imnrzFPUiEsJPN6znKJc0PNo=; b=czquJI6DyNkgQQdclRi3sA89zC
        pyPwBN+g+CwDdO9zrz6D3OWKsT0o6lsKcveLysq3LriJmX4QRKyG11t4+t6Vsp7dD4ZOGg4rZrdIZ
        p3SXJwRW0INKAoR02kvoCO4PO;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=localhost;
         s=rsa1; h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:
        References:To:Subject:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l1Wxc46nnqvfGCKwwh9imnrzFPUiEsJPN6znKJc0PNo=; b=DsXkZzbGl2eNp30tNiV7OkU2KN
        iJOtpkpT6v6juNvbuOus6oLCtC5tNt9fcoa0cki7yHnIQLR+dLXj3TzC75poF3yq+Lju3YYOS0DIL
        Vag/K/1lO3t9QRMYmpcNfNhl5;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fladi.at;
         s=rsa1; h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:
        References:To:Subject:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l1Wxc46nnqvfGCKwwh9imnrzFPUiEsJPN6znKJc0PNo=; b=riDuBhTYdwcxfUHT2y5cOviX3w
        /oqcHIGmtTjWD58D7g7MkSToPuODOJ+6krlnDk5oKQeMu48oCfDv5C59ZAKqWwofaK7jvZVBHdBMb
        jXw9ktSfXs2B7H/Vkz1MoHr9L;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openservices.at; s=rsa1; h=Content-Type:In-Reply-To:MIME-Version:Date:
        Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l1Wxc46nnqvfGCKwwh9imnrzFPUiEsJPN6znKJc0PNo=; b=StAjp3Ikv3JbYfquTCdUvdSpq
        ypEiXzaBMSVvE2ULcDZbhVGF7qGjF7G2XO7ucsDac4CI5ei/8cDWW4t+o2jNc41fp+dtbWzm6K6bn
        4vipfvD0n9M0sR5UZNEP21J0Mm;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=qraz.at;
        s=rsa1; h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:
        References:To:Subject:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l1Wxc46nnqvfGCKwwh9imnrzFPUiEsJPN6znKJc0PNo=; b=d5GBEVmtf6gSwxk2YiqsrlDNM3
        Yb0OAp5IwEcYgfiWibJ5EeCJ/QbrJiHlFvYejZ8iU/S5//SsVlqeOmJG0WyO8YWiDZYYJzKegMBSc
        4rsp89FEgHSZRzYoFbthbPvtB;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=firedata.at
        ; s=rsa1; h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:
        References:To:Subject:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l1Wxc46nnqvfGCKwwh9imnrzFPUiEsJPN6znKJc0PNo=; b=miXv/abUIxgBPNiw2a4bnm9T0R
        +3JnYK1hqSC3xpw0jmhkf6s3h/W4q85Uobab4z28sH+VVtim/W1K399Btw42ahw0dHmphzUePpG92
        Gwq/AIzVNKAp4axiZ7EzcwM/g;
Received: from [2a01:4f8:191:4a4:b072:45ff:feea:6846] (port=36738)
        by hetzner.fladi.at with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.88)
        (envelope-from <michael@fladi.at>)
        id 1cKJvg-0003hG-7r; Fri, 23 Dec 2016 08:06:16 +0100
Subject: Re: [PATCH] git-svn: escape backslashes in refnames
To:     Eric Wong <e@80x24.org>
References: <cb8cd9b1-9882-64d2-435d-40d0b2b82d59@fladi.at>
 <20161223014202.GA8327@starla>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Michael Fladischer <michael@fladi.at>
Openpgp: id=D8812F4065320B8DCA3CEF18694CADEF51C7B5B6
Organization: Fladi.at
Message-ID: <cb6a6ea2-aaa2-8522-a7e2-44e1bc540338@fladi.at>
Date:   Fri, 23 Dec 2016 08:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161223014202.GA8327@starla>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xi7SdIOmVXPuIgHwj32irVsGXP5TlMpek"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xi7SdIOmVXPuIgHwj32irVsGXP5TlMpek
Content-Type: multipart/mixed; boundary="am7MlqRHrDfJH3O6oIi8PVHbUatHVWdRN";
 protected-headers="v1"
From: Michael Fladischer <michael@fladi.at>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <cb6a6ea2-aaa2-8522-a7e2-44e1bc540338@fladi.at>
Subject: Re: [PATCH] git-svn: escape backslashes in refnames
References: <cb8cd9b1-9882-64d2-435d-40d0b2b82d59@fladi.at>
 <20161223014202.GA8327@starla>
In-Reply-To: <20161223014202.GA8327@starla>

--am7MlqRHrDfJH3O6oIi8PVHbUatHVWdRN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2016-12-23 02:42, Eric Wong wrote:
> Hi Michael, the patch below should fix things up.

Thank you Eric, I was able to successfully fetch the SVN tag with your
patch applied.

Cheers,
--=20
Michael Fladischer
Fladi.at


--am7MlqRHrDfJH3O6oIi8PVHbUatHVWdRN--

--xi7SdIOmVXPuIgHwj32irVsGXP5TlMpek
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEqVSlRXW87UkkCnJc/9PIi5l90WoFAlhczNkACgkQ/9PIi5l9
0Wr8jwgAqXM3R4cHCX0VQ4kJH6spGwAlFkAVodkwmwTWwkW60GfWkG/Zte678JxK
rA3sLj8SbpYjMAhn4+UAzP0hJ497lO8pfDrWFSeOfUkBDpHM0DNTZtbjgGpp1csw
daRww3vhI+fJxasd8RaAyY5dhuCoV7Tp4aBOPBUV8Fs6OelIotuyj+EXmkJ8HuMe
wW5Q4RGFu38FxOZhitak/Ymkoq5RIHbAUA5jtxqXO/mKPosmOvgIkfmCPxWiz0tg
mSRD3phGOV1v4U2nKoITlaPYFH0WxwXbdPiEh06u3YneRFhp2KsFI0lvciSNDwfq
3YOwPUNFkgF/BNd4wfHK8ag7PwOzNQ==
=qK0t
-----END PGP SIGNATURE-----

--xi7SdIOmVXPuIgHwj32irVsGXP5TlMpek--
