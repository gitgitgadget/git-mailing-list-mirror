Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EEDB1F42D
	for <e@80x24.org>; Mon, 21 May 2018 09:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeEUJlt (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 05:41:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:60729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbeEUJls (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 05:41:48 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5dMm-1gI16h3DJY-00xbts; Mon, 21
 May 2018 11:41:31 +0200
Date:   Mon, 21 May 2018 11:41:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] t: make many tests depend less on the refs being files
In-Reply-To: <20180521055143.14701-1-chriscool@tuxfamily.org>
Message-ID: <nycvar.QRO.7.76.6.1805211126140.77@tvgsbejvaqbjf.bet>
References: <20180521055143.14701-1-chriscool@tuxfamily.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1472349856-1526895695=:77"
X-Provags-ID: V03:K1:SwT1qRseqZgIndQaRnqWu1KN6ZAJv+RmMa0OX4FeaSumRmuiW0M
 X/jvmXV0jO4zkQXZZLGN6SBYO22m1oVi12rA2THZR3+fUng31JjF1arqVqeNUr8vVfjXqVS
 uCK5p6JICJKJVcUk7HuMlXfa9Kxw33FJhU90mYbc74JJM+GNBvKXH9Mwo5j5x1p7FqVPmRD
 5PZLlLBzCYUZXPyCrjhSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:smlZ75rA3so=:8znbket8jDPf4flUXvWx6G
 Si1cxP0++Y5439BdGoo5SfNU4klrlNoQCGf6XokKQG5/mlPGDkiWJKmYuVIJyBL0VlCbniAH7
 C/HYmKJpMHR8r9Lu1FrGveJQyQXLiTyNSTXXRfUjUesBnAZgi8w59rwIKWXyM2Mwf1/ynuKkf
 LV9agMdqAlV3Uz69wT3kLhC7cEGCnp+1fC6RmOjfFQMcUMb36fTsR5iqOmnMpQgv9n4tsBec+
 OAGFM6Yy6AuaiyKIkIaH9iL4gM23JEkASvsi7mQXxLLpd7YLTtZoFGqXtAyPf0J0n8BVA+4ul
 dreJsg5dMLcz2Yc0LNSNI7rTbPX8Ng/U/cPygzdeM3Q9E+yq1oh7wJTP6RT73kw649qThH8PK
 nY0NgLG4LOCqYRvAE9FvJanvzqIFeFVwEKxhevtie8yfQKoaejdqnk12oVGL0oJX7u3SN/9D/
 ARwIYmVV3CSTcamKSMB+aS1Qs+AXaONm7dVy0c/qbzWY7pa5O3V3j5Y3LrbzdwFIDTgdz0d7p
 Kx5L21Kvec2ziAsLNQtegPyYui5MkuPGedpbrjpJ9eQJUvdSWm4cjS8y23Bl6hdx52ivs6HMs
 e6YdnOHwv1Ykeyq1AjRThr37RMNNE3teXWPebjB1L7Fk4WoEINoUU+AytqIeC9mb3sj2sdV1X
 ZtS/YUCtuKx1C5egNHO+g2UvvnEVThduoJQaDvGA2W6RqJrNGo5uVhwQ0iAJ/5IGvjg6cwP2/
 dLhovu3gU+hLXLJg2vt7afQWVXt1K0cs6yadWsdTRK8MEYG3rnqF3j6ySuXSx3D94oSGFIF2n
 4SxNimS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1472349856-1526895695=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Chris,

On Mon, 21 May 2018, Christian Couder wrote:

> From: David Turner <dturner@twopensource.com>

I vaguely remember that Dave suggested using a different email address
these days...

*clicketyclick*

ah, yes:
https://public-inbox.org/git/1474935093-26757-3-git-send-email-dturner@twos=
igma.com/

So maybe update it here, too, to=20

=09From: David Turner <novalis@novalis.org>

?

> So that they work under alternate ref storage backends.
>=20
> This will be really needed when such alternate ref storage backends are
> developed. But this could already help by making clear to readers that
> some tests do not depend on which ref backend is used.
>=20
> This patch just takes care of many low hanging fruits. It does not try
> to completely solves the issue.
>=20
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

This is great. I am all for making the tests better ;-)

> diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
> index 3f2d873fec..b8567cdf94 100644
> --- a/t/lib-t6000.sh
> +++ b/t/lib-t6000.sh
> @@ -4,11 +4,10 @@ mkdir -p .git/refs/tags
> =20
>  >sed.script
> =20
> -# Answer the sha1 has associated with the tag. The tag must exist in .gi=
t/refs/tags
> +# Answer the sha1 has associated with the tag. The tag must exist under =
refs/tags
>  tag () {
>  =09_tag=3D$1
> -=09test -f ".git/refs/tags/$_tag" || error "tag: \"$_tag\" does not exis=
t"
> -=09cat ".git/refs/tags/$_tag"
> +=09git rev-parse --verify "refs/tags/$_tag" || error "tag: \"$_tag\" doe=
s not exist"

Line longer than 80 columns...

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 0680dec808..886a9e3b72 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -30,7 +30,7 @@ add () {
>  =09test_tick &&
>  =09commit=3D$(echo "$text" | git commit-tree $tree $parents) &&
>  =09eval "$name=3D$commit; export $name" &&
> -=09echo $commit > .git/refs/heads/$branch &&
> +=09git update-ref refs/heads/$branch $commit &&

I think we have to be careful here to quote both "refs/heads/$branch" and
"$commit" here, as a bug that introduces spaces into $commit or $branch
would have been caught earlier, but not now, unless we quote.

This goes for all introduced `update-ref` calls.

Maybe even for some `git rev-parse --verify` calls.

> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> index 8f5c811dd7..c3b89ae783 100755
> --- a/t/t9903-bash-prompt.sh
> +++ b/t/t9903-bash-prompt.sh
> @@ -148,7 +148,7 @@ test_expect_success 'prompt - inside .git directory' =
'
>  test_expect_success 'prompt - deep inside .git directory' '
>  =09printf " (GIT_DIR!)" >expected &&
>  =09(
> -=09=09cd .git/refs/heads &&
> +=09=09cd .git/objects &&
>  =09=09__git_ps1 >"$actual"
>  =09) &&
>  =09test_cmp expected "$actual"
> --=20

This one looks wrong.

Upon cursory review, one might be tempted to assume that the file is now
written into .git/objects/ instead of .git/refs/heads/. And the patch
context provided in the email is not enough to see (gawd, I hate
mail-based patch review, it really takes all my Git tools away from me).
The trick is that `actual` points at an absolute path:

=09#!/bin/sh
=09#
=09# Copyright (c) 2012 SZEDER G=C3=A1bor
=09#

=09test_description=3D'test git-specific bash prompt functions'

=09. ./lib-bash.sh

=09. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"

=09actual=3D"$TRASH_DIRECTORY/actual"
=09[...]

So the remaining question (which probably wants to be added to the commit
message together with a hint that `actual` points at an absolute path) is:
Why not `cd .git` instead?

Ciao,
Dscho
--8323328-1472349856-1526895695=:77--
