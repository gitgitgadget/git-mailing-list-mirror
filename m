Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77001F4DD
	for <e@80x24.org>; Sun,  3 Sep 2017 18:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdICSUY (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Sep 2017 14:20:24 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34067 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdICSUX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2017 14:20:23 -0400
Received: by mail-qk0-f170.google.com with SMTP id z143so3069997qkb.1
        for <git@vger.kernel.org>; Sun, 03 Sep 2017 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7NExJEtloBvCvShSG9HgMHftifDkiDLANLUxAQ6no2s=;
        b=WvImXF+Ch47V9b7h0EKeWKxfKdNqMLz29KDqzlu8pwlIrkN0LI4fYjLcpepPVNYNtG
         M1BM6GJLwVhYbodVFlMtJHKU3I+hc2doA6+CJaCUFGDqE/Wb0DWC1t/Imf6jLYQFxaay
         sADrNWP1yzdVkMpX6EJ3b6X5+gjQaj7TObPNh/DN9bgWDp5XFlfSoYLrPuO5gJ/jtlSx
         ZRKoLr2EqPQZr3kP6I0bk4pwLa/oRQOXePNk2IBe5pBGBxAIhWVQaunSQTrZnDLCVZWz
         NcLFPdCeXU29/rwAsPqvaxKV6kQo7AkQKEuc2a5+5HfV81lqvV4ZqB6XPRc00nlzPAov
         0uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7NExJEtloBvCvShSG9HgMHftifDkiDLANLUxAQ6no2s=;
        b=P7YzxnWgvJnibjIQigl1OXoiUqnQInCW+AwSDtDmD+dWWQyIQEyuy/HfemLVzL+QSw
         Od97F2QrqSG1YQNiEOMscs78r9DHU28IgL5t1AYvT9XloZ5bN6Wygxj412gZ0x+Gsw9O
         ZWxfQ6u4rorTmoTnEeZVCn7qdFGZaiVNYysM1KwuPJ/G8rFC47FyLvLRKHIpcKDlJusO
         UbxiQ74DyZwUdgcluYcFFi9BngsFEOVIDceY/o+yIaYMpubYSb15nGmkap14vLJQesEE
         Gybw1uWSCk04FI68MuF54UtqsLkfQxMSZH9fQ6ke9ydLoa1pMM6M/eGXQlCeHPo8PzT0
         acyg==
X-Gm-Message-State: AHPjjUgPd8hXoaKITuMt6qmIIpXHs8dJc0gjOG3kZNCgtlaeLr3WAboa
        U52H0a9UB1EdHYls
X-Google-Smtp-Source: ADKCNb5NM6NezxiOMQJbdOiSQQnQJPYRLbyX++w5q2EAHWIJj2uCrLDdyg96cl2np/T/edgGwGSUcQ==
X-Received: by 10.233.237.16 with SMTP id c16mr2634381qkg.304.1504462822443;
        Sun, 03 Sep 2017 11:20:22 -0700 (PDT)
Received: from LykOS.localdomain ([2604:2000:8209:6800:c238:96ff:fe6c:25f])
        by smtp.gmail.com with ESMTPSA id j126sm336576qka.97.2017.09.03.11.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Sep 2017 11:20:21 -0700 (PDT)
Date:   Sun, 3 Sep 2017 14:20:54 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     shawn wilson <ag4ve.us@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: signing commits using gpg2
Message-ID: <20170903182053.fnyxly5537zjkktc@LykOS.localdomain>
References: <CAH_OBieqSY8To9okRTL-z5dnjW=_NLzA+n5-7=eou=Lx33hBdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq54jfr4nh4gip2i"
Content-Disposition: inline
In-Reply-To: <CAH_OBieqSY8To9okRTL-z5dnjW=_NLzA+n5-7=eou=Lx33hBdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jq54jfr4nh4gip2i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 02, 2017 at 05:11:50PM -0400, shawn wilson wrote:
> tl;dr - how do I get git to use gpg2 to sign things?
>=20
> I'm using gpg2 (so no agent options are configured but an agent is
> running) which is configured w/ a Nitrokey (Pro if it matters):
>=20
>  % git commit -m "Initial."
>=20
>                                  gits/bash-libs (master =E2=9A=A1) localh=
ost
> gpg: detected reader `Nitrokey Nitrokey Pro (000034670000000000000000) 00=
 00'
> gpg: pcsc_connect failed: sharing violation (0x8010000b)
> gpg: apdu_send_simple(0) failed: locking failed
> Please insert the card and hit return or enter 'c' to cancel:
> gpg: pcsc_connect failed: sharing violation (0x8010000b)
> gpg: pcsc_connect failed: sharing violation (0x8010000b)
> gpg: apdu_send_simple(0) failed: locking failed
> Please insert the card and hit return or enter 'c' to cancel: c
> gpg: selecting openpgp failed: general error
> gpg: signing failed: general error
> gpg: signing failed: general error
> error: gpg failed to sign the data
> fatal: failed to write commit object

This seems to be an issue with your gpg agent configuration (even if
there is none).=20

I can't seem to reproduce, although I don't have a nitrokey, so this is
most likely an issue with either:

- the PIV/CCID interface of the nitrokey using gpg2. I"m not familiar
  enough with nitrokeys to debug this, but keys are usually super
  paranoid when signing arbitrary buffers.
- the fork call within git on gpg2.=20

I think the second one is rather unlikely, but it's worth giving it a
try...

                                                          ~ localhost
> -----BEGIN PGP MESSAGE-----
> Version: GnuPG v2
> [SNIPPED]
> -----END PGP MESSAGE-----
>=20

I noticed you didn't try gpg2 -d foo.gpg? Am I missing something?

> However, if I try this w/ the old gpg:
>=20
>  % gpg -ae -o foo.gpg foo
>=20
>                                                          ~ localhost
>  % gpg -d foo.gpg
>=20
>                                                          ~ localhost
> gpg: detected reader `Nitrokey Nitrokey Pro (000034670000000000000000) 00=
 00'
