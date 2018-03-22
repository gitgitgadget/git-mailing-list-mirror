Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD2B1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeCVQsU (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:48:20 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:45170 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeCVQsT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:48:19 -0400
Received: by mail-qt0-f176.google.com with SMTP id f8so9613989qtg.12
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:from:subject:organization:message-id:date:user-agent
         :mime-version;
        bh=iMregjsRp33dCMg6XJ7UoMu3pRmIuV8D6SBmciqtarc=;
        b=TvfkxWYmlmeOrUMi2Z17E9HF5uU50m5aXy5A4kEz4YlLd5ZgYAE3Hf1lMjsLAg/YQt
         rS7U38+oXHj7y6fNN9qJqePA3VYmhU9o5NSweECKcLnYWOupCWMKBIYMBC2T/71CKLZ8
         H/OfyzYK2odbNa8huNLAM1e7mRnJUuy/1SFLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:organization:message-id:date
         :user-agent:mime-version;
        bh=iMregjsRp33dCMg6XJ7UoMu3pRmIuV8D6SBmciqtarc=;
        b=HPQnXG32nTsbrH6afjSl/0g7JlgvdIoOeguphLRmH7bL3DM20WOiiNCqFswWOfMSrh
         4qESyX/GgtQ5Ecab4ulynfMK+tSt0USJw7Y3hHeKMdGAUEbdhZbvJ0inYJdR9lA0R/G2
         Rs4Gox/ryy6KTaKsLMuXbtgjgpm9BPTjJdGQ7WyQBESLL6Uwkmv3f/Tr1SC0hgX3s5ht
         7+rND+6sCG/zitR7tqrPcZNPtChBGiF3SGEgodKJD1K0p/cH6FpP4ISwHu3h6JGQwKCw
         zQpEE5PRb65n2z2cOi0F7XvqCLzCj2/OtmeHZSpBnsXZJkLNSfxTq5+kx9Q1ekof5D82
         0GJQ==
X-Gm-Message-State: AElRT7GSvq1XKuy4QeJOFQmyApaw/ugnc7PESVKzxQc77zKLNN4orOdm
        464A5LzUBoIA1EdOYJa762mWNYenYbs=
X-Google-Smtp-Source: AIpwx4/BD5GaiyKrZeZXIX4voqitxjJ2fVIWZMriCUN4wP4XKVx3wdScvt/6TJp8drGSBqdeUG3sHA==
X-Received: by 10.237.46.69 with SMTP id j63mr8668127qtd.52.1521737298733;
        Thu, 22 Mar 2018 09:48:18 -0700 (PDT)
Received: from [10.137.0.22] ([199.66.90.113])
        by smtp.gmail.com with ESMTPSA id a199sm5130515qkb.14.2018.03.22.09.48.17
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:48:17 -0700 (PDT)
To:     git@vger.kernel.org
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: The most efficient way to test if repositories share the same objects
Organization: The Linux Foundation
Message-ID: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
Date:   Thu, 22 Mar 2018 12:48:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RX3GlWw1LRxZqgsBjfuD5mVbQ5tEt0ZZu"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RX3GlWw1LRxZqgsBjfuD5mVbQ5tEt0ZZu
Content-Type: multipart/mixed; boundary="PuupRKCuQ3zNiCvrDnFjatzfwdNQWCl8B";
 protected-headers="v1"
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: git@vger.kernel.org
Message-ID: <14d0937f-0e39-7af7-a395-3046ec5d5c16@linuxfoundation.org>
Subject: The most efficient way to test if repositories share the same objects

--PuupRKCuQ3zNiCvrDnFjatzfwdNQWCl8B
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable

Hi, all:

What is the most efficient way to test if repoA and repoB share common
commits? My goal is to automatically figure out if repoB can benefit
from setting alternates to repoA and repacking. I currently do it by
comparing the output of "show-ref --tags -s", but that does not work for
repos without tags.

Best,
--=20
Konstantin Ryabitsev


--PuupRKCuQ3zNiCvrDnFjatzfwdNQWCl8B--

--RX3GlWw1LRxZqgsBjfuD5mVbQ5tEt0ZZu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCWrPeTwAKCRC2xBzjVmSZ
bEt9AP9xFTiTHlcxdIlRcSsaitVektlUDwdX89jCHVmFqGrRYgD8DcXi0s4rIQbw
cchxoCr47Jy4nFq8BWxfDdeDb2Avog4=
=iKkV
-----END PGP SIGNATURE-----

--RX3GlWw1LRxZqgsBjfuD5mVbQ5tEt0ZZu--
