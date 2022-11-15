Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2802BC433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 04:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiKOE7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 23:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiKOE7k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 23:59:40 -0500
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ED62666
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 20:59:39 -0800 (PST)
Received: by mail-il1-f173.google.com with SMTP id m15so6859143ilq.2
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 20:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JAdd1vW1zifB1WFVbjnb7jqn0DwfsBoJEKRKuCv5mc=;
        b=FiEHvVzlL8/KAP8fdTTvMnRM0MQINW8kSkP5mFwQXbkUCS0FlQDP+O/uX7a9N/5LqG
         Df6F1szZ77v2H5qLYcxQFRC6N7soPMtPoaIDr3g5gnjehqM/5RXkgtuPd60O8VpXfov3
         +3NFq/ArxoTCst/xYwtVoWFk9rO1ViejLEHcPfIyxgTcXXjr/Kxo2x/Ik98P+yV3w7ce
         T4yHrCSLt06uiqu7a4VVZEjBcCCG9r2KIB3stZgf8BNEpWX8KqMEpDycsPvxyM/m5I52
         44tSeedk6rfzX7jEPGRJ+VSrJ42q2vLbVCzne3Jjh7sQb0o9ES6czrQ4CPnN/CRz8GcF
         1bwQ==
X-Gm-Message-State: ANoB5pmXksqa0jTgrLBiZWyg4iV/pWf167N2TBYApuaTpz1VWWvZRYZX
        MVeYtCBEHbUr0GRZaZ6NRKsmuzZ0NidI6bhqIfBLx2qfFIc=
X-Google-Smtp-Source: AA0mqf4axehKTr1uQHlYuM8nFzN/Yir3P6IkDLcQ1EnTvpAIrcQ5HYRwwL1wl2huVX85hyI1CPt7kquWnUiyfN2LmrQ=
X-Received: by 2002:a92:b752:0:b0:2ff:754a:b114 with SMTP id
 c18-20020a92b752000000b002ff754ab114mr8020619ilm.23.1668488379003; Mon, 14
 Nov 2022 20:59:39 -0800 (PST)
MIME-Version: 1.0
References: <Y3Mag8qG2D3qjlmg@nand.local>
In-Reply-To: <Y3Mag8qG2D3qjlmg@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 14 Nov 2022 23:59:28 -0500
Message-ID: <CAPig+cT-QhG+7phOYsq5WQvg9tLu3zsJrajgL=+53bEZ9ZiBNg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2022, #03; Mon, 14)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 11:53 PM Taylor Blau <me@ttaylorr.com> wrote:
> * es/chainlint-lineno (2022-11-11) 4 commits
>  - chainlint: prefix annotated test definition with line numbers
>  - chainlint: latch line numbers at which each token starts and ends
>  - chainlint: sidestep impoverished macOS "terminfo"
>  - Merge branch 'es/chainlint-output' into es/chainlint-lineno
>  (this branch uses es/chainlint-output.)
>
>  Teach chainlint.pl to annotate the original test definition instead
>  of the token stream.
>
> * es/chainlint-output (2022-11-08) 4 commits
>   (merged to 'next' on 2022-11-14 at 9cd7d30183)
>  + chainlint: annotate original test definition rather than token stream
>  + chainlint: latch start/end position of each token
>  + chainlint: tighten accuracy when consuming input stream
>  + chainlint: add explanatory comments
>  (this branch is used by es/chainlint-lineno.)
>
>  Teach chainlint.pl to annotate the original test definition instead
>  of the token stream.

These two topics have the same description. Perhaps the
es/chainlint-lineno topic should be described as:

    Teach chainlint.pl to decorate output with line numbers.

or something.
