Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3A81F404
	for <e@80x24.org>; Sun, 25 Feb 2018 03:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeBYDsM (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 22:48:12 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41329 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbeBYDsL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 22:48:11 -0500
Received: by mail-pf0-f196.google.com with SMTP id f80so49625pfa.8
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 19:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=c3ENJmAxFSxV6mUj0gOZHG16Zi5dBvxlPWnI0q2487M=;
        b=V36afy9J9j5fCPwTcdebn9QSWo6alwc4cusHPCt0wqtIH1rEBKi9kiKH9r5o6hL4HM
         aaFdblspJq1HH9uv5uGBFEHBScysgNN7RTnmXn3gAGau3BpZF9ssKfK2L1/zT4NRyrEh
         4VxRs5G0zzHgax8MniHyjCKamA1KKuUM7ZMFdDps7V0hIue0a7pOipZbd04pHzmolnO5
         9iiclZK9bqt9bDzxjjvXk1ZhJ/y3IqoZ6/RnAr6ir8NcJ41KIsrPH7wpbu62Lg+fkp/v
         gUhe0e8rSBamFJ6N0PINCRMq7NVZdfM7QMzgW+LfFGcax62COV27m98vfwg/otMKAjWJ
         TTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=c3ENJmAxFSxV6mUj0gOZHG16Zi5dBvxlPWnI0q2487M=;
        b=ZVuUuAvIP/OCrkKbrkUXA3YjguOVlKvdFmDGyoS2mlhG2lowJyvKpwRVOt34xjaQya
         PBksp0GzkjnoSYSFN6XoXKo5pZ859eH7oHhpxy+GhMI8T87WJ7bNqFCzvideyhAlF9Xi
         XEY/W/sJWiZwuA19IAstzSQ5RO/P+USgFtCdQCgKT/1iuALvcOHjCIONx4ahuSJnMr0n
         ixVN25FiJIE0SZB1oAlDoRpfOBwgiJ5d5GI+tG3+Ty6sEzwHOD2TamsUknpBWlPsWAl/
         2KX/rii3ySJeWs46oRVBDtxtfVjeCNAmApIHBtp6ULXdW1jUK6KI+fZFXEcUP9h0CO11
         P9Xw==
X-Gm-Message-State: APf1xPBgLMquGqSOIjIask1GDq/BQSsssEeabgJR8cBj+DCFdDKFscOM
        8+ZTqlHuEMvyrmYMKDwoz/4=
X-Google-Smtp-Source: AH8x226ai5cbWzWOKQunT0A4uh0mFH+Wm+w12z+IlYZq6x45SlyO5BAXZBxJy3lQypVqH4rfiJf01w==
X-Received: by 10.98.223.143 with SMTP id d15mr6546271pfl.208.1519530490769;
        Sat, 24 Feb 2018 19:48:10 -0800 (PST)
Received: from [192.168.206.100] ([117.251.231.186])
        by smtp.gmail.com with ESMTPSA id t15sm5950769pfa.60.2018.02.24.19.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Feb 2018 19:48:09 -0800 (PST)
Subject: Re: [PATCH] t/known-leaky: add list of known-leaky test scripts
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com>
 <20180214215637.6462-1-martin.agren@gmail.com>
 <20180219212937.GB9748@sigill.intra.peff.net>
 <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <a86793c8-2051-4d92-967b-1d24dbf4a2ff@gmail.com>
Date:   Sun, 25 Feb 2018 09:18:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jQ0vD0tLle9Ewkkt4Ecq9KSPeBtb1Ookn"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jQ0vD0tLle9Ewkkt4Ecq9KSPeBtb1Ookn
Content-Type: multipart/mixed; boundary="Cc5wkZCbChctgwGECxElUox7QdFevSv73";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
 Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Git Mailing List
 <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <a86793c8-2051-4d92-967b-1d24dbf4a2ff@gmail.com>
Subject: Re: [PATCH] t/known-leaky: add list of known-leaky test scripts
References: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com>
 <20180214215637.6462-1-martin.agren@gmail.com>
 <20180219212937.GB9748@sigill.intra.peff.net>
 <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
In-Reply-To: <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>

--Cc5wkZCbChctgwGECxElUox7QdFevSv73
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Wednesday 21 February 2018 02:14 AM, Martin =C3=85gren wrote:
> To sum up: I probably won't be looking into Travis-ing such a blacklist=

> in the near future.
>=20

Just thinking out loud, how about having a white-list instead of a
black-list and using it to run only those tests in the white list.
Something like,

t/white_list
------------
t0000
t0001

To run
------

cd t/
for test in $(cat white_list)
do
    white_list_tests=3D"$white_list_tests $test*"
done
make SANITIZE=3Dleak $white_list_tests



--=20
Kaartic

QUOTE
---

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky


--Cc5wkZCbChctgwGECxElUox7QdFevSv73--

--jQ0vD0tLle9Ewkkt4Ecq9KSPeBtb1Ookn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlqSMfQbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpm08P/2/OYBsYK4ihogtSr7n9
2C8FeBAIFFesxCORbk2lEMDF+fWv5QSp1utnlSavjVzk28ruhhb/1HeLaiwvujnn
7QebEaeIF22J9/5Rccr1u3p8NdvhD+Tn5yENyT09l5ueQLmX4YuiaBAJDubAyfcy
uPnmJOBXibWqWqG7KzPkpR0ZfbVhz4rxfOXbtU9YEbkPZrjOmTS15dRMJ8CYL/UV
3MNquZHzQA9aMvwwfMHQwYLP28wK0YAUjYv/ICROsb5qrByjwrXdF4i9Qwh8uGvb
9W+LlSq+danKYC+Bt9MMF/6bT4/mUvDQvdFw9W3zHKijNszmXT9FnPnlsKYDRdt1
+xD+F/7qk4WepGD5sUgg1jk8oi79ykIqg57DtfnPsqwMx/7gR1BhtqhQmUpsT0VR
XihJiD5mo+30/s8MR/OgyeGvJwVb9Voor0ONB689eFdtLHXzQlkauM2yAyesoqkQ
jrzlZ9KSGjkzpzxdSCMKBTTLR8pPS3RPPwohitErvFxLUgypPMKsVHb8MUqed8Kg
/HpOamZp7DRNKbWz0sz7qUSQ88L9dExITHKTKWxCnnIU0VpuE9P526oiUv1np/Nz
meFZYs1cm+ICKkWzZWOHo6guXTdxGH8aD+0Xauom8ROnADGVqZTtgDqgMizGoKYW
818MC3Kjc+d+MPR9RCkKKyMn
=UlhD
-----END PGP SIGNATURE-----

--jQ0vD0tLle9Ewkkt4Ecq9KSPeBtb1Ookn--
