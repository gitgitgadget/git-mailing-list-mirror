Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A7851FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 19:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932228AbeAHTIp (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 14:08:45 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:43774 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932181AbeAHTIo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 14:08:44 -0500
Received: by mail-qt0-f171.google.com with SMTP id w10so14909361qtb.10
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 11:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dtSnTOeNxkvUQNpTNXE4axN8A78IW+1aNVNSEfCK+4A=;
        b=BlQJCVEzuaVJFTSePkWIokW0hgZsGsqu5nRNJswGHOj+ehS2UL3g/4VdFlVnbwAddf
         agwKsNCSpF5a71iZ7wRk8Ajeo6VcUAHGYL78D+L7KAGiExMjT6C3kD8KIGe4bN/oGLno
         udUe0ByQh/JfZu3EsQahsAh3Pzilo3Eeu+WbT5rNyGnpzwiTYZ/shrbpie1DOeF5bGTX
         8PJdzHOiJ6DpUQLJnAYi7idO1uxxjt6fIIjTaV+8mYUptwqWom+BCHmF05gZ5mT3rQbu
         NNUWYrkLWDz+45p3jl3prK6I+HwZxK9E8h/jlsvQwRORsj3Z25Yy/8P8QEdxzE2o84cc
         m1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dtSnTOeNxkvUQNpTNXE4axN8A78IW+1aNVNSEfCK+4A=;
        b=SGH57Z0+bD0KC32vRvGtpRJkU+M//NCrFkL4eDAOIb3j/Ys5LRafrjmtB3UX26fVt7
         ogQxtT4X9aZWHXqUz/IsffVGJGbQRq9WIh/uT4sbWuBQ5ONN/WbByyhoQT3GVsSaf6o+
         EVoPjwtiQRFvkWzvIc23ZmUjrooGnqdK6qsmEFaEyM6/wgBPgetezRDup9qexAswNs+J
         2s+g8aKllToU1zKyI9FFM1fwew/P2ezycAw6W5qFXh9PH/C7ecGvxZWlska2CQEULn9m
         NDlySM9ZgpGK59x4DuxUAdzM9FyfdUfcHVOvj7PPUP2FJviCR28jAEymZuscmY9m8SLJ
         JIuQ==
X-Gm-Message-State: AKwxyte7IHxH+ub2nCPdCJ/6tHjXsXH6TtSPxmPA7R930E65SKkHHH1z
        jRLn4lG75kxmbmHNtNe0LsMz3mgQUk1hmw6IMSWs1w==
X-Google-Smtp-Source: ACJfBotXhAmigu7MmwA4tFAc5L1UezczUeC2SpEKJjP3/RKMRctpFyGT5cPKeDGv/7F5sD6Xwd1T3DPd8tGZfVpJLN4=
X-Received: by 10.200.26.37 with SMTP id v34mr17725399qtj.207.1515438523029;
 Mon, 08 Jan 2018 11:08:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 8 Jan 2018 11:08:42 -0800 (PST)
In-Reply-To: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Jan 2018 11:08:42 -0800
Message-ID: <CAGZ79kZ-UNCyCzmg=5PQ_p5xbmCp7HUc0=TXNBxwTjZDCnJtBg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Doc/submodules: a few updates
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Brandon Williams <bmwill@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 6, 2018 at 10:46 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> These are just a few improvements that I thought would make the documenta=
tion
> related to submodules a little better in various way such as readability,
> consistency etc., These were things I noticed while reading thise documen=
ts.
>
> Sorry, for the highly granular patches. I did the commits as and when I w=
as
> reading them and tried to keep them focused to one particular change by r=
ebasing
> them as needed. In case they need some change, let me know.

While small patches are really appreciated for code (bisect, automated
testing, and
the general difficulty to reason about code, as a very small change
may affect the whole
code base), I am not sure if they benefit in documentation.
Documentation is a rather
local human readable thing, so by changing one sentence we don't
affect the understanding
of documentation at a completely unrelated place.

Also it helps to read more than just sentence fragments, i.e. I tried
looking at the
whole paragraph for review. May I suggest to squash them all and
resend as one patch?


>
> I based these patches on top of 'master'.

I am not aware of other submodule patches affecting documentation in master=
..pu,
so this should be easy to merge.

>
> Apart from the changes, I saw a few things that needed improvement/clarif=
ication
> but wasn't able to do that myself due to my limited knowledge of submodul=
es. They
> are listed below. I'll add in patches for them if they are correctly clar=
ified.
>
>
> 1.
>
>  man gitsubmodules
>
>        =C2=B7   The configuration file $GIT_DIR/config in the superprojec=
t. Typical configuration at this place is controlling if a submodule is
>            recursed into at all via the active flag for example.
>
>            If the submodule is not yet initialized, then the configuratio=
n inside the submodule does not exist yet, so configuration where to
>            obtain the submodule from is configured here for example.
>
> What's the "active flag" mentioned above? Also I find the phrase "is recu=
rsed into at all"
> to be a little slippery. How could it be improved?

There are multiple ways to indicate if a submodule is "active", i.e. if Git=
 is
supposed to pay attention. Historically we had to set the
submodule.<name>.url flag in the config, but last year Brandon added
submodule.active as well as submodule.<name>.active which supersede
the .url flag.

(See is_submodule_active() in submodule.c to see the definitive answer to
"should Git pay attention?")
https://github.com/git/git/blob/master/submodule.c#L224

I wonder if this indicates a lack of documentation when the active
flags were introduced.
They are found in 'man git config', but maybe we need to spell them
out explicitly
in the submodule related docs.

> 2.
>
>  man git submodule
>
>        update
>            ...
>
>            checkout
>                ....
>
>                If --force is specified, the submodule will be checked out=
 (using git checkout --force if appropriate), even if the commit
>                specified in the index of the containing repository alread=
y matches the commit checked out in the submodule.
>
> I'm not sure this is conveying all the information it should be conveying=
.
> It seems to making the user wonder, "How at all does 'git submodule updat=
e --force'
> differs from 'git submodule update'?" also "using git checkout --force if=
 appropriate"
> seems to be invoking all sorts confusion as "appropriate" is superfluous.

When "submodule update" is invoked with the `--force` flag, that flag is pa=
ssed
on to the 'checkout' operation. If you do not give the --force, then
the checkout
will also be done without --force.

>
> How could these confusions be clarified?

I tried giving an alternative snippet above, not sure how else to tell.
