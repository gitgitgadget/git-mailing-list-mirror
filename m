Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC181C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D60DE619E1
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbhKPM33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:29:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:41869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236140AbhKPM31 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637065588;
        bh=zACJR18VGnq6/CqOfZT6NmkJeQTBgPSl4+A4c2UtV0Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=e0XLLQDH8y765jPOWkUU+OIsU3MwrTp7PVLj95kYypUytFHOs5W82PGeRvzbuDFVr
         EDa4Pu8rUlIy+RpJ0brw/uirh1Kmmh1ZpOVGkjH4U4sQ6NWKuJ4aOc/xC/UYvNxSDm
         G6kdcJpwHFwUAew/yc8XUMRPvmz1KdkVOLLvmaOk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.213.220]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sn1-1mc9ud1NNP-018GTY; Tue, 16
 Nov 2021 13:26:28 +0100
Date:   Tue, 16 Nov 2021 13:26:26 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     hakre via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, hakre <hanskrentel@yahoo.de>,
        hakre <hanskrentel@yahoo.de>
Subject: Re: [PATCH] ci(check-whitespace): update stale file top comments
In-Reply-To: <pull.1138.git.git.1636822837587.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111161321380.21127@tvgsbejvaqbjf.bet>
References: <pull.1138.git.git.1636822837587.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2120474085-1637065588=:21127"
X-Provags-ID: V03:K1:2iAl02gQFPyyOu2VpdHXm1OUqPW08rix1BKzcwghJTZsxr5Z5XJ
 TX7LFdVDfhI0RUpZa95VHWii4REyrL17er3L25As+KmUCAXdqU1+l0+NP/Cj2SuKNpK+HTw
 7t51bTg2xQEz8hwomSHfGxi8gTM3tWCa/R4Nf+jNYfdPz8ezOW+yGY67cYh/vjSoEJcu683
 1dgP1D8HbWmBnQNWuS2cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vPEmKPC4cvQ=:DCrMkQdrRq2Hs7I7Vu6O9Q
 8PfuUXa3ZDBMtKEKoiDQSIpwnydEgBDhgMJRKc+tc0s1CucvRh1MKY1u5Q/ggtwebWYy/4iAj
 9RSZv8kev1DCs/ItQD01+E0FISWFKAe761BU8FLIuts6hC2G3VQYkPtdqrtemZW1ylAekQ6nY
 hWXmzfatb8zkR2whCXfppNzrvhRpCxUgc7JetQIjLVAxkz/h+K6yujboaAe20dCxVVOSs94Vw
 RkoIzXM1/0oRL6Bsxkpu3pFopma/2yShiTIpHWGDtxn65QToaPNID8xRt4B2TpzHLrFSOYQ2m
 a6LMT8Xj7+Cx4oVCQgR5DO7F3OrGuLkGCj/CGfFIp+rVzLLO7ams5h1brB4BWJIh/9eRgPIrf
 r3ZT2gEP85zMMSbv42OY9Z/QeIaumInyGyzfp9WPw/2SSacSdNTMEkLvY990X/E/weE3dNNEW
 yOfZ81qGLxymFc7bqenH/eeGcTEjyaxMKHncRWdx9a8C+uxjrNQT8OWeG7ao14zFIQ47vo0CU
 7bFpW6Cx5Y/oQ/3FzvZwnIQTpN566thf05vQTIzB5/2mZTKWfJtHcdLXwrHTZfCH9fN6xP1V8
 A5adCwPGgnmJjtBKmZcI3SzOL3TZajWR0tK3Ls13sRFrp3aDsQYEcmnkgDkhS5I+Z+I6cXWnD
 htdtxIE9ri/qGQVEXDAuqWnk1CNpXfPR2KIxVwGn5tCP7KX6bb/GOCxhiKk0lX15qH7iG/O9t
 0ng7YX1T1wCtRaOiL4dN9ojXXrIaReT6++NRBw6/eAw+vNoVkc+4TNi/uQNYfYH1cUGAclwpP
 nTNEH2uiAg8C1M9jHkiEvonLO4srj6HFSQqsiDGt/oZ5EIloGc43G33UlD3pStYhdKP8fj1UE
 tCiNXpHxMSfbFIsRRqd2rsijF//eiGz07m5UdOtLw/bnEWO+lQ3DVpZf5z9hneUb+qk6bru+C
 dF9OBcxZRVvNnqD54MUbErmIDVZyzIWJptbkDSNVuUrnki1ZVJ2k1FZqgPz9tNWEp0Uo3OvQW
 aeU+ZiWnRtOhKg3tJpHzMJLka9LnSy+o7pDEzq/1v9OHq44v8S5c9YGIKjnBNtCK/QiMecHUT
 0xqcfnQDGvpaCI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2120474085-1637065588=:21127
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, 13 Nov 2021, hakre via GitGitGadget wrote:

