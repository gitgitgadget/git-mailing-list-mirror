Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196B71F42E
	for <e@80x24.org>; Tue,  8 May 2018 06:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754317AbeEHGn3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 02:43:29 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:42701 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754132AbeEHGn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 02:43:28 -0400
Received: by mail-pg0-f44.google.com with SMTP id p9-v6so17829591pgc.9
        for <git@vger.kernel.org>; Mon, 07 May 2018 23:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=t6DH907d1Rz+ux89qZCsI3kEbwb1VXsi26g3EypsufE=;
        b=uzjjh1mu26CzmFyUaVsmPyJhDBLeuuf1Cc/XxmIakK2O/2DhSBYQWxZs3+/VGpMrbD
         3+Tu38uZn8ETakn8NXfPTnUnppFnqEvlUh6x6ZiyrxJJqljxn35s5MezHBTLf0X9CnJq
         uthzawtnaqH3Ljhvdwmlh8M63z+p2d0KVl8hYH7ztO8K642/hH+kU5/OZYLhtDPgu9ow
         IlMpSt3z3gy4QyONUKxQW4Px45u4C51BKolvN3Zz/4+QC7F+cIB+yhMkd0HkHfRLViT/
         QbJRMHSbYPhxg39uuHitH7qTHBO1aiogW3DPBd/LrtP9whoIw0U8ApEA7UqFhT/GeRuf
         LuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=t6DH907d1Rz+ux89qZCsI3kEbwb1VXsi26g3EypsufE=;
        b=tPzQfDX3lFniFnskyn+Bzly1vk7govOXslKZ1twkONIW/KdGPHgVCUPYA5AhbHTxW4
         aY+3LUjvqsgVOw/qGxgwUUDwJ8ESj7By/a0B6tCwLWjNSVomQQ1RsBmIQRCdkMatTbHj
         5g5tGWPm333+zMZ78G8c/K1lqDZDlqj6a3XP8BS3pwMZpxU3bqCzoXGynpw/iiJGLu05
         Kdi8Oc01rZ3PrHJGTVDh/CNeX4cezxs55GeWFZ1ETL5J2xck6lhN+xmv7qEA158sdT/L
         7NYI6H7cDUEGTAgluWJVvV8+c0U7eOEdSMhY6wSaBXuurWa9yylQeIU5/4e57u5lDpNA
         Z6lQ==
X-Gm-Message-State: ALQs6tCpb3jS4qafnSi7zFYc4kiToXiQw7dTHREafJiynPmkX8gjtcpf
        5QCEFt5PJiVGh3douYZqY9PSJxzN
X-Google-Smtp-Source: AB8JxZq5XlGvY0nkSt0uzifz8JS/JSAZQlmfA20t+1OYUJMYUvT8YPDTlr4XckogaHtrXhE8Ihvb1Q==
X-Received: by 10.98.66.143 with SMTP id h15mr38869764pfd.156.1525761807374;
        Mon, 07 May 2018 23:43:27 -0700 (PDT)
Received: from [192.168.206.100] ([117.209.132.10])
        by smtp.gmail.com with ESMTPSA id k63sm66520697pfk.90.2018.05.07.23.43.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 23:43:26 -0700 (PDT)
Subject: Re: main url for linking to git source?
To:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
References: <20180507063713.GA28961@sigill.intra.peff.net>
 <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <03bd84bd-dda9-882f-ad3c-861792b54ce9@gmail.com>
Date:   Tue, 8 May 2018 12:13:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PsFXFm4UtxHGvYc7FDMvO7Q0PbqMs2ZWK"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PsFXFm4UtxHGvYc7FDMvO7Q0PbqMs2ZWK
Content-Type: multipart/mixed; boundary="59ZJ75Dyxa8fErWXggfce6a0gRA6bxDy8";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Cc: git <git@vger.kernel.org>
Message-ID: <03bd84bd-dda9-882f-ad3c-861792b54ce9@gmail.com>
Subject: Re: main url for linking to git source?
References: <20180507063713.GA28961@sigill.intra.peff.net>
 <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>
In-Reply-To: <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>

--59ZJ75Dyxa8fErWXggfce6a0gRA6bxDy8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Monday 07 May 2018 11:45 PM, Stefan Beller wrote:
>> I could see arguments both ways, so I thought I'd take a straw poll of=

>> what people on the list think.
> =20
> Junios reply below focuses on the URL passed to git-clone, which
> is only found at https://git-scm.com/downloads (?)
>=20
> There I would try to mirror Junios list of "public repositories"
> https://git-blame.blogspot.com/p/git-public-repositories.html
> without officially endorsing one over another.
>
FWIW, I also seem to support this suggestion as it's not opinionated.


> For those links that link to web pages, I am ok with any of the
> hosting providers, maybe even taking the one with the prettiest
> web page. Maybe we want to reword those sections to rely
> more on indirection, e.g. "get the source[link to the source page],
> checkout the next branch", without the quick web link to a web page
> showing the 'next' tree.

Seems to be a nice suggestion to avoid the "main/official" url issue.

To add a little more, it might be better replace the "Source code" link
with a link to Junio's list of public repositories stated above. Also,
it might be better to rename the link to "Public repositories containing
the source".


--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky


Sivaraam?

You possibly might have noticed that my signature recently changed from
'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
new signature to be better for several reasons one of which is that the
former signature has a lot of ambiguities in the place I live as it is a
common name (NOTE: it's not a common spelling, just a common name). So,
I switched signatures before it's too late.

That said, I won't mind you calling me 'Kaartic' if you like it [of
course ;-)]. You can always call me using either of the names.


KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--59ZJ75Dyxa8fErWXggfce6a0gRA6bxDy8--

--PsFXFm4UtxHGvYc7FDMvO7Q0PbqMs2ZWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrxRwcACgkQveda2sPW
GWkhXBAAiB3Rv5yGqOu7i7zlsJcCoSFojbE5AVi/NHolcH5S1gLEZTe3to5AOoQt
qqJ5qYIEZbekblGbH5/szlAeXNu6eZVL/eWLucu4i8DimAhcFzsYnnL3t8EVGt5g
TGbRWaNqkHGe9oWGcLDFjgWFOSk5wDC/A/65O1mHeTx/RLMc7sH3fAAhIugA91bM
lFJN8Em5JSQbRkEtM2tYM4VdNjY+2lgDvisQ5G6C7tQ3CLSab5RRq1vvN4qxSQqs
I2oJ71JWGLoj0jUWEyCw4jypFByhDklYHM2ZMTwM9mkooK0EBQGkub3Nb84qqmt0
/4/1kL/YHVnzK4Znt9flDmEMs5y9Y0aRx9Rqp1bNSZKtxjGHPFycQIhJ5UPyJdqP
agpvtl6l7EnoHLG+e2MsSJdcOMh7II5Btq6+4gm4rWg9sMTKSbHnQmr57BB7BYZi
FxaTsEyPZoCtOJPLAz4FrzDaLDaBcYKZhEXDFUDn0w2XZr3/BveUtowQXfuzxJPV
KLk71YjtVIg9TJ7Mi0ZrOrN13GGLgV8VfKpAyXOS3LfhQuN5JqF5Dxe2gwlG3jh6
8pirOnG+/xjeuBw4/qW4f0GrmoNY/kM0qNuEQlprzc6CIqxkEfiBHcIfKThn68GD
fs3r0vUSdaF/n39LuYWqQPZztMWxm3KDD3eDl1DewLYxDtv4mv0=
=noon
-----END PGP SIGNATURE-----

--PsFXFm4UtxHGvYc7FDMvO7Q0PbqMs2ZWK--
