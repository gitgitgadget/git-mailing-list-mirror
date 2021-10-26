Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D040C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276236108D
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 19:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235790AbhJZTPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 15:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbhJZTPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 15:15:13 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593AC061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 12:12:49 -0700 (PDT)
Message-ID: <43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635275567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rey/lfmW4DWFNA6YOk+6MSCWaf90WRLD4u7X3wRVhow=;
        b=V01wn7WBZ3PdoFG6NtpcRW//sl1Xayh+KnQsp5evNYgl6Bjb0ByDzUPVX5T4k7fLAqw7mC
        bgjNsrquXXcChojXDryrmIIGq1s/F8qV32MgfAf2QJiNIdDKUWSQ1Ekkh70nlwYAZzIISx
        8jDUy+Zcu27hSxixgHREcVhMgVdWF6z0Y5ztQQOzdDPNktlqSZLT1UJ64Zsy/bqmFEU04m
        d/rL5lowM/2rI+r6nctkEIf6hrqnvOHirgfgtjwUQtS4qcWhUriG3mdUdDgUVJy80wFCdV
        H9yKUy80QeQ4Tret0BsZv9M7er+CmLGJJ1izRs/esa7qm//ejaBb3UoIaKwBeLk2h+B0PN
        L8dCkd+Dv+NPg/AvbiJzP1yCfFvi+byU7GMPkIssNdTrPo9AJMWABGBz2m2a4EuAT0Q5Tc
        pGestdq6LPOLAd0lgpNrEk/HmR/64cyiJfhzMHJj8MGAxkmvWDFLSCg0W+H32JLtmt5wM4
        i79qVN2WE1pMR8HyvI0A9PjLWpxn0evhqnr4IvZj7hiOjZZVo7WIJnPDJwtmjkguMyGyBv
        P324EwkHUHK1LL4mPp+5g/AxzsM+FULHV0dZLlCVwRNc/neEdz+jopv2iQzD+YOxG8iBud
        bQy9xtZfaWJbJrCYrGVWy+qnbtTEQAIg4hrGnA+DpZDEeBpIStnPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635275567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rey/lfmW4DWFNA6YOk+6MSCWaf90WRLD4u7X3wRVhow=;
        b=KB1ZyIRmGSkLAlFvRY62eJ7Q5ODSxD00VJdTkSHaozVqKsrbsUN8RF49MpNkXz6GkzVk6h
        PkLrXvI+4dVH9SCg==
Date:   Tue, 26 Oct 2021 15:12:43 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
Content-Language: en-US-large
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211026013452.1372122-4-eschwartz@archlinux.org>
 <YXfvY3n9wEwctjUR@danh.dev>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <YXfvY3n9wEwctjUR@danh.dev>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oe8LunB8v7G486huGWGJ2Z7A"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oe8LunB8v7G486huGWGJ2Z7A
Content-Type: multipart/mixed; boundary="------------FNGsy9WDgfrIdLGtWOjTexf3";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
Message-ID: <43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org>
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211026013452.1372122-4-eschwartz@archlinux.org>
 <YXfvY3n9wEwctjUR@danh.dev>
In-Reply-To: <YXfvY3n9wEwctjUR@danh.dev>

--------------FNGsy9WDgfrIdLGtWOjTexf3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/26/21 8:06 AM, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> Other than the question pointed out by Eric,
>=20
> with DEVELOPER=3D1, -Werror=3Ddeclaration-after-statement
> We'll need this change squashed in:


Thanks for the advice. In v1 of this patchset I attempted to do a
developer build but failed due to preexisting errors:


    CC run-command.o
run-command.c: In function =E2=80=98async_die_is_recursing=E2=80=99:
run-command.c:1102:9: error: =E2=80=98pthread_setspecific=E2=80=99 expect=
ing 1 byte in a
region of size 0 [-Werror=3Dstringop-overread]
 1102 |         pthread_setspecific(async_die_counter, (void *)1);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/openssl/crypto.h:415,
                 from /usr/include/openssl/comp.h:16,
                 from /usr/include/openssl/ssl.h:17,
                 from git-compat-util.h:309,
                 from cache.h:4,
                 from run-command.c:1:
/usr/include/pthread.h:1308:12: note: in a call to function
=E2=80=98pthread_setspecific=E2=80=99 declared with attribute =E2=80=98ac=
cess (none, 2)=E2=80=99
 1308 | extern int pthread_setspecific (pthread_key_t __key,
      |            ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors



My system has a custom compiled glibc from git roughly around the 2.34
release (a similar environment could be obtained by using Fedora rawhide
I guess), and this commit looks mighty suspicious:
https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3Da1561c3bbe8e=
72c6e44280d1eb5e529d2da4ecd0

For this reason, I did not bother to try testing v2 under a developer
build, leading to my overlooking this issue. ;)

--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------FNGsy9WDgfrIdLGtWOjTexf3--

--------------oe8LunB8v7G486huGWGJ2Z7A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF4UywACgkQzrFn77Vy
K9Z2ZhAAgpdVHEZkfid49bav/BiQeqOa8bnvpzS1C2zMbIe4X4GPbwhS7jIFKcGn
uuxOO/2q0Site4Ft8h1+L7X0Qc2O0eYydale0yQVXkFqGxzGvVJ9L+mqwffC5wVP
JAIb/tV+Bl5D7QUOQ/zCk19Pi5asIrpJZJvonoElfeKV0rPw8XwjrLA+NaWq/yKu
jF64tFG/byyb43G3mN5ZYOPwiidcfDcojxxk6SQdtLfOmB/3+PMPkG6Rkf+mTXaw
rbzUPv7ousEAyirFugup1ZNxlbJMBBxHhcIgN1AbSbVTK7HpEfVY9goUZRjNlESV
DUP947gNeij9I8j9jPj9qsRJi5neHfLLZcs1iwRqn5zVpBjek3VVUepVVkvQuJX6
P72R63Q9H1Yw1Nf6vGFXmb3ksEAH1TfzzU649jtVVNjLfelKqCh3RI7K035+ym/f
II0WqcI2Tx4BsvPkpXsiJDla4QXiKZNPYWQfSbAfAFp5mkLs4uP02qdpciVWSpA/
d2UwY4gcgnY4fE4TXajuV/coIW2V8nX4cc8/JmW7M0H+Kdxt63R90LHMz9P59C1S
s7WNhkChHN7CAZp4oKGl5FUI/+mD7QnYPxM5/nba2ix688G8vVPlpeeHwAbzRAv3
ctv9p3TjXRYCDmPtNLIZL4mHZLj61/suPArn60dL4BwT5JijtHI=
=IMyB
-----END PGP SIGNATURE-----

--------------oe8LunB8v7G486huGWGJ2Z7A--
