Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D3B20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdCVWQC (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:16:02 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35269 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbdCVWQA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:16:00 -0400
Received: by mail-qk0-f195.google.com with SMTP id o135so27936957qke.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h7vmzKXzOtCQiwS0NgBMRSKrS/qHE5uopCAtnrrkfZE=;
        b=YaT6RemJgXHUhomEp261TNSq26Ccp9l/Mz4kbhwqHkjQ+Eov7BAhArnUYY1cCoL8a9
         Zl4tdcM++ANyHWu0k+FQkNOvKm5W1nttphyKj5Ur8P9NOqEPqtI9v+nlRfv8GyhPPkwK
         qBleVP5E9Glv3qiwPL8dG+HSPCFFzycNRw0DmwZcI7y5rusnAnpf4QZOQE6ZuHJq/V0F
         7sirXw9rqvkyHpIs6QMZ/DCorHorw+DEv8tcNxABfJ5mynNPyMExIqkCtVVm1Me6tX5H
         YVrkABV39vjiiuZCQOGwNQaDe+uWCRhrJ9RcC9ttTw4ePaDtp6tIY5Iv/77hQvsawiEZ
         MA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h7vmzKXzOtCQiwS0NgBMRSKrS/qHE5uopCAtnrrkfZE=;
        b=Vwt5f/57MYPZVF0W44Lo0ahm8TJbSGzwE3+TQDwb4WowHPwWnp/UoImgs/Hcdfw9Uq
         Zg+5rWG2vRhgDeOic3UU1+fvr1DxPvUzhU8DfNkKVpZphj9Zrz8Hg+lbsd/+PPj8iL2+
         Ui8V8zEDbu1cK04GO4kXNbWilEKHUfbc7HKaBLBNI95odC3/d0d+cn/FSumjhkZvFX74
         oHVGD/VTxQSfLpBBO/DlwueffnqKev0HUkJKk129JDEJE/O3MFimSfVaRHAeQWTkS95M
         qsovEoRyREHoCDbi/0u+Dh+BayQbQEwhnNxPk5tmGKIqDsIgJy6EUyqfGx/4Mn7N+meQ
         YEXw==
X-Gm-Message-State: AFeK/H3kcu7n7wqPdjpJf/Lxq+k5GCHs31TJL9uCj1IV5G0/E3JWR3G/X4m5kM2Xrtqd4zYR
X-Received: by 10.55.128.66 with SMTP id b63mr42442605qkd.297.1490220958536;
        Wed, 22 Mar 2017 15:15:58 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id l6sm1895375qkd.66.2017.03.22.15.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 15:15:57 -0700 (PDT)
Date:   Wed, 22 Mar 2017 18:15:57 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 3/3] t7004, t7030: fix here-doc syntax errors
Message-ID: <20170322221556.j7uj4vvgbcubcr3b@LykOS.localdomain>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-4-gitster@pobox.com>
 <20170322211003.b52cql3iwig2xqcd@sigill.intra.peff.net>
 <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s3y2mq5s5qcdgzj4"
Content-Disposition: inline
In-Reply-To: <xmqq8tnxhssv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s3y2mq5s5qcdgzj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 03:04:32PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Wed, Mar 22, 2017 at 01:08:05PM -0700, Junio C Hamano wrote:
> >
> >> From: Jan Palus <jan.palus@gmail.com>
> >>=20
> >> These all came as part of an earlier st/verify-tag topic that was
> >> merged to 2.12.
> >>=20
> >> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >> ---
> >>=20
> >>  * This should be applied on top of 4fea72f4 ("t/t7004-tag: Add
> >>    --format specifier tests", 2017-01-17)
> >>=20
> >>  t/t7004-tag.sh        | 8 ++++----
> >>  t/t7030-verify-tag.sh | 8 ++++----
> >>  2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > Like 2/3, this one also produces test failures for me. It looks like
> > "verify-tag" does not show a tag which has been forged. I'm not sure if
> > that's intentional (and the test is wrong) or a bug.  +cc Santiago
>=20
> It appears that the test expected a broken one to be shown, and my
> reading of its log message is that the change expected --format=3D to
> be used with %G? so that scripts can tell between pass and fail? =20
>=20
> So if I have to judge, the code becoming silent for a tag that does
> not pass verification is not doing what the commit wanted it to do.
>=20

Yes, considering the test name is:

    "verifying a forged tag with --format fail and format accordingly"=20

It feels as if the behavior of verify-tag/tag -v is not the one
intended. I could add two patches on top of those two commits.

Would this be enough?
-Santiago.

--s3y2mq5s5qcdgzj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAljS95gACgkQRo8SLOgW
IpX/8hAAzcbzDVVE2ERsQYrt3szieTnI/9MAeqW3/2St/KB21rxLDvA11En+ukky
QwTqeZ8/rleKs/yRWmxECOKMEvhiKsPEmxeXadncZ06y2OT9AekmjkhgmFP7J27k
Iz/gGsjFX3TAf6Tw9flDiOkzrvStqsfeT7vqQ+MJwW5KKeJyyHKEp3DxXc+fdjvr
KELbEqYEYaDdP/HEDLKRGPfX01/TxNrFhA5j6IqI0ol7DKxDV8SnYSg9I2v5llZp
ruk8nuyLJ/Uo4YVtMQZignNeecWcelrVv++j8aqAcn24lnkndanKlI5xQ67OMcNP
91rfS5NLUNp+B7StLEkkbhllkR0LkiWBDSvNRFpWF5Hw1v/S7BHiJSGGhoMcnCPR
hEFaojtW+q9L8GvAtSPpYgwEtum6W1ct8M9NkUhpJE0GWjDT5htdyUcLjyS4UQFP
J6hgWDTsBY7spEyNwYghWIux2A/Dsx5cstwgEptYPkd3VEWOTd6ID4sgxMrvIXLo
gpOlQwRJZGPs2NitbGGyrVGN8p+hXtm1E8kgRReI6c0/oMwMkr57wRuOz+c0s5fQ
SolItDBu7WGkMWZqUPPDm4MUUUv0NIY7/UNycO8R16hjv/kxF2n+YSTVXT2Y2R/+
iG3R4S87fV0ErX3CrC0g1xzcZbgStLj2qX9a6AZvSdLCC8HVroQ=
=QXFj
-----END PGP SIGNATURE-----

--s3y2mq5s5qcdgzj4--
