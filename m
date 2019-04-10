Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C86420248
	for <e@80x24.org>; Wed, 10 Apr 2019 20:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDJU47 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 16:56:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:33953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbfDJU46 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 16:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554929812;
        bh=Ph70TrBXxJRTeGNqN6zWg3jsIj8Krgier0g4j6ljwF8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Dr6yh4pLfcJN+JhcBDMWjdmZemBDby5NvANNcbV01NC1CNwkR1wsxnosF1MYg7UiN
         FroHtnzVqjIiklJgwC4RN+fJg0cZnN7FqyIHFBGIEznk/JPGNKivlpoCu6PVOtzqqE
         F4vrM7PmxXdOAlTy+6PyZFKAIOJKt42DXMzq37Ho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbuIK-1gVP9M2rSO-00jKg2; Wed, 10
 Apr 2019 22:56:52 +0200
Date:   Wed, 10 Apr 2019 22:56:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/33] nd/sha1-name-c-wo-the-repository updates
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904102254500.41@tvgsbejvaqbjf.bet>
References: <20190403113457.20399-1-pclouds@gmail.com> <20190406113453.5149-1-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-965227943-1554929813=:41"
X-Provags-ID: V03:K1:AcZoYO79PvciXSGx1NoKQMw1rT88I+yKPq11ti77XYjv0EERdSg
 YFfRe7OhxDdAsM195EcKzXPLOShDUP1xfKjPGgOwxm2kKOT01OSRotp6gAwS0LGu4GJ8A0K
 unVWY/hBxi3EFjfxwOplhDApLVbsSH3e4LxnafL5QM9ZZ83kZWOq8FUQqoZ2AeoRSrNFbca
 xXdbn4wlx9g1NQkfZ4kKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9osyi9aYUbQ=:xzAfhTVIdoI/3fGiPcWaLq
 7/OV1AIpkh7sRrnimATIik1E4/ofrks2qbK9KCBmQnP18HvCBKuOYoGr0tRzpD1ME7us43tZ/
 AMG+tgG8PjM0u+5hjlW101zrU+owFMCVnbUxS6eOiYHjXg6tDvF7DiqrAibbbmvNYv9xvTuVc
 VvQv8x3gvlcTBF3HfGfzcWacnz/+mJkLyzNzwm19hSVmcRPjXsKPbtsX+0WO0W+ywFIeSOe+9
 IyjQYjH2VwEezgMMtMPYzZc2MYhNSYMlj+X4KmcUHlkxJirohDkChaI5OztpRuLM8jg12wvQJ
 CArYcWkaNPBHTTZdD6o8kBkc/lYqq3AeeAUBSV1LFjYiuVOqb6lnJ1EV8+9Km5AV21DB1RF6U
 rg4db6l1oL79YaMSAf4npVl7YMhpUOfwADAPXWSMyE3Kc6y2zEKY0bo5VgQYEU8RtJQ9WlE1p
 2qtKlN9ooAJNjBDhhyEBMvS/MtWXB6J6Rp+nGG3Vlj0AvlfkodKzMPqODJFvkkrVHDl81o5yp
 sOGoBUhmYn3yMnrnHURBNopEEKu8RjQsRSzRai8j9kD2ilN4ALyg9HL5RvdCfQn7W16HgRuIv
 HLB7bptnjBro8JW4JkCQPofjZC42aPJm8M81BEc2zQArR+6rg43c97xKxT8fCDHM/fkbonmrv
 s8yh3VvKSoetSy09ISRDGCXIbhBEWzPx6ZtFjzxvs0kvJxEO2Egtiy9oCV92Vueb0dyVU66ye
 kFlrg3OaPAGGC1o9v5wRLjlH0bJNzo67dOOk9JsC3/V9CMxRLHUTRLCZaNT4keYyY0WRhK0lT
 8fprke7ouOB5dNGR/7m/u3DH0fLpc/gb9rRyLIyb2ZWXCz51q+QrluRbZLNv6lHIl1dnDnxGD
 SP+RmDPC0tLIuI2YszJ58qdao95n/lavsEqnVSaDUicF0u2H+KV2jTTFKFqFhRmnHNkb4zcKX
 aI9qeWxKO8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-965227943-1554929813=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Duy,

On Sat, 6 Apr 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> 10:  68876a150f ! 11:  848456f59c commit.c: add repo_get_commit_tree()
>     @@ -2,6 +2,11 @@
>
>          commit.c: add repo_get_commit_tree()
>
>     +    Remove the implicit dependency on the_repository in this functi=
on.
>     +    It will be used in sha1-name.c functions when they are updated =
to take
>     +    any 'struct repository'. get_commit_tree() remains as a compat =
wrapper,
>     +    to be slowly replaced later.
>     +
>       diff --git a/commit.c b/commit.c
>       --- a/commit.c
>       +++ b/commit.c
>     @@ -29,6 +34,15 @@
>       --- a/commit.h
>       +++ b/commit.h
>      @@
>     +
>     + 	/*
>     + 	 * If the commit is loaded from the commit-graph file, then this
>     +-	 * member may be NULL. Only access it through get_commit_tree()
>     ++	 * member may be NULL. Only access it through repo_get_commit_tre=
e()
>     + 	 * or get_commit_tree_oid().
>     + 	 */
>     + 	struct tree *maybe_tree;
>     +@@
>        */
>       void free_commit_buffer(struct parsed_object_pool *pool, struct co=
mmit *);
>
>     @@ -57,3 +71,10 @@
>         ...>}
>
>       @@
>     + expression c;
>     ++expression r;
>     + expression s;
>     + @@
>     +-- get_commit_tree(c) =3D s
>     ++- repo_get_commit_tree(r, c) =3D s
>     + + c->maybe_tree =3D s

I think this is wrong, and admittedly I had the very same version
originally.

When you have an arbitrary `r` in any `repo_get_commit_tree(r, c)` (as
opposed to `the_repository`), the conversion to `c->maybe_tree` is most
likely incorrect.

Therefore, I don't think that we can do that.

Ciao,
Johannes

--8323328-965227943-1554929813=:41--
