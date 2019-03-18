Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0109920248
	for <e@80x24.org>; Mon, 18 Mar 2019 08:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfCRIyK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 04:54:10 -0400
Received: from mx-ext.e-mehlbox.eu ([81.7.14.185]:42531 "EHLO e-mehlbox.eu"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbfCRIyK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 04:54:10 -0400
Received: from [IPv6:2a02:908:17b:a80:527b:9dff:feb7:e60] (unknown [IPv6:2a02:908:17b:a80:527b:9dff:feb7:e60])
        (Authenticated sender: alexander.blesius)
        by e-mehlbox.eu (Postfix) with ESMTPSA id 710CD133A200;
        Mon, 18 Mar 2019 09:54:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=blesius.eu; s=mail;
        t=1552899247; bh=+kgfife4TbYRU56WCgA6w8UCLQGCjLLVDQT+Nv4Cs4g=;
        h=To:References:Cc:From:Subject:Date:In-Reply-To;
        b=Q9uGlXrTSpFsYBdz2dHplF8/9fzz3bJaaJTBXLAWitRh4BLnPUZfbpQS0mr8vlyAq
         T8QR6IAoEa5H48zQApkuQHLzKNSGaZMMw9fC8LfevjAf+qf2vqTjuWGBQIID7mr7kS
         cxCQGwJ7AON7FppZ3t81hYVyKtvA5wGJ84h6nXB4=
To:     Junio C Hamano <gitster@pobox.com>
References: <6e00f5fc-13a3-a9b9-d964-f787ae194a73@blesius.eu>
 <xmqqef744u2f.fsf@gitster-ct.c.googlers.com>
Cc:     git@vger.kernel.org
From:   Alexander Blesius <alexander+git@blesius.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=alexander+git@blesius.eu; prefer-encrypt=mutual; keydata=
 mQENBFO5X3UBCADDxy2dppA+7A+KEXWx3rS44pdKC6nYx6m3XEWxfs45CKbSq0J88Zupmqrw
 M0MWK/KbzeBQ0N2IjHp8DaflY7pI3uDOoDqKZ5GiAeXIpaeBDD6z3am5/abQRG5oY8Zy2O+3
 OyA78R9LnbMRXvb2+mOfPZYGA14zkhAlGUj8u7Hm3n2IkVJMlKjpYnj1GZcgc+01nnnUT3fn
 0lhGkcxzOiiGkMWaZ5Nyh5sYEDGhFquySGFihmbbxkNsqXD8MffqQc2N7rrxl2GOnAlTlNG4
 XwLscJC8XgF5x+ChrQyrgcdhoXsd8E/PXawkwWVPWr1eNP3BXjBlczT+9qnziM7A+ZqzABEB
 AAG0P0FsZXhhbmRlciBCbGVzaXVzIChwcml2YXRlIG1haWwgYWRkcmVzcykgPGFsZXhhbmRl
 ckBibGVzaXVzLmV1PokBWQQTAQIAQwIbIwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAhkB
 FiEEeKbtWWINxpqa7GJ7r0HG3q8DMW4FAlmpF0IFCQ9VuU0ACgkQr0HG3q8DMW6Ztwf7BDK2
 V6Nv+qoSC3rqPV9Mzu0JXZJ9QSJzf+B+DZLFP0iHmPhcKUidYs2ZibqsMVB7+jKLsmEtqJJl
 EjLZ+aSoQXGDsdnntV/4QvtSoCuqUeBQO8gm2OlPk/uBUdwKLup48LaebpqN/pd/EDKcE67K
 +u8F197Hg0pARUJ5iJEDn0ciDw/u7ycNruPNndCiNVg/28w+5sVOlC7g6C19CAMQo1dwc4D8
 ARTXteNePPAiNbnmJaXFLNxSWVAbyJe98noqBlEsVzhy0YlEIpAhlMFn3E/+dwhurBXTpKdW
 o8cXiMvb0I85W0s9+yjYtnqVJlNYSLuPIkAqU7hUnjla0LIrrLkBDQRTuV91AQgA5kINGMjs
 ZMaFKgxrabujJsCUY1mL7CCf2JOfAB0MuPBVi5O6mK5lrIMD+vFhJll2+rHGvUApB4CMt4OV
 hiqzUjuO6pmIoBl/QzFic8/I/KG3tuCciz3HrDwYiGSpe684THqELb4JFYCi2rzEOJm462g7
 VI507hqaG3JBfjZFIsg7atwKGseaJpHwY2zW5wpbpE6xH9+8X6Q3DTeUru9SlD/Pu6crE/We
 5tEgzneMaewLNnEoL2tSsLv6lr7ZB6zaAM9VyW59W30VxlIXoeQl3lUM/XQG/8wnKCTqKlGA
 DxieeVds0G5SqoLuGoq0oPiruPXm+meZSFMNu2mBqIA0QQARAQABiQE8BBgBAgAmAhsMFiEE
 eKbtWWINxpqa7GJ7r0HG3q8DMW4FAlmpF0cFCQ9VuVIACgkQr0HG3q8DMW52mwf+PoUtEap+
 DTv+/T1ZIwSabpuz28NsZj/O1kJBv8PJ7xLC5jKzpU5cIFIv2AG0bqZzFsgDRZBfB8SW0QgY
 8lqHovxSF8V5RgnzhJNMYmPKWGsvWHrWiafh+YXrT5NBSQmpZD61yYEF64CUIXe9pbFPSdex
 Aye81qKTWjekoVa35VsDmXq8zskXTHZE9NKngL5mTzSSwFzivrWHy6IhMHZhpEXsU3bfaDpu
 GCpHlNKZZIsN64CiE3js4BsyGd42mA5DFA0NJ0PugWmPV3e1WhU9yBcYyR2IMqOujBofIVKr
 AI4eVDrld6ki2Dh1g+AnACyCG4XEXqhaKWa5/lg/E4X+0Q==
Subject: Re: [PATCH] doc: fix typos in man pages
Message-ID: <9a283595-490e-81cd-9d88-4cc59ad893e9@blesius.eu>
Date:   Mon, 18 Mar 2019 09:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <xmqqef744u2f.fsf@gitster-ct.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gRpypkz5KdqDD84BjtQOYlRi4lfGkyMB4"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gRpypkz5KdqDD84BjtQOYlRi4lfGkyMB4
Content-Type: multipart/mixed; boundary="Dk1zuUtDvwPi4D3uBqeG7xUTmIuwzlT1s";
 protected-headers="v1"
From: Alexander Blesius <alexander+git@blesius.eu>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-ID: <9a283595-490e-81cd-9d88-4cc59ad893e9@blesius.eu>
Subject: Re: [PATCH] doc: fix typos in man pages
References: <6e00f5fc-13a3-a9b9-d964-f787ae194a73@blesius.eu>
 <xmqqef744u2f.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef744u2f.fsf@gitster-ct.c.googlers.com>

--Dk1zuUtDvwPi4D3uBqeG7xUTmIuwzlT1s
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: quoted-printable

On 18/03/2019 06:42, Junio C Hamano wrote:
>> diff --git a/Documentation/gitattributes.txt
>> b/Documentation/gitattributes.txt
>> index 9b41f81c06..908d9a3009 100644
>> --- a/Documentation/gitattributes.txt
>> +++ b/Documentation/gitattributes.txt
>> @@ -314,8 +314,8 @@ stored as UTF-8 internally. A client without
>> `working-tree-encoding`
>>  support will checkout `foo.ps1` as UTF-8 encoded file. This will
>>  typically cause trouble for the users of this file.
>>  +
>> -If a Git client, that does not support the `working-tree-encoding`
>> -attribute, adds a new file `bar.ps1`, then `bar.ps1` will be
>> +If a Git client that does not support the `working-tree-encoding`
>> +attribute adds a new file `bar.ps1`, then `bar.ps1` will be
>=20
> Or s/that/which/.  I am not sure which one gives us a cleaner
> result.
>=20
>     If a new file `bar.ps1` is added by a Git client that does not
>     understand `working-tree-encoding` attribute, then ...
>=20
> is how I may write it, though.  I dunno.  Let's take yours at least
> for now and let others complain if they care deeply about it.
>=20
>>  stored "as-is" internally (in this example probably as UTF-16).
>>  A client with `working-tree-encoding` support will interpret the
>>  internal contents as UTF-8 and try to convert it to UTF-16 on checkou=
t.
>=20
> Thanks.
>=20


Hi,

sorry about the MUC wrapping, will be more careful next time :)

