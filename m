Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABECD1F42D
	for <e@80x24.org>; Wed,  9 May 2018 07:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755983AbeEIHEI (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 03:04:08 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34116 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753289AbeEIHEG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 03:04:06 -0400
Received: by mail-pf0-f173.google.com with SMTP id a14so25185723pfi.1
        for <git@vger.kernel.org>; Wed, 09 May 2018 00:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=E9ROmniSx1YM8ghtlX8owLIOMiuK0hCzdgp+CW0qKSk=;
        b=jAgka/4ECaRFp6ROKM49HVQvOrmFg/KCc7VApTK6lV5FsBKVHmEnQqG91L9WD/0XEp
         JbXEHFGXPqVZ7ePcTAuXdbBKaj9q7wftoaKHIQMmUS2ClAyykTorceBf9UcyYz6e5Y8R
         KDX09P8knaLCwYnHu5W/qnMEAsNqQtQ9VE8+qVVRvJ9mnwuv2a3fiGr+o4etFKBBL5s7
         TTpyzxr/FN+27nKjhukrSZQLVPLAAxGRAK9ghxZGAT25KQ9oRNKcIXJsxjSlynZP0Ggm
         YqugJG+qS8mpBemEzmyGis5FHXiqgYsWW4E+RTWG5J27ZQ4Q564ssIubaTLvminoNGj2
         cGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=E9ROmniSx1YM8ghtlX8owLIOMiuK0hCzdgp+CW0qKSk=;
        b=qmttymNIKHc76DGxdmGk2VRmI5gCTS6v+MRt+y0Xy6tuTtfAz6spSg2+FrOfPUgxww
         rQToEWUubRzxK9lDgk40xo5GDc38Evy83mTXE8cFmKUyxQfcxzLJ6xo5wAgb0OZvphuT
         rLnY5VsZHxdL3OVKJ29hqU0nLoJJSkXOy1jQgVlj5hr4Lns3k6aLnzBiGG7FYnLgA0W6
         8nAbs7naWQP+l3znleOY71Sja9iDmnvzs1iTAx8aIkvFBAkkwPlQOkbzqtKqCwPKO7Vj
         3gF46E3qgff/2QZjqGMq70EU9nrEUitIrwodYmKiH4ot1+XKDN5oE7q+Z9XvHz6axo8x
         Tz9g==
X-Gm-Message-State: ALQs6tDa9t+vxAYLpfezPa6j9Cwrn3BDSoQYrzlPPAzPVuYJu/ptHF/w
        TMzskbOCyaoZCwW/alhUVUGPvK5n
X-Google-Smtp-Source: AB8JxZrJuMsrZ/jEJPIQtMcYTN7xQPLHX6JjcpQuBreYPKeWAFvwovNPZ4fSFe3B965iFv1pEfVwdQ==
X-Received: by 2002:a65:41cb:: with SMTP id b11-v6mr23150884pgq.260.1525849445843;
        Wed, 09 May 2018 00:04:05 -0700 (PDT)
Received: from [192.168.206.100] ([117.242.81.183])
        by smtp.gmail.com with ESMTPSA id y20-v6sm32462219pgv.27.2018.05.09.00.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 00:04:04 -0700 (PDT)
Subject: Re: [PATCH v2] mailmap: update brian m. carlson's email address
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <184451b4-1b34-c1f7-f9b1-0dfa63ab9506@gmail.com>
 <20180509001957.GE275488@genre.crustytoothpaste.net>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <4587b2e7-6cc8-c8fe-0b2b-7ce4202197d1@gmail.com>
Date:   Wed, 9 May 2018 12:33:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509001957.GE275488@genre.crustytoothpaste.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wr6JHwsiNmnl1Q6xUMNQJHCfmBFmNN9kQ"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wr6JHwsiNmnl1Q6xUMNQJHCfmBFmNN9kQ
Content-Type: multipart/mixed; boundary="aluBHByUFkeyoy6gX5PrkSXSsm8yta50i";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <4587b2e7-6cc8-c8fe-0b2b-7ce4202197d1@gmail.com>
Subject: Re: [PATCH v2] mailmap: update brian m. carlson's email address
References: <20180506232421.975789-1-sandals@crustytoothpaste.net>
 <20180508015845.268572-1-sandals@crustytoothpaste.net>
 <184451b4-1b34-c1f7-f9b1-0dfa63ab9506@gmail.com>
 <20180509001957.GE275488@genre.crustytoothpaste.net>
In-Reply-To: <20180509001957.GE275488@genre.crustytoothpaste.net>

--aluBHByUFkeyoy6gX5PrkSXSsm8yta50i
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Wednesday 09 May 2018 05:49 AM, brian m. carlson wrote:
> Correct, it doesn't.  In my case, I was using --pretty=3D'%aN <%aE>',
> which is how I noticed it in the first place.

So, how about updating the commit message to avoid confusions to the
incidental future reader? (Or is it just not worth it? ;-])


--=20
Sivaraam


--aluBHByUFkeyoy6gX5PrkSXSsm8yta50i--

--wr6JHwsiNmnl1Q6xUMNQJHCfmBFmNN9kQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrynWAACgkQveda2sPW
GWmHJw/9EzZhPDtJBWxxoc57LUc5h61Ld5QU9SnD/uuokbg/SsNIgTDWem9A9gio
Hy35TO1f6zapbAp/OoD+wTItz1+gB/qukW6dKaKEoetfDs3Z++BT31bLcBAuxyfm
5ZmcKS2CJDIIn86slPWmXdLwlX+ZIm67xqYuis5Dpu06yw/qv8W54MVVXYd3phyG
3iq1wsD/oVyE4oHoe3tNK5JDpX8uiH8TScRpWcMVkPF5SRt24lhMUKJnfr5xTeRf
x8hhmkd2oraoJgQeG8AYxBhLiydoP4fKxkQyNTuRW0MtzqVAbuJm15oGe9eM/mmg
vESaCyK9VeCFr7BWeOnP/3C/ImrnbkgHTVOUiU0uXo0M4tlz65ND1gfy20zn13FY
FKaIgtzZey8hZOktRaWUMrv/6FpbWiCHKwXOyLhwWjrXQHk2JD3Jje09ZCLI9gX7
2JojCAGUIrJQIFvc7tAifjfV5UMd1KIjMlyqRZ8QMQQmfKEJDW5nMr81y2nRKv5R
e5SGCpCXpMVyemRKXEb3X3DLDtrg7COQ762iXSBzsunp75eAn0nTz05PJgDzSQDg
lltXgqk7CIgQdm6ZrDO2DjMfUZI9cp79+JW80Vshd4pPeMqFyVlI8niuVnz6ZPOK
xPZd/P46B5TaceUnWi3fLnI1lZgAF5y9NuFIJY264eHN8QoTX84=
=nMKc
-----END PGP SIGNATURE-----

--wr6JHwsiNmnl1Q6xUMNQJHCfmBFmNN9kQ--