> gpg: pcsc_connect failed: sharing violation (0x8010000b)
> gpg: apdu_send_simple(0) failed: locking failed
> Please insert the card and hit return or enter 'c' to cancel: c
> gpg: selecting openpgp failed: general error
> gpg: encrypted with 3072-bit RSA key, ID 41826CFB, created 2017-03-13
>       "Shawn Wilson <ag4ve.us@gmail.com>"
> gpg: public key decryption failed: general error
> gpg: decryption failed: secret key not available

This feels like an issue with the interface to the key itself. Can you
start a non-detached agent with --verbose to see exactly where it blows up?

We probably want to continue this offlist as this seems more of a gpg
issue rather than git. We can always come back if we figure out this is
something git related :)

Cheers!
-Santiago.

--jq54jfr4nh4gip2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlmsSAIACgkQRo8SLOgW
IpUL6w//U9YnJMrhxdo1ALqhvoC4jjteDvv+dK7VCndrpFbDpkXtDWVFiYFFPgin
nrh7kpiNkUTVY6FiPRQ4EUrxqql8wgADe02gyDaUTsLl6eKKNjvitENeHqtUW7oO
APwNrFpGV2JolrattqQKMZKyg2CTcYjLFlho1kb9BF4Qu9S5Xfi1xPoVBLpL1c+B
bNKZfvJXKTMaVdPcQICn1WbPJk+wmyakkok4KoxT/AJNb5Q2TlLgMlGJz7JE+uE8
rbvsxPYtcsbUJbgHDr6q4p1IhstVHkO/xIj6zl59hCCh89uH8R91HTToUr5GOZhO
AtKGUWy6T0ORe5hV0mc7vhRSanIcV+B9Pp/nzxmse1U5R4pO7Yz6Z0yFBGcwKFdl
kahj9GGf2CZx0ZuWsjkBbSwiTt28d7/XK4Mx0C4jKtKcz+chS9lFcKFVaPMHV1wo
YCGyDUtjdWAsl+K4UQXCsYjUn49tqiL1fyqPSvm/jN3KHYNbE0WZ7An1kdZ4uG9D
7oWfP2LPu6d3sSWcDtIMAtBFAHHp2HZsIW8wVKKSdOj0TOvZ43nfD10QkNU0bpS/
VBRzpRyFs4qMFTFGeQ2dUEOeGYniW0V7WIwsUSC+g63cE4P0XKjgoC/Lc0V2WTHo
NS7tdJdzN361uqahB2hw0PHMTxg/gj2v9DA+xB6NefFvQvUF/8Q=
=nWI+
-----END PGP SIGNATURE-----

--jq54jfr4nh4gip2i--