As I learned it, commas are used around relative clauses (sentences
introduced by "that", "which" etc.) only if they are non-defining, so if
the information inside that sentence is not necessary to understand the
sentence. While I'm not a native speaker and therefore unsure how much
that would matter to a reader, I think it's better to use the
grammatically correct version to avoid ambiguity.

The question whether that or which shouldn't matter too much, I think
both can be used interchangeably here.

Thanks for your feedback!

Best regards,
Alex
--=20
Alexander Blesius M.A.

Please consider encrypting your mails with PGP.
https://emailselfdefense.fsf.org/de/


--Dk1zuUtDvwPi4D3uBqeG7xUTmIuwzlT1s--

--gRpypkz5KdqDD84BjtQOYlRi4lfGkyMB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEeKbtWWINxpqa7GJ7r0HG3q8DMW4FAlyPXK4ACgkQr0HG3q8D
MW4UwAf9GEXlY86VRhSqL3fOV2iVFHoto9qoLB1Y8B73cU8NKj0E4TwyUmTZo3KT
jJeNrHMbGa04/Rs8aO4c0nYHqXALQZ+7QH3qo+skOUHg7xFaxj74KpMncpZFYLUM
wmLepvAH7d377Zmj9FE6zsg9fI0tVzXn9dm5ZzlZtfN73HmqlzqZikFLsONV9uER
13HVkGpfn4r0RYZSMY/AEcSsAZ5eLv9ymtwF8uHCzQ2iLTgJRr/uULgtvz0QZdkf
Ni+dMUz8CUQ68vWSnbgpp4k6tj7VucmIRLFyqBcXqp/gyKfMuyoF6eDA60RCxOnY
KDJYmnUc+dU2GgX/aHQucJ2XTcC6yA==
=Sqsa
-----END PGP SIGNATURE-----

--gRpypkz5KdqDD84BjtQOYlRi4lfGkyMB4--
