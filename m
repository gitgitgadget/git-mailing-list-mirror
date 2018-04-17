Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72F881F404
	for <e@80x24.org>; Tue, 17 Apr 2018 02:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeDQCRp (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 22:17:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46865 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeDQCRn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 22:17:43 -0400
Received: by mail-pf0-f193.google.com with SMTP id h69so11419842pfe.13
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=uM82wyaCzy+KkP1mbqTpXYd5i55+aherVCKclnnsONc=;
        b=n4Gq9GnvpuyE3liDkq0kSQUMmXlrMsRPPrCRr0D4fLmwmgQE6Mo1IxvpcJcZxmsUBx
         mMRYHmXkhmCpTf3UB9bnArysL4rv8qJDlmpyLoJOIY6tmbfKQDjV3O5xV/xgiXsFWCAt
         I/Ia/+46vwhByQQo8dsqJ9yoeb7cyHZocIrDJMUHGJh8Lg1SGYiHxD77qZ8XUUBCtMs7
         sNyu8TmnpRDk/R+x3B6/p/+JeoUl7wiINihtTuo60Hcrrrdna6qXkEu7y0+fEiSuSE4T
         PWIsL/XNQpCM+Ixh/B8DjWFWpLW/rCUES1bUymky+/bQZm7Bp+GuZ62luXoE6o4ngkn1
         vxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=uM82wyaCzy+KkP1mbqTpXYd5i55+aherVCKclnnsONc=;
        b=Tt8PhCmyO+SwdLgQRIxO7hiYBngLCVe+vXBYCT8ARJYfFdYBdr6lABMNTHZDxeGzMT
         3P6tOE91Jrsgt+4oQR5WkcwFAep1CXZyKFFXsXiIw1+8hGw5icHssqINpn5Fl8PsM244
         yPJjJHW18oektrEFKXA8koCl5v/Dtl1hHNMzlLXeRXxv8ZF8QKWs5v0wQAVnpFAXqOEB
         WQOnnLvYYyU2Tl4Wz4zaXwtVCTkppnTL/2FZslNv+Q8XZRh8DN+fqQmhpRZ0jgsMZ9Uc
         9DN6dAN/ylXzEi33bY7vVnOntexBqK6vq4/M1feYDoc2NKFHlHA76ZqCjSodwFXnF4ys
         1hQg==
X-Gm-Message-State: ALQs6tAXVh3hnCbkpNTrEHEyx5mhkwu1H5G+SlYcyIVLKW5OzV6ccUzx
        ObW+YHn+VO1sZEIPwGV6ElM=
X-Google-Smtp-Source: AIpwx48vSJ0yBdvT1bD0LJwmYeRnE1ivYdICheprzB3ztfNxWKIZDYqFAwKsV/bPpuLXa9Tf03OU3A==
X-Received: by 10.98.107.138 with SMTP id g132mr211249pfc.163.1523931462612;
        Mon, 16 Apr 2018 19:17:42 -0700 (PDT)
Received: from [192.168.206.100] ([117.249.223.25])
        by smtp.gmail.com with ESMTPSA id y6sm30705799pfg.121.2018.04.16.19.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Apr 2018 19:17:41 -0700 (PDT)
Subject: Re: Draft of Git Rev News edition 38
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
 <87in8rz65t.fsf@javad.com>
 <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
 <87sh7v6vn4.fsf@javad.com> <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com>
 <CAP8UFD34Y0KRY7vqXU_jWGUc3tdDHB1h67ARZxi_vk1EyUV+zQ@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <c805a84c-a29e-6652-d644-ee1ccf4c7fbc@gmail.com>
Date:   Tue, 17 Apr 2018 07:47:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD34Y0KRY7vqXU_jWGUc3tdDHB1h67ARZxi_vk1EyUV+zQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CyxqOZapHM3HJTYJBSOMyypZlelOCsHIy"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CyxqOZapHM3HJTYJBSOMyypZlelOCsHIy
Content-Type: multipart/mixed; boundary="CqEHNb3C3OOWuG5GyWScbZxY3S8KNYeUM";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Sergey Organov <sorganov@gmail.com>, git <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>,
 Markus Jansen <mja@jansen-preisler.de>,
 Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Jiang Xin <worldhello.net@gmail.com>, Jacob Keller <jacob.keller@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Igor Djordjevic <igor.d.djordjevic@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
 Phillip Wood <phillip.wood@talktalk.net>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <c805a84c-a29e-6652-d644-ee1ccf4c7fbc@gmail.com>
Subject: Re: Draft of Git Rev News edition 38
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
 <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
 <87in8rz65t.fsf@javad.com>
 <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
 <87sh7v6vn4.fsf@javad.com> <72f42205-c9c6-03aa-e8df-12e7062e8e62@gmail.com>
 <CAP8UFD34Y0KRY7vqXU_jWGUc3tdDHB1h67ARZxi_vk1EyUV+zQ@mail.gmail.com>
In-Reply-To: <CAP8UFD34Y0KRY7vqXU_jWGUc3tdDHB1h67ARZxi_vk1EyUV+zQ@mail.gmail.com>

--CqEHNb3C3OOWuG5GyWScbZxY3S8KNYeUM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On Tuesday 17 April 2018 03:56 AM, Christian Couder wrote:
> Hi,
>=20
> On Mon, Apr 16, 2018 at 5:07 PM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>>
>> That said, I read the draft and found it good except for two minor iss=
ues,
>=20
> Thanks for your comments!
>=20

You're welcome!

I'm sorry to say that I read only part of the draft  when I sent my
previous email though I accidentally didn't mention it explicitly.

Now that I have read the draft completely I find a few typos in the
"Developer Spotlight: Jiang Xin" section:

1.
"... because I feel it is hard to track changes of GitHub UI and the
book will become obsolte very quickly."

obsolte -> obsolete


2.
"We also developped ..."

developped -> developed


On seeing the section "Light reading" to be empty, I thought I could
suggest something. I'm not sure whether you take Stack Overflow answers
for a light reading but I found the following answer to be interesting,

https://stackoverflow.com/a/6521223/5614968

That's all.

--=20
Kaartic

QUOTE:

=E2=80=9CThe most valuable person on any team is the person who makes eve=
ryone
else on the team more valuable, not the person who knows the most.=E2=80=9D=


      - Joel Spolsky


--CqEHNb3C3OOWuG5GyWScbZxY3S8KNYeUM--

--CyxqOZapHM3HJTYJBSOMyypZlelOCsHIy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlrVWSIACgkQveda2sPW
GWl7yw/+LHCSHkUQoGM7pJdbPC+VO14tMOr/mXi+FZ6hCHJS9zFjPmhgzAcwyHAN
vJWl62dSzkG3h2e3/mCHvM28RxwIW/LwPB4l05diUfNM3WDnhcSwcroMdADU36TY
Ge660L4zfpzdGFc6vkprJXw2AYf5aadKUk2jrx/Ai2EB9XiULSED+eC6GM9+qAaN
XH0cIHFihrtIzC5tJteObD+FsjbaXDQVok6PXsCCuwMhGAkfgTIhPgdBB8xg6l/6
dPsyl6qCvL+lsXyYGuLQdgLqCBakrPAIS3yIW90WOzX2S3G2ncbzwQ7oW8jVZLdp
Xm4HAddiFvwfD5wqA6ytXWyXi1aW0FBAD5teg60jMQX+hx8vvoe3sYdhuI0SCMGV
p3xBthNLXf0azJE/QYmNbHfljYEsvTlz1TQl/HcD6UcfDrSrMX05fyVFUGMscQkS
2zqGenu0XGo+4BYtxUb0JOt5X9D1vslpQktlYrxgjVvk05cug7JwRkgSBoeH6x0c
WLuC0ywMgIBL6N1NUYfkXeEKhmvkMTF592PNE9uixDWtN/1/mnjKW5OuJNw12a+0
u4nHXWwxc3I2SpeHNIM6u0RuMgsa+3e6Zv8YJc1yJG+s28MpvbCAI/FSTBZKuJI3
maoOIsjyC/srDKeRXJlkNlR4uCkBwfV6R6Dir+CQkoecRyfeBp8=
=g5wB
-----END PGP SIGNATURE-----

--CyxqOZapHM3HJTYJBSOMyypZlelOCsHIy--
