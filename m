Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F2A61F406
	for <e@80x24.org>; Tue,  9 Jan 2018 16:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbeAIQBl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 11:01:41 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:38131 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbeAIQBi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 11:01:38 -0500
Received: by mail-pg0-f54.google.com with SMTP id t67so8250643pgc.5
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 08:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=3d9wYFJ0prbtfSwm4DKRYlEgutMeGQpeIg6cDQmP7N4=;
        b=YgY+kweSdZ0XLNuKZUtBA0O0QKIrBludJHqVE+yuGeha2fC/f+NVal/mlZIp89hY7N
         CkZye66BtBZRV22lYjCznpgbC8nQBS05OiBZYZkWfKiNlS81Keb3I5OBL+lWTLn2aAQ0
         AORmIZSdvL+vWsFKYwcpRKh4NMN5/ZtAfpfWVNFW0z81g5Vja3llHFRGS2eGOZWWvUnx
         p2YxzBBAk9skR1+qUT6+XJQlOWwmm60hIy8LA3tIm+uViLXiM+FoDLo9hGoXAzAzJTxA
         EoWWYZs62L7qam+Rc4ZhbLAXwiWBpZWx5gpl8B4DBTgFeIe5lL8XUnmf4VYcoF1En6wP
         cQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=3d9wYFJ0prbtfSwm4DKRYlEgutMeGQpeIg6cDQmP7N4=;
        b=c2oenvo85ARUb22+XGyQliUy6Sg5S4nxn6/V/djU0h5f5MH2nILRxqxcA3aj9WSXWC
         M35TLIq0NOGh/z1visRnL8TzGqeI9RmBHbgkidrcailuJE7+PxLGWE3UJ68jkAapdRCb
         SLq6E8x75yEDlnCxiHYREjP/70Z8iBzOOU0HkmWoSwnUhBNRsrimAKJguYG5v9WHGn6+
         JTEHbTYhCCEdCmczXykwYyKNaq7QOikzvAgl9kD5AfMJm+A82uh1XSMMb6/wMAI4dje8
         DuPTIhVkC2m98yb65jEKJS2FuKo5lOakzAYHHW49Hh3NIrxnjjzpE+pTCkm9eijgCNRU
         0REg==
X-Gm-Message-State: AKGB3mJR2QCSkrhW0HMUwua/kBN9l2dqkTgEDEIAl3X5mH+8Vz20Mtc/
        i7nYxzvhyA+LE2RQRgdRe1F+EUJG
X-Google-Smtp-Source: ACJfBosI7JhLfvdJVAwq9uuUUi5UBx1Zf2a6tqorx2RK+SY7Z+aRwt1a0CpK/YxFO85SlY2LiO6ItQ==
X-Received: by 10.98.201.26 with SMTP id k26mr14235425pfg.103.1515513697852;
        Tue, 09 Jan 2018 08:01:37 -0800 (PST)
Received: from [192.168.206.100] ([117.219.201.242])
        by smtp.gmail.com with ESMTPSA id 6sm26030700pgf.54.2018.01.09.08.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 08:01:35 -0800 (PST)
Subject: Re: [PATCH 3/8] Doc/gitsubmodules: specify how submodules help in
 reduced size
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-4-kaartic.sivaraam@gmail.com>
 <CAGZ79kYrp_DAaiDzpiWbTSvsfud=JHSO+NX3UaC4osAE3dYmmQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <3d85256e-4f19-b9d6-323a-d683dbfd8cf7@gmail.com>
