Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07441C67871
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 22:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiJXWHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 18:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiJXWHX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 18:07:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E0818B4A0
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:20:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id g1so18495255lfu.12
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HNPUj8Puu7R+gCwSNsvD764UOxnTz2eDdIPFuxPI9s=;
        b=WGRFY1ttqqiypnIlrsTex4at3oDqjG4QWxbLCsdHWCceuMYm9DFePCitmoN1tzYfhf
         i0V/dHjLEKmiQJ1rVbybyy3zaMl9bDfQcBLQeW7rLCz1g/E0k2g5uH5+54Pt1vaTFXMe
         qEz+9mQeSSSJSGVecLa4rCSry9pTZ5hwenxgLZz8lW/FW74r3Uu/nD5pMlj9+0FFmQQS
         lqAnta+gUR5WuV/ye31VuL9qmULHjMJoS7GUtZds5QYJ2ywz7TK9DHWD9MBjbojicxHW
         aAW/0q+b02p79x9yrEFjOnPkpqccYOcYnwd5CwgIjeWZ6GuXBiSiqSsDRvvKH0VGSdHu
         TTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HNPUj8Puu7R+gCwSNsvD764UOxnTz2eDdIPFuxPI9s=;
        b=rid/Ws+V9ZVmmCa16BMVPqpHRQE1Lzp7YhSw9M2KVpsJ30RUAdPzEFH5POGQ9t7w/9
         d9EteB6acTCifm8CnfgLb/gSlYCT9MGau8Nxh3i0/bEC+HMk3bNLD2nLuZOlG27T95gp
         C9bl7Y22pcnomHiiEuEg8rkyTpoXzbhR6EpKAw/11S3GvGd15DARe+RG2OZK0YBOZ3ys
         nip/RYko5UGnpByUnD909qsQopElKlBhXXq/27qqX1IL86pHD9oVIwskeamsU6bVhp5o
         aEB4KZ09qEK73rgyo8Oa4nqq4IqLYowh+hVc1uK34Jd9HdtIV3iigpTDCFVulyoxRve3
         IT/Q==
X-Gm-Message-State: ACrzQf2fuMWCEv+nDVG3dtNrxkfH3gFCHwojrYVj97oqHaIWVhDvhY6s
        kk/kRF2JLwo/mgLsp0N2cDH7nZAdwlHeG6KDntbCiA==
X-Google-Smtp-Source: AMsMyM6vBWoA5hhYp/VqT+UhoiCl5pnNyxe3L+VaetsrkDp+XiBgByuBkfkVkrjEsaTK7/rOH/PCmto6qVMKuTbmoMQ=
X-Received: by 2002:a05:6512:3503:b0:496:55d:a186 with SMTP id
 h3-20020a056512350300b00496055da186mr12175679lfs.340.1666642789611; Mon, 24
 Oct 2022 13:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
 <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com> <Y1M1JGBzZqoPUy9I@nand.local>
In-Reply-To: <Y1M1JGBzZqoPUy9I@nand.local>
From:   Julia Ramer <prplr@github.com>
Date:   Mon, 24 Oct 2022 13:19:38 -0700
Message-ID: <CADq8SzUn_pZvyXdv=keNN2rWVvG6n5QLVxPKt_XNmOz5wJbTrg@mail.gmail.com>
Subject: Re: [PATCH v3] embargoed releases: also describe the git-security
 list and the process
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Julia Ramer <gitprplr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I incorporated all suggestions into the next version.

On Fri, Oct 21, 2022 at 5:11 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Fri, Oct 21, 2022 at 07:41:49AM +0000, Julia Ramer via GitGitGadget wrote:
> > ---
> > .../howto/coordinate-embargoed-releases.txt   | 175 +++++++++++++++---
> > 1 file changed, 147 insertions(+), 28 deletions(-)
>
> This version looks great, thanks for your work polishing it up based on
> mine and Junio's review. I agree with what Junio said downthread in [1],
> and left a few minor nitpicks of my own.
>
> So, I don't have much to add beyond what Junio wrote. I suspect that
> between my feedback below and his in [1], that should be enough to get
> v4 ready to be queued.
>
> > +- The security-list members start a discussion to give an initial
>
> s/security-list members/members of the git-security list/.
>
> > +  assessment of the severity of the reported potential vulnerability.
> > +  We aspire to do so within a few days.
>
> Well put.
>
> > +- Code review can take place in a variety of different locations,
> > +  depending on context. These are: patches sent inline on the
> > +  git-security list, a private fork on GitHub associated with the
> > +  draft security advisory, or the git/cabal repository.
> > +
> > +  Contributors working on a fix should consider beginning by sending
> > +  patches to the git-security list (inline with the original thread),
> > +  since they are accessible to all subscribers, along with the original
> > +  reporter.
>
> There is some slightly odd wrapping between this and adjacent bullet
> points. It looks like the width of these lines is slightly shorter than
> the others.
>
> > +- Once the review has settled and everyone involved in the review agrees that
> > +  the patches are ready, the Git maintainer, and others determine a release date
> > +  as well as the release trains that are serviced. The decision regarding which
> > +  versions need a backported fix is based on input from the reporter, the
> > +  contributor who worked on the patches, and from stakeholders.   Operators
>
> There are a few extra spaces between "from stakeholders." and "Operators"
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/xmqqo7u5m8ku.fsf@gitster.g/