> From: hakre <hanskrentel@yahoo.de>

As per https://git-scm.com/docs/SubmittingPatches#sign-off:

	Please don=E2=80=99t hide your real name.

I strongly suspect your real name to be Hans Krentel, not hakre.

> Part of these two recent commits
>
> 1. a066a90db6 (ci(check-whitespace): restrict to the intended commits,
>    2021-07-15)
> 2. cc00362125 (ci(check-whitespace): stop requiring a read/write token,
>    2021-07-15)
>
> are well written messages that reflect the changes (compare: [1]).
>
> Unfortunately those commits left the description in top file comments
> unchanged which are still showing the previous picture.
>
> To better display the current workflow upfront, those comments now
> reflect that:
>
> 1. full (not shallow) clone to steadily check the intended commits
> 2. communicated result is the exit status (not a comment in the PR)
>
> [1]: https://git-scm.com/docs/SubmittingPatches#describe-changes
> CC: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: hakre <hanskrentel@yahoo.de>
> ---
>     ci(check-whitespace): update stale file top comments
>
>     Part of these two recent commits
>
>      1. a066a90db6 (ci(check-whitespace): restrict to the intended commi=
ts,
>         2021-07-15)
>      2. cc00362125 (ci(check-whitespace): stop requiring a read/write to=
ken,
>         2021-07-15)
>
>     are well written messages that reflect the changes (compare: 1
>     [https://git-scm.com/docs/SubmittingPatches#describe-changes]).
>
>     Unfortunately those commits left the description in top file comment=
s
>     unchanged which are still showing the previous picture.
>
>     To better display the current workflow upfront, those comments now
>     reflect that:
>
>      1. full (not shallow) clone to steadily check the intended commits
>      2. communicated result is the exit status (not a comment in the PR)
>
>     Signed-off-by: hakre hanskrentel@yahoo.de

If you send a new iteration, please replace the first comment on your PR
by a cover letter. You can also delete the comment's contents instead.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-11=
38%2Fhakre%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1138/=
hakre/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/1138
>
>  .github/workflows/check-whitespace.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/=
check-whitespace.yml
> index 8c4358d805c..2dce03bc479 100644
> --- a/.github/workflows/check-whitespace.yml
> +++ b/.github/workflows/check-whitespace.yml
> @@ -1,8 +1,8 @@
>  name: check-whitespace
>
> -# Get the repo with the commits(+1) in the series.
> +# Get the repo with all commits to steady catch the series.

I am not a native English speaker, but "to steady catch" strikes me as not
quite English. I would suggest something like this instead:

	Get the repository with all commits to ensure that we can analyze
	all of the commits contributed via the Pull Request.

>  # Process `git log --check` output to extract just the check errors.
> -# Add a comment to the pull request with the check errors.
> +# Give status 2 on check errors.

Is it really interesting that the exit code 2 is used? Or is it more
interesting that the job will exit with failure if the check produces
errors? I think it would sound better as:

	Exit with failure upon white-space issues.

Ciao,
Johannes

>
>  on:
>    pull_request:
>
> base-commit: 5fbd2fc5997dfa4d4593a862fe729b1e7a89bcf8
> --
> gitgitgadget
>

--8323328-2120474085-1637065588=:21127--
