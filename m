Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF0421841
	for <e@80x24.org>; Tue,  1 May 2018 11:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754251AbeEALlX (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 07:41:23 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:42054 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeEALlW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 07:41:22 -0400
Received: by mail-pg0-f45.google.com with SMTP id p9-v6so5301216pgc.9
        for <git@vger.kernel.org>; Tue, 01 May 2018 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=7dklfwS4tj/wX6FTHpFJuFJDyO9M4EGLqPFZ+juFXzE=;
        b=SF0BnDi4xJ0za381kTF9yFfWxRHj4X4VZdZDXFKai3SojffmNPkzViM3ms9Wlwvoxu
         wbPFFU1tzg/SsJq6vuvnCx1DXDqArUH/lAPhn5uAK+sojsKC1HMrwG82U2ovUeA1AFen
         0Q7tEFwyD4U9o6/i9JY1n7FHntas7td8H0ZB7OUilk4ZM8/8GvWqMZf7ff/OlEQZ4XiS
         zR7UifZryTnpBE6RsduCUWcVrArHgZg35F5EJMHIKo7AJoGW3C2EV8cB8nBnCE0wVEK/
         FV0MUEiLJn99VEDQHfFor1KSjlYpwAuVj8X4BobKgZ+IVZOSDq9X3vzwcZC29Q8pHQx0
         vD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=7dklfwS4tj/wX6FTHpFJuFJDyO9M4EGLqPFZ+juFXzE=;
        b=olXDBsDkFd1IemuVBw/exNmpK0BTUzTqIELM5vZm1x4WFG1z56xD+L727R/YTDV14n
         S5+E1kcX+Kwd+u6/Ma+dKMb71Nf2XKUHpYHpYVuV7uGpyRgJQMc9zEvz6VbN7KWMcHBx
         1y4O74snqAw/yQSmpxxixd3St2H7mD2mMMskapFcZZiR0olUd6fzW7Z2AbkqmL0KknCf
         9OLnQlFG6XNCsTKW3aRnBdUeFlYaTDqeKLCkBe8V5rRQ+/IzJhVE3vVDh+39FmCFSR3P
         7o5laQLsCcKVNn3v2KhsMEblEdmp8lo6RBiHO6+iqUsy6QDT4EVpSFcS8QdDYy2AoVIx
         8RNA==
X-Gm-Message-State: ALQs6tDpY+qBwPWyQERwdTG0HLvaGTUG6f1ZKUQZ6TbV5aDo5t/g0QR3
        RI++pW7OUFSXBGD1BJGvyCkxwqaB
X-Google-Smtp-Source: AB8JxZqRUqmI/s9yWkkC6qV9MB4i6PM2x0vjxyjlR5wJmzKY3kk2W9EdP/KwPB++UX4sCKKlV8Xpew==
X-Received: by 2002:a65:55ca:: with SMTP id k10-v6mr13053297pgs.422.1525174881320;
        Tue, 01 May 2018 04:41:21 -0700 (PDT)
Received: from [192.168.206.101] ([117.251.224.161])
        by smtp.gmail.com with ESMTPSA id o2-v6sm15604103pgq.87.2018.05.01.04.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 04:41:20 -0700 (PDT)
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
 <xmqqh8o05evv.fsf@gitster-ct.c.googlers.com>
 <08882cea-5dab-3cc7-33ac-cf938253a34a@kdbg.org>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <5399f852-baab-6d65-6bac-9b61f5bff6ba@gmail.com>
Date:   Tue, 1 May 2018 17:11:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <08882cea-5dab-3cc7-33ac-cf938253a34a@kdbg.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MPb9KsGqUcezZTqdvDWRGDvjvK2cJMblD"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MPb9KsGqUcezZTqdvDWRGDvjvK2cJMblD
Content-Type: multipart/mixed; boundary="ejfdfz4wGTdqeXcoD7sOJvm5sc0x89VeY";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Cc: Git Mailing List <git@vger.kernel.org>
Message-ID: <5399f852-baab-6d65-6bac-9b61f5bff6ba@gmail.com>
Subject: Re: [PATCH] git: add -N as a short option for --no-pager
References: <d91e98a8-7801-a3de-3865-f0480e18ba0e@kdbg.org>
 <xmqqh8o05evv.fsf@gitster-ct.c.googlers.com>
 <08882cea-5dab-3cc7-33ac-cf938253a34a@kdbg.org>
In-Reply-To: <08882cea-5dab-3cc7-33ac-cf938253a34a@kdbg.org>

--ejfdfz4wGTdqeXcoD7sOJvm5sc0x89VeY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 April 2018 11:55 AM, Johannes Sixt wrote:
>=20
> I considered -P, but thought that it would better be reserved for
> something related to "paths". We have --{html,man,info}-path, which
> would be served better with -[HMI]. That leaves --exec-path, which we
> would probably abbreviate as -x or -X. So, -P is perhaps not that bad
> after all.
>=20

It might be a good choice but I don't think it's not the best choice
anyway because '-P' doesn't seem to communicate 'no pager' well.


> Perhaps --no-pager means also "unpaginated" (-u, -U), "linear" (-l, -L)=
,
> "streamed" (-s, -S). Other ideas, anyone?
>

Considering the other alternatives you suggested (as I couldn't come up
with a better "single letter" option ;-) ), I think '-s' might be a nice
choice but would possibly need some explanation in the documentation to
the wondering users.

In the end, lacking a better one letter option, I think '-P' would be a
better choice after all. It would, possibly, be easily understood as a
negation of pagination (-p). So, I guess it would be better to go with
'-P' than '-N'.

--=20
Sivaraam

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky

KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--ejfdfz4wGTdqeXcoD7sOJvm5sc0x89VeY--

--MPb9KsGqUcezZTqdvDWRGDvjvK2cJMblD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlroUlsACgkQveda2sPW
GWlNZw//XNpZbTcuj/Qd0jKhxsyHFI7OZR0kSJEm7AmFz6x+XkeJHuz/5uX25SZQ
SXAAT6t3EDQHfuD5pt8yyokIzDmmbNGbJDTWFZgHSeD9mW19NJv06PTClMbHTdgx
fy3f2KM//h59unUtZg3EHMKNPoXtXcjGDKTs4qnOAQbGNmKav2hb2yXiKuv1q8s4
Yv1M92Ugi3xqzIcYdsmNtoi7/TUgwDcWFPaX2vwya30fQb/4cHlUcPBH3GOSVYz9
qe6VQaelklVmDCrbYBr//xFHI0YwoU8jeVMCA67S5XY66+8jCbFc5ximLfDvx8VV
h3MDOs3L6CXUuzgzCNS/GeOREs+HyEEVXQGXu1a3BPYbcJlTTjP/EYiIJANw9wub
K/tKPGYSQvZBmLJDXHoZB4YbCSuxD+Wwe+I+mSmFIdZwWPtRcWYuC+K+pBcQVIyK
MoJz/Wo6nLXtmubJKTwjKx/3gjCAfzK0IRO6Uq7yyaeklNAxs0NFokUd8csGLh19
P5U7KHvohb0Ky2WqQLN1fouPLb9mi1910F4i4yYvrXDodTtxyT6pDAwCEo7s9p7q
kT6UlcEzwQntQ4IckOIo/vHhJ/S9XvPN6Ipq+ehbi7G0z3PFD7NQZN9kN9+ilV05
UKjfFmHiQdCQDYGunOnriAteSAPbYOb+g8bxRVrhE+IX5rKj274=
=VgZ5
-----END PGP SIGNATURE-----

--MPb9KsGqUcezZTqdvDWRGDvjvK2cJMblD--
