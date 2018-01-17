Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F3F01F404
	for <e@80x24.org>; Wed, 17 Jan 2018 02:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750892AbeAQCpr (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 21:45:47 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:37385 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbeAQCpq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 21:45:46 -0500
Received: by mail-pg0-f41.google.com with SMTP id z17so10511618pgc.4
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 18:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=URoHy+zEntA7wKSJrk6CQ219e5502H8M7Me4RDouflU=;
        b=hITyPanpib8kmCAseZyfROL6JM6FDpbNWMhFTScOCv8wEw+5Gu9kYkbVjSdH7nSARn
         W+AfXuLY0SjIBY4GzwsoZEVzA/M7XK7Lg9HLoh5pWBCh9wYOalhgN0JAPvPm5hzMF2Mj
         cTLkKP0aRLuqbSXjeOYyYBpx0g4FQxWva8Kjkrqr0RH7uAls/nyVDtOzuSrKxP9Byosv
         YzmhhcYdAp0SumFUI+EqCt543t8SsA6gHtpHJCjh3YW2Gpenr1TWpIbwttVmOCGzQom1
         1Asx63bAn1EAroHeuzvr1OcuUP7OyyaxgTzh71ohZKcuF4YQq1u+Y8nJPttCBO9QC9kR
         z+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=URoHy+zEntA7wKSJrk6CQ219e5502H8M7Me4RDouflU=;
        b=MjVfuxPNreuVZfZXQEZyKk7fXhMeNZU2v4Ja3xI9RBZDD/t0HaVlP+ssw5KYfYp1qV
         /W8XHJTPlXjceVYOezzjZ81Al9z48bbY5Bw0B8fUQwEurNgUEyJ4djPEfopqrdj/bbmK
         enwWnv5w/fPo6L421HnMIzzcor/yYxVqU9czYBL0MsoISxj1BuVFdNDj/ylW4g6aRiiM
         0HdmMnUImDNl4EuvEtLongec7CAGvaeh52HGEAVpV5CusTaSxzwg60X+zNOgoFxlyMO6
         0pxYoaxoA2Vr2KKnhgupVeY+VesjY8ECYNgoTE0aRlgdsoX7uR7Uwf1oFzQjZU7BqMu5
         80uw==
X-Gm-Message-State: AKwxytfn8UkHPQ+sN1DZ5rbKXsUx47fgVjgC/PKdD1UVbX3cd2Hd0CDs
        ROVf3blM/TdS5NMYltUzcjA=
X-Google-Smtp-Source: ACJfBot2yHB7QOo/0shukaWP8O4jG3MxgFMoTn90Bmc59bB2vKDf/ic8XYC0MHMTw1yJ0oh8IIE/Hg==
X-Received: by 10.98.7.73 with SMTP id b70mr9156791pfd.39.1516157145618;
        Tue, 16 Jan 2018 18:45:45 -0800 (PST)
Received: from [192.168.206.100] ([117.209.245.166])
        by smtp.gmail.com with ESMTPSA id b8sm4111166pff.31.2018.01.16.18.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2018 18:45:44 -0800 (PST)
Subject: Re: [PATCH v3 0/2] Doc/submodules: a few updates
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jon Forrest <nobozo@gmail.com>
References: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
 <20180114173737.13012-1-kaartic.sivaraam@gmail.com>
 <xmqqzi5dtvvg.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <699d15e0-c178-1a5a-13b3-c34c6764a9a3@gmail.com>
Date:   Wed, 17 Jan 2018 08:15:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqzi5dtvvg.fsf@gitster.mtv.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6YdYFRLRxaHNu95ZJKEteqIvnP6Ln6gax"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6YdYFRLRxaHNu95ZJKEteqIvnP6Ln6gax
Content-Type: multipart/mixed; boundary="KDNb9rG7FJIi6JpwWJBQn2CY4MOY5V6mh";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Stefan Beller <sbeller@google.com>
Cc: Git mailing list <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Jon Forrest <nobozo@gmail.com>
Message-ID: <699d15e0-c178-1a5a-13b3-c34c6764a9a3@gmail.com>
Subject: Re: [PATCH v3 0/2] Doc/submodules: a few updates
References: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
 <20180114173737.13012-1-kaartic.sivaraam@gmail.com>
 <xmqqzi5dtvvg.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqzi5dtvvg.fsf@gitster.mtv.corp.google.com>

--KDNb9rG7FJIi6JpwWJBQn2CY4MOY5V6mh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Wednesday 17 January 2018 01:32 AM, Junio C Hamano wrote:
> I had a few "Huh?"
> moments while reading the resulting text, but nothing show-stopping.
>=20

It always happens when there are people around who are trying to be over
careful :)

Anyways, it's only now that I remember that I've missed a change that I
thought of doing. The change is about clarifying what a "de-initialized"
submodule means and what an "inactive" submodule means and how they work
together (IIUC, a submodule has not active flag when its deinitialized).
I foresee people confusing 'init' and 'active'. So, I thought the
documentation should be helpful enough in that aspect.
Documenation/gitsubmodules doesn't seem to be talking much about 'init'.
(It talks about 'active' a lot after these patches :)

Now I think it's better to do that as separate change and move this
forward as I don't want to make this clumsy anymore. Please let me know,
if I'm over thinking things again. :)

--=20
Kaartic


--KDNb9rG7FJIi6JpwWJBQn2CY4MOY5V6mh--

--6YdYFRLRxaHNu95ZJKEteqIvnP6Ln6gax
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpeuNMbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpu38P+gMoSG/ZYFVldgFY0+og
bw2U6PDYAZgjrqTR1yYK9cn6ZJXYITKUE/4CgnPLT98z66IyArRRvUDIwggbzTTp
BcQvAajxeKv7+Af9Agkda7o74kxNlFUd7mZooFMPOrR089bDqfFwhp8rX8PqggBz
M4TX/C1ISTRKMoKBOKGJDjsqI3P1UnZDR+nXWxEuUB410hnHBL/awgHOLv/88jWo
akNfq0cIQDud6CNUuxxI47mO2Xvw7xHyKxvOtkSV7MOMCg1p3Ldf5WRHv7hBwQa3
IgSS3oJP9vMVBlAIHW2HHJ20b82MCdUrEpaUoM9XIRufUVv5FAyr0PrNOu8P6HNq
Jn2KCGya/gXokmzGv1Mf4yA9V+/2JycPzqCDsvwZo9m2pdoS9/4qjjYqFpu8lshh
nnkuSuGTCtc7P5xvmNu2L4/Kf7MCa0fG0hhbCPRLFH8fn1UdJt5+kg9B4MC/R/xu
q2lFUwdjxiSFmK1oqp3chOzEAofzbF99oF/3AIuEU7OxWdtYew22pjIB5OYFxX1L
gYxf5iqwwMmntvV8/9R1HTJUcE0+YB0zaI32yzlpkktqwqYt1B0W7cb1HZR5J8gw
ftrl7uE3jzo14HMgDcvccTHC3yY8z7yAXiIoMnFvbfWS4aljVU/rKBatLOpvaNTw
c2ri0NFWx8FLFsYclnqBI41w
=5OKE
-----END PGP SIGNATURE-----

--6YdYFRLRxaHNu95ZJKEteqIvnP6Ln6gax--
