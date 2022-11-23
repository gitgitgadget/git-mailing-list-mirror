Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E97C4708A
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 15:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiKWPxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237269AbiKWPxI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 10:53:08 -0500
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181EB79E10
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:53:00 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id s196so17121876pgs.3
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUcNkWX/YWRKB3zrODXCcwP5Ma5nFVOMWsZ+FV1bc9E=;
        b=LZHxTBlQWhSUD4DIOOXFqRp5Ft+uxI0Jdh4Y+/3XvO1tnAsSZLghMhLDOVGVQ+x8H8
         DqPwrNm/7b+tkRDWhNiwn6Oyw4rwI4oo9o3XB5IQfMvOz5CkK5vZU7gx2PiVFHF8VVdv
         EgDYvLpjhb6IPtRIRNfosVpCJ9GnGFZtaeyVz7g6okxrfNjT7VFsmQpFAMTyo1zgCFRE
         skckFZ6YfU8hgNLqcf96jRSxvWTdRsRu/zeBC7XkeMclIxJHj9XESITSuUv67NDi/kYv
         jWyeMv2A+5D1HavZEuF05+kXbG9GkpSk4sYr+iT8v6IRHDMj+ULtv8xCLIxTxy0ObpkO
         Wzhg==
X-Gm-Message-State: ANoB5plpjGoB+YQgDrnBdU0wS7FWh+oqs3is4ZKuGu9/2O0481zlOWlo
        He5e8UWuIvC1YL808YcN3HfljMES9vlkQVs+dXw=
X-Google-Smtp-Source: AA0mqf5zdaPd9Nqqwwmfp1F6erdy+eU85T0qTX7TwMppoA5oGJfu4h1xZor10lg2m5NeIy/RSqaWzytzXHPqujCB2S0=
X-Received: by 2002:a05:6a00:b84:b0:563:4643:db33 with SMTP id
 g4-20020a056a000b8400b005634643db33mr9345305pfj.22.1669218779161; Wed, 23 Nov
 2022 07:52:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1385.git.git.1669148861635.gitgitgadget@gmail.com>
 <CAPig+cQ6_7wf6C280Rqi7mcTCiQp-n5GiLWTPazfcUcGFeZi0g@mail.gmail.com>
 <xmqqsfiao47q.fsf@gitster.g> <CANYNYEETCaaQGOXVLrRCC8wdS-uD66BHqr98Eetb+1GVk5WkTg@mail.gmail.com>
In-Reply-To: <CANYNYEETCaaQGOXVLrRCC8wdS-uD66BHqr98Eetb+1GVk5WkTg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 23 Nov 2022 10:52:48 -0500
Message-ID: <CAPig+cSVjnrHEZxosbS1Au7LRbDRZt_r9dr78S37FPXdb3W2QA@mail.gmail.com>
Subject: Re: [PATCH] chainlint.pl: fix /proc/cpuinfo regexp
To:     Andreas Hasenack <andreas@canonical.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Hasenack via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 7:17 AM Andreas Hasenack <andreas@canonical.com> wrote:
> Should I still change the commit message regarding where I mention the
> commit that introduced this, as explained by Eric? From the activity I
> saw overnight it looks like things were already picked up and it
> doesn't matter anymore.

No need to resend. Junio tweaked the commit message[1] when he picked
up the patch.

[1]: https://github.com/git/git/commit/1f51b77f4f3f4d05f249f80713b2969e4069c109
