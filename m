Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5DB2023D
	for <e@80x24.org>; Thu, 18 May 2017 11:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbdERLu2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 07:50:28 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33669 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933058AbdERLuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 07:50:25 -0400
Received: by mail-wm0-f48.google.com with SMTP id v15so11204967wmv.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=RfhezJokOFAyovRSt7m0rpAudj8OGCvD3CruzHavJFM=;
        b=mTLaSmz3ghYUn5ixAuAndxVVGAGSgBhdxUGg1BZn1zmvK0cMJ2MQDTYsvEtkKW2Gcw
         GeK/x43LiTKBmuJSKzgKkm8lxvN48+Q7izrddVRdFcAFDz6fOv7C2s+WeXZkgu/4mPc6
         DkzBdwIoMjP+Vtta6/3n0WTE9PKVWqe0zq0WkHuKO6f7O3VXbvWGvVI2j987jlKxc55c
         AuPPTCe4YdH7K6l/KgIzoWe+wgB7iNjWAqStKfiGmGjFHAiLFczTM51Ja9pVdDI/mjDK
         4L6IjZSnUnljiwVMKnZ1ApnrJZGTJ6U3kbuLbEl8lAR85j0glkqLr0D01aggYCtKe7oF
         2bCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=RfhezJokOFAyovRSt7m0rpAudj8OGCvD3CruzHavJFM=;
        b=sB/byzuQ+O1H0MABgg68Ek7v8ho2cuWMqFQw9Yg/KePz6FwrJsSuSH2nT+wDoGN/ek
         3ZpghBB+BLdl9sd7sFvkrTeDQ4kaQiKjb0JArCWoNzPdET3Ur0nTVHOwIMIR+DsFnlom
         BmbPisqHdjrtMGy2byuxsg+m+3svu1kQv/bqr9zenryyGn2U2IgEvgNxGi3cBQqWs3X4
         4lIMMgXseIu3J9gUdjU9lrEvd67sKQp/QPvX/gwNXeeQB0U/h7hiC6SwjM7wuz2wTI2y
         yN3p2Mskq9TS4y2pdqsGMRh7jdi0UZQ8wk1HRzoA/SA1EirZUen6pHode5arzpGU9TWx
         BOow==
X-Gm-Message-State: AODbwcCOPu+jYGGal9Y+VCGsVNxhBdbkUgG0cQlSeeCM22l9gfrkxIbO
        NvVsrxwsTW/3KQ==
X-Received: by 10.28.62.81 with SMTP id l78mr13807821wma.105.1495108224032;
        Thu, 18 May 2017 04:50:24 -0700 (PDT)
Received: from [192.168.1.22] ([37.120.80.31])
        by smtp.gmail.com with ESMTPSA id l27sm3970442wrb.65.2017.05.18.04.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 04:50:23 -0700 (PDT)
Subject: Re: Is it possible to use new conditional includes outside of git
 dir?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Raphael Stolt <raphael.stolt@gmail.com>
References: <b18ddd8e-5772-6351-6e49-78c1372077f1@gmail.com>
 <CACBZZX5z_jn3KnpgOBE=qa1cUcUAABPwuzqG81Ry0ztvMm4nAw@mail.gmail.com>
From:   Mihails Strasuns <mihails.strasuns@gmail.com>
Message-ID: <4a8c79b3-91e4-6f6c-23c3-74df023ffdf0@gmail.com>
Date:   Thu, 18 May 2017 13:50:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACBZZX5z_jn3KnpgOBE=qa1cUcUAABPwuzqG81Ry0ztvMm4nAw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9mCJmllcl2BsbOhGMCfBt2k17t7QpXJD0"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9mCJmllcl2BsbOhGMCfBt2k17t7QpXJD0
Content-Type: multipart/mixed; boundary="Hwl6ew0Wlwfs6AcWCNSq0vdaHgRJrOdWq";
 protected-headers="v1"
From: Mihails Strasuns <mihails.strasuns@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
 Raphael Stolt <raphael.stolt@gmail.com>
Message-ID: <4a8c79b3-91e4-6f6c-23c3-74df023ffdf0@gmail.com>
Subject: Re: Is it possible to use new conditional includes outside of git
 dir?
References: <b18ddd8e-5772-6351-6e49-78c1372077f1@gmail.com>
 <CACBZZX5z_jn3KnpgOBE=qa1cUcUAABPwuzqG81Ry0ztvMm4nAw@mail.gmail.com>
In-Reply-To: <CACBZZX5z_jn3KnpgOBE=qa1cUcUAABPwuzqG81Ry0ztvMm4nAw@mail.gmail.com>

--Hwl6ew0Wlwfs6AcWCNSq0vdaHgRJrOdWq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 11:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> It's intentional, but in the "that's how this works" sense, not "we'll
> never add what you just asked for".
>=20
> This came up on list last week:
> https://public-inbox.org/git/F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail=
=2Ecom/T/#u
>=20
> So I'd like to ask you the same question I asked Raphael in that thread=
=2E

This came from the GitHub CLI tool I use
(https://github.com/sociomantic-tsunami/git-hub) which stores own
configuration in git config (i.e. `git config hub.oauthtoken`). Some of
its command run outside of the repository context, for example `git hub
clone` ensures creation of a personal fork before doing regular clone
and thus needs access to the token.

Thus I hoped that I will be able to use new git functionality to
distinguish between work and personal GitHub accounts same as it is done
for name/email.


--Hwl6ew0Wlwfs6AcWCNSq0vdaHgRJrOdWq--

--9mCJmllcl2BsbOhGMCfBt2k17t7QpXJD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFPBAEBCAA5FiEEcdkabkQjfDM/yGOXratW3TZssTUFAlkdin4bHG1paGFpbHMu
c3RyYXN1bnNAZ21haWwuY29tAAoJEK2rVt02bLE1atMH+wVcVMj3Olz2Zi2ctsob
pHNyejfsC1knKd9Q3GbFYEor3kalPg7UKG26nsDOOwEV6CX6GeV2X9yTg9LPat4R
dUSmF95boWb9bBl2nL2MKjh7umVu0ci9rcrFy4cXrXWF0rLCDCiVXfr+H5PWe+9M
jf9Hr++paHHF341JUU4lr0+04SDACxkeEYL8yfjLYpPYxbOpgJelT7Qo4lWShQ5s
xsYSTH/BRjn9OgNy4A7+/ASFVOXmjIuI9NH5l0zKlk2rBn53/oE4IfIxC00rbnfn
xEe8C4+1asABXahn0PrtpNMIRUAtEaLpJKHBQ4fk03Mho1njH+vR9eNAND3MtCIx
+sc=
=K6VN
-----END PGP SIGNATURE-----

--9mCJmllcl2BsbOhGMCfBt2k17t7QpXJD0--
