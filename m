Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E9C1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbeGWWGv (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:06:51 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:47096 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388076AbeGWWGv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:06:51 -0400
Received: by mail-yw0-f193.google.com with SMTP id e23-v6so747638ywe.13
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=onG2xOZjjGyWeYxDp5rexlVpTRbGWIeTmX0Vwp6KLGM=;
        b=jcODOpkZhBscTOAHbxst4MjEUxh7Vdl0hah6nKnP17KF08OMtsGUp+3DJoO2KIMFF6
         qL1FE5zUDAdi04ScExgXTEm+3aBiUq7lRHxa8y0ZVU/ZSB8MyqUH7JdfGxKy4FA2F13r
         ERxu9PaXiPBL0UgNAU9M21InNkPm5Lti28PbDH03FHtCOVndV39+XvVsrNBcCygJKUDj
         NxQWVcwME31m57HPzRgstKFnctiLkH7vJwxxIZzPEBtDfeZNEE7iHFfX8H0pOwnsuRV6
         P/c+iXd0Ixgsr42LivhW51m13qX4kmasHixGANof5PWlAFiWLVWVLaPlumRM1pFfnXUW
         YOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=onG2xOZjjGyWeYxDp5rexlVpTRbGWIeTmX0Vwp6KLGM=;
        b=QUKjGRrLQD3qlEeIh5avS63a6pn81dijcFAd72iZ069vkpLiVtnhzQAhwbv2+0epR0
         A0eHEPeR+fGrAh0DmyGFKnOlkPsLsD70pXr0qMiQDK8nZ0b41PQPwcCs3hlzKGOZcLus
         ZYlxUH8pSKB5r5cPFrEXSTrfH8BCHBb/O9pANW/6+O0rX3zUOSNH/VtTMFYiHADuakd+
         EK7jKlqc48eCEZV3fA7SxRn8FOQ9pWSk5M/63HivUmfd0Fi43lcL7AUFIhcMZe9sYA3r
         i27eCgea/xcHt0r3l+i6Ntr8YKk+ItoeLLfeNbeh6nOYTNgLpzimKJiMlkZUMzGN1AD+
         4pEQ==
X-Gm-Message-State: AOUpUlGPXdRWgSZ22L4mssv/6ZZxd6OjxsosCiAlei0TppaAexCru3QH
        TTiBc17v4DaMYK4tXgWcCZB6jm1b6IXGKD651XrZhQ==
X-Google-Smtp-Source: AAOMgpdhZeo4qGA3l/OvsGTAwjIxqUwnzClyfsEVZViAQq3MDTJGKK8YqIre6d3JSa63+e89Ep9ZYy6py22IVMNdqZo=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr7923069ywd.421.1532379829130;
 Mon, 23 Jul 2018 14:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Jul 2018 14:03:38 -0700
Message-ID: <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 21, 2018 at 3:04 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> Side note: I work on implementing range-diff not only to make life easier=
 for reviewers who have to suffer through v2, v3, ... of my patch series, b=
ut also to verify my changes before submitting a new iteration. And also, m=
aybe even more importantly, I plan to use it to verify my merging-rebases o=
f Git for
> Windows (for which I previously used to redirect the pre-rebase/post-reba=
se diffs vs upstream and then compare them using `git diff --no-index`). An=
d of course any interested person can see what changes were necessary e.g. =
in the merging-rebase of Git for Windows onto v2.17.0 by running a command =
like:

Thanks for making tools that makes the life of a Git developer easier!
(Just filed https://github.com/gitgitgadget/gitgitgadget/issues/26
which asks to break lines for this cover letter)

> base-commit: b7bd9486b055c3f967a870311e704e3bb0654e4f
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-1%2Fds=
cho%2Fbranch-diff-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1/dscho/br=
anch-diff-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1

I just realized that if I had ideal memory of the previous review,
I could contain my whole review answer to this email only.

>
> Range-diff vs v3:
>
>   1:  39272eefc !  1:  f7e70689e linear-assignment: a function to solve l=
east-cost assignment problems
>      @@ -223,9 +223,7 @@
>       +                         BUG("negative j: %d", j);
>       +                 i =3D pred[j];
>       +                 column2row[j] =3D i;
>      -+                 k =3D j;
>      -+                 j =3D row2column[i];
>      -+                 row2column[i] =3D k;
>      ++                 SWAP(j, row2column[i]);

The dual color option (as a default) really helps here. Thanks for that!
Does it have to be renamed though? (It's more than two colors; originally
it was inverting the beginning signs)

Maybe --color=3Demphasize-later
assuming there will be other modes for coloring, such as "diff-only",
which would correspond with --no-dual-color, or "none" that will correspond
would be --no-color. I imagine there could be more fancy things, hence I wo=
uld
propose a mode rather than a switch.
(Feel free to push back if discussing naming here feels like bike shedding)


2:  7f15b26d4ea !  82:  88134121d2a Introduce `range-diff` to compare
iterations of a topic branch
[...]
>       diff --git a/Makefile b/Makefile
>       --- a/Makefile
>       +++ b/Makefile

The line starting with --- is red (default removed color) and the line
with +++ is green (default add color).

Ideally these two lines and the third line above starting with "diff --git"
would render in GIT_COLOR_BOLD ("METAINFO").

>   3:  076e1192d !  3:  4e3fb47a1 range-diff: first rudimentary implementa=
tion
>      @@ -4,7 +4,7 @@
>
>           At this stage, `git range-diff` can determine corresponding com=
mits
>           of two related commit ranges. This makes use of the recently in=
troduced
>      -    implementation of the Hungarian algorithm.
>      +    implementation of the linear assignment algorithm.
>
>           The core of this patch is a straight port of the ideas of tbdif=
f, the
>           apparently dormant project at https://github.com/trast/tbdiff.
>      @@ -51,19 +51,17 @@
>       + int res =3D 0;
>       + struct strbuf range1 =3D STRBUF_INIT, range2 =3D STRBUF_INIT;
>
>      -- argc =3D parse_options(argc, argv, NULL, options,
>      --                      builtin_range_diff_usage, 0);
>      -+ argc =3D parse_options(argc, argv, NULL, options, builtin_range_d=
iff_usage,
>      -+                      0);
>      +  argc =3D parse_options(argc, argv, NULL, options,
>      +                       builtin_range_diff_usage, 0);

This is really nice in colors when viewed locally.

>  16:  dfa7b1e71 <  -:  --------- range-diff --dual-color: work around bog=
us white-space warning
>   -:  --------- > 16:  f4252f2b2 range-diff --dual-color: fix bogus white=
-space warning

Ah; here my initial assumption of only reviewing the range-diff breaks down=
 now.
I'll dig into patch 16 separately.

Maybe it is worth having an option to expand all "new" patches.
(Given that the range-diff pr-1/dscho/branch-diff-v3...pr-1/dscho/branch-di=
ff-v4
told me you used a different base, this is a hard problem, as I certainly
would want to skip over all new base commits, but this one is interesting
to look at. An easy way out: Maybe an option to expand any new
commits/patches after the first expansion? Asking for opinions rather
than implementing it)

>  19:  144363006 <  -:  --------- range-diff: left-pad patch numbers
>   -:  --------- > 19:  07ec215e8 range-diff: left-pad patch numbers

>   -:  --------- > 21:  d8498fb32 range-diff: use dim/bold cues to improve=
 dual color mode

Those are interesting, I'll look at them separately, too.

Thanks,
Stefan