Date:   Tue, 9 Jan 2018 21:31:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYrp_DAaiDzpiWbTSvsfud=JHSO+NX3UaC4osAE3dYmmQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4D1CG2ho9t9HfghE0RdwrexhgxTnzPGxh"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4D1CG2ho9t9HfghE0RdwrexhgxTnzPGxh
Content-Type: multipart/mixed; boundary="c7b1rBROkDt0RwXdavc5wxHU4xiXB0CYW";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>
Cc: Git mailing list <git@vger.kernel.org>
Message-ID: <3d85256e-4f19-b9d6-323a-d683dbfd8cf7@gmail.com>
Subject: Re: [PATCH 3/8] Doc/gitsubmodules: specify how submodules help in
 reduced size
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180106184614.20115-4-kaartic.sivaraam@gmail.com>
 <CAGZ79kYrp_DAaiDzpiWbTSvsfud=JHSO+NX3UaC4osAE3dYmmQ@mail.gmail.com>
In-Reply-To: <CAGZ79kYrp_DAaiDzpiWbTSvsfud=JHSO+NX3UaC4osAE3dYmmQ@mail.gmail.com>

--c7b1rBROkDt0RwXdavc5wxHU4xiXB0CYW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 09 January 2018 12:08 AM, Stefan Beller wrote:
>> diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmod=
ules.txt
>> index cb795c6b6..3f73983d5 100644
>> --- a/Documentation/gitsubmodules.txt
>> +++ b/Documentation/gitsubmodules.txt
>> @@ -63,6 +63,9 @@ Submodules can be used for at least two different us=
e cases:
>>      * Transfer size:
>>        In its current form Git requires the whole working tree present=
=2E It
>>        does not allow partial trees to be transferred in fetch or clon=
e.
>> +      If you have your project as multiple repositories tied together=
 as
>> +      submodules in a superproject, you can avoid fetching the workin=
g
>> +      trees of the repositories you are not interested in.
>=20
> You do not fetch a working tree, but a whole repository?
>=20

Maybe I misunderstood submodules when I wrote that example. Could you
help out with a better and precise replacement?

Just putting in some context as to why I did this change, I thought this
was the only thing that lacked an example and wanted to make it consisten=
t.


--=20
Kaartic


--c7b1rBROkDt0RwXdavc5wxHU4xiXB0CYW--

--4D1CG2ho9t9HfghE0RdwrexhgxTnzPGxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlpU51YbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpBKUQAJyqf3jyySt+e/zegZPX
9JwpQ4DSvdD/Vfx6f70ZxxInS5PfRuNEsNUcibCeV0FKN6FI7mVCww7TNKqYQxdB
80m0+VT0wQuVOqX//vwPKXByD60Ux1i1xdmf8yaQu1A7gYS+MRT5JeyIa1fIInzZ
UjkRaVG3XUUIFkM/zckL56WUPlB7cTBBhjnJZfR93COGbYOuMLZb15CTh9TmldVq
gn6PwSl4dfI7GkD0FpHyHMxQ7Ouks10ojr/alRdpOllp1MtzdTts8cRwZYSCc3Dr
oU0fS4TBXXDpqlFnDq6271kZHEWhDbFWWNWufcJrH7lLiFPAz+8bQ+ETv7bAHTsa
xHjHZhdjuCBvBkAUOwRnIHRw3pFdOcmNUeq4Vwf3HUlTvXECHGffsuWtYD2dkueD
19ta5GJUiZN0po4zCcva564+vS6vA0LVm737Q/OWiOGBUmqp8EZNTFJDK9anLZ7V
XnA4gM+LsP3ap/wcs+oqA+NUP3tftBK4SspgaqDjBeF6ASDq2Op6ccxj1myjc0rE
JW7bDyZpSWivOaq96WoyOMooEi6zquWTvy4ZRjwmuJIuR9ML13ZVUt7hqPTiB9yE
gMyiNYQg62qZLCvGqiTjBGoBudZP5ZgWuBhdRVkZVpYqscJleNu2Hwbjepdcapc9
N1UW2jJ+6/HoZXfrvWZBfIKV
=OI/H
-----END PGP SIGNATURE-----

--4D1CG2ho9t9HfghE0RdwrexhgxTnzPGxh--
