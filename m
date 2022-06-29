Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C33C43334
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 17:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiF2Rl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiF2Rl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 13:41:26 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A091FCCB
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:41:25 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id i126so2134268oih.4
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JEWdBAefIi5hdcCShODtH7niHvIoykMo4tEBCoAsNzM=;
        b=WSKZqpUxCT7O+ohPc2bSsVWQ6LaW/d+wdw0l8FDco0lN9Tq+E3v5Yuhmj78HOPdWD+
         iw0Ofui3xLUjWDJGr5Vkvgw/1mv4n4FvjI0wY0KUv7E2K92eURDwzTHhwpYGQIIpLwm2
         Ws7B1Ll+9yBtM6PQvxoL2rxHUvXsX0YtipzsE9K0ZMyKXi9kDhfc92nj6TInnAl/3r0k
         s+Cm+9wbHqk0ANX2zHDT4gYckQFwc6oZG3t6LsQsMbB8a5ytP4bb8rPMZD+EdElUzacM
         zJLK9xw5lNyGabhHyDvNsSXwb4hNw/IChHCIlZMG4LHVrv4CVppkZGlF/5VLU1xgggbe
         Z3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JEWdBAefIi5hdcCShODtH7niHvIoykMo4tEBCoAsNzM=;
        b=i6da4E54D3hQ3T3NvxRH4wjydqiE6dcDvMyKwFjw9IVcrEX6R3Or7fh9vmjDROYKP4
         JljbCLErXAJNmBHFLbVmBSTHghcXYezUNDK0nWKGgToM8SLFgegKO7A49PmaPVCjZst/
         6pL914ejaN7Z+NyKRIYy5SEBH0v1TTsCcplZo0IW5X8szlZnfqWq/nO7otNxI3pWExOS
         1iQmKo+91nV9QuURYVwlRHUcDgkDmkWHhtZgqosAciqhnh9M6LkeXprbY831jZ78Cegd
         NkzlqdqQ0O/fFVrstvokK8p7tvbk/5M82vcbLxI8MAZW1BewlKpBcarxnVa2hT/dMe/A
         YY0g==
X-Gm-Message-State: AJIora+MdEX4yUsHtgiE4CxDu9G7Rry0gbyIkUhH1yX+YogiKdg/3OFZ
        +QhrX0Gzew8wC4WClYzWy2qy
X-Google-Smtp-Source: AGRyM1tq1EK4AMS8s1Ncnr/JHhXN1C1YGs9+IyoWJLfvw+85vNtCjsGZEY7Fj27xi3rvQM20a2PNrg==
X-Received: by 2002:a05:6808:118e:b0:335:1985:cb59 with SMTP id j14-20020a056808118e00b003351985cb59mr4054493oil.230.1656524485205;
        Wed, 29 Jun 2022 10:41:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8945:6633:39ae:9965? ([2600:1700:e72:80a0:8945:6633:39ae:9965])
        by smtp.gmail.com with ESMTPSA id o12-20020a05680803cc00b00325cda1ff8dsm8806915oie.12.2022.06.29.10.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:41:24 -0700 (PDT)
Message-ID: <d6f6f1db-793e-9a0f-7702-bb1ed650c5a5@github.com>
Date:   Wed, 29 Jun 2022 13:41:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/2] [RFC] scalar: prepare documentation for future work
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/29/2022 12:58 PM, Victoria Dye via GitGitGadget wrote:

> Beginning with the "Philosophy of Scalar" [2], much of the existing
> documentation refers to Scalar as "opinionated" - not unlike git itself.
> However, with scalar now part of Git, continuing to describe it as
> "opinionated" could unintentionally portray it as a divergence from "the
> rest of Git" and its development community.

I appreciate this perspective.
 
> Rather than think of Scalar as an opinionated take on Git, I prefer to think
> of it as a manifestation of Git's own "opinions" for a specific use case,

This is a good reframing.

> All that to say, Scalar is essentially a collection of porcelain commands
> [3] that fill a substantial UX niche in Git. Now, let's get into Scalar's
> "future state".

(I was going to comment here about Scalar as proving ground, but...)
  
> A plan for Scalar
> =================
> 
> Given the slightly tweaked "philosophy" above, my ultimate goal for Scalar
> is to have it contain only what is too experimental or too large
> repo-focused to be a default option or behavior in Git. Over time, some
> features may be moved out of Scalar and into Git defaults as they are proven
> stable and beneficial to the vast majority of users [4].

Here you point out that the new goal is for Scalar to be a proving ground
for new features. We can more readily update the recommended Scalar config
than we can update Git defaults.

For example, Scalar's first version included setting up cone-mode sparse-
checkout when that was a brand-new feature. This new default was adopted
in core Git two years later.

> So what do we need to get there?
> 
> At a high level, the remaining work to "finalize" Scalar (past this RFC) can
> be broken into three parts:
> 
>  1. Complete a few more features and subcommands of Scalar (integrate with
>     the built-in FSMonitor & implement scalar help).

The builtin FS Monitor setting is one that has also been part of the Scalar
implementation for a while, but I also doubt that we will make it a default
setting for _all_ Git repositories. Here, we are a good proving ground for
"recommended config for large repos" until we create an alternative under
the 'git' executable.

>  2. Move stable, general-purpose parts of 'scalar.c' into other Git
>     builtins/libraries (mainly scalar diagnose, either as part of git
>     bug-report [5] or a new git built-in).
> 
>  3. Move Scalar out of contrib/ and into the "top-level" of Git. Includes
>     expanded testing, especially performance testing.

This is an interesting order change from the initial plan. I like that
we are minimizing the code footprint of Scalar before doing the move out
of contrib/. But also, this changes the complex nature of it being in
contrib/ but also wanting to change APIs in libgit.a for the sake of
Scalar.

Your step 2 is focused on changing APIs in libgit.a _for the sake of
Git commands_ and in the meantime removing code from contrib/ and calling
those APIs in libgit.a instead. I like the idea.

This does delay the conversion of Scalar out of contrib, which is worth
thinking about.

> What's Scalar's future?
> =======================
> 
> With the completion of the tasks listed in the previous section, there's
> nothing left from the original Scalar CLI (in the Microsoft fork of Git) to
> upstream. I don't consider that the "end" of supporting Scalar because, for
> it to remain an effective tool, it'll need to stay up-to-date with the
> latest performance features introduced to Git.
> 
> For example, one possible future extension might be to have Scalar enable
> the sparse index by default, especially when more built-ins are updated with
> sparse index compatibility. I'm interested in hearing what other features
> might fit well there!

I did a double-take, "We're not doing that already?" Of course, we enabled
the sparse-index by default across all of microsoft/git. We did that when
microsoft/git had early versions of the sparse index integrations that are
now in shipped versions of Git. It might be worth considering updating the
default to enable sparse index automatically for repos using cone-mode
sparse-checkout. (This is an alternative to using Scalar as that vector,
only because the sparse index might be stable enough to recommend it for
all of Git. It's also possible that we don't want to enable the sparse index
by default in Git proper until more integrations are complete.)
 
> What I'm looking for
> ====================
> 
> The two patches in this series revise existing documentation to match the
> description above. Please let me know if 1) those revisions match your
> understanding of the above, 2) they convey the intent clearly, and (most
> importantly) 3) they reflect a reasonable direction to take Scalar. And, of
> course, if there's something I missed, I welcome any and all feedback &
> ideas!

Thanks for the clear cover letter. I'll review the patches with this in
mind.

Thanks,
-Stolee
