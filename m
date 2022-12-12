Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44ACC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 20:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiLLUzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 15:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiLLUzB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 15:55:01 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B055A8
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:55:00 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso1267076pjt.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAYAFBETj2dAcMtSwHUzaRUDgH++TYSZnGAQ6IKCrGI=;
        b=3pa0DF0RM9Oa+1k9z+CEb6OPfr1QTZJHYcxi7gpMUAs7tj2OOZEnhU1EuBpzqfl+2Z
         +tWlzloc+rWLuY8JnrQ5oKe8/XRImHXOCRjI33p2KgdEiwj4w83epWvlOnFen2WxFBq2
         HNrKznrsey+hPklF+0qC7h9Gl769uLSZqZayLvokLh0FLFDjgXhulC6F0qBSZ4TfqFMJ
         zTknMybRbMWmAzNwS+v06QoJ07eO4LVPmfENSEPtQT9okLWqtNfdavrYOqlvuKdO4Jl0
         RtBuF/oWyr4XfL7TCDxPgtFN3vhK7gTQFSM2aKmy6OSb+HKm9NCfoKaHKlXnKRLt438g
         quLw==
X-Gm-Message-State: ANoB5pk802H7RkLZHHQPNo0iYN9HZnwqhITFQ8qXDndmeC9yMc4QHD6A
        wQnPFfISG1nd5RjSpQw/JmkSJ/EqPBNsYkoLlyA=
X-Google-Smtp-Source: AA0mqf5cqMSEN5Xh21dnnxXiG/9yusUv2EuYgkn8wKzoJ8Y3+pg1M9sv3VqMLJn3Ls7XzAd6vZ7AwiZCGnw72ftQEzE=
X-Received: by 2002:a17:90a:e2c4:b0:219:3553:4ff5 with SMTP id
 fr4-20020a17090ae2c400b0021935534ff5mr41452pjb.22.1670878499385; Mon, 12 Dec
 2022 12:54:59 -0800 (PST)
MIME-Version: 1.0
References: <8316344.DvuYhMxLoT@hosanna>
In-Reply-To: <8316344.DvuYhMxLoT@hosanna>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Dec 2022 15:54:48 -0500
Message-ID: <CAPig+cRv02F2yw3Ej1_7PKUV5stKcff82GtdUe5X3wnPfDhfmw@mail.gmail.com>
Subject: Re: includeIf appears to not be working
To:     "Joshua J. Kugler" <joshua@azariah.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2022 at 3:36 PM Joshua J. Kugler <joshua@azariah.com> wrote:
> So, I've set up includeIf before, and have had it working, but it seems to not
> be working in my latest attempt.
>
> Contents of ~/.gitconfig (truncated):
>
> [user]
>         name = Joshua Kugler
>         email = joshua@personal.com
> [includIf "gitdir:~/repos/work/"]

Missing "e" in "includeIf".
