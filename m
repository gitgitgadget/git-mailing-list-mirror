Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B58AFA373D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 22:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiJXWGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 18:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiJXWGP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 18:06:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F797C76A
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:19:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id be13so18536636lfb.4
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9IFgO34ruSzjVcPNOGGa3gskV1U0j1BDTjUvgU22EDQ=;
        b=ehAJ4G/3UVwa3nixTY5BQXgYm1X3g/O12QQ07bEXqghBf05Y3pTEGMjmGENhV4xEka
         Zfu0YjHhX6yClmYC5zldRGty/GRLlNDMJoR3379gONbh/FJGGxNV+ghqHl3GJAPsy5HN
         oLZyaab3Tv/HtsbhEaND10PnyzOIQbaYfDaAK3kmvQ+I7ewa3VWVOLWY/dWVx/sPNY4a
         GQLVeylfS3WVK1bInoO7QNFrIxmZxkHCygBiub7CBvQ7iKZoCj0d5O0SMKEw/mIQpfK5
         wv2NmuuZNcTVtUKG5W5KEJVOvGtPvMFBhIGmwQPo6V6ZFsIBBiNDhhxxFuruv8UidDi1
         kg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9IFgO34ruSzjVcPNOGGa3gskV1U0j1BDTjUvgU22EDQ=;
        b=pwR3Q+dovL3k4umVm/+Ueh1sgkEfRPmIuiUv4poMFemmNSzlzD3vLCkzDjgz1gcyWD
         83LC13odJ4SQi8hjwEEQhzjmm3y3mGNOPih9TwBYVy03lUywVjvVKZ1gju3V+loA1/67
         lsMNPa51INekzAYMnN8M2f8NpDBo/GquzpQLjUDJmMWWGfI0vKpbJ/55rqN9nyO5GEpO
         0w+MH5omOZjxKwrg26MJbHG0MPMDge43DTzF8HkXbwvre5TwdDWVUibyEMcmOr3yeDWW
         BaSCNurp1JZnSoiksq5lM7MlITRLwfdInXD9tGqgeKgODMbz+T15TV9HF2W0dBU0X4pR
         VHRA==
X-Gm-Message-State: ACrzQf3QHAj9Vga3duY6eye/jOKpafM2l90qKr8vCdUzYDmuOx0cvYP1
        HkSnyF30Mx7TGm7btiUxzIMMd8+3QJor+jhpkoVJHg==
X-Google-Smtp-Source: AMsMyM7i90KHb8UNqas0feD4a87FH7bQMC3z0tjV5QaDyCyaZVr4M8hIfKup9mci/mQeMw3m5GTAExvD8g8O/FiQMbU=
X-Received: by 2002:ac2:47fa:0:b0:4a2:361d:da19 with SMTP id
 b26-20020ac247fa000000b004a2361dda19mr12289558lfp.548.1666642712596; Mon, 24
 Oct 2022 13:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
 <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com> <xmqqo7u5m8ku.fsf@gitster.g>
In-Reply-To: <xmqqo7u5m8ku.fsf@gitster.g>
From:   Julia Ramer <prplr@github.com>
Date:   Mon, 24 Oct 2022 13:18:21 -0700
Message-ID: <CADq8SzV06zTHmG+uSW==R5sL=MveuA9VSMhpV8hck+rzvVSp4Q@mail.gmail.com>
Subject: Re: [PATCH v3] embargoed releases: also describe the git-security
 list and the process
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Julia Ramer <gitprplr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 9:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> > +- Code review can take place in a variety of different locations,
> > +  depending on context. These are: patches sent inline on the
> > +  git-security list, a private fork on GitHub associated with the
> > +  draft security advisory, or the git/cabal repository.
>
> Here, we name "the git/cabal repository" but the word never appears
> again in the document, we later refer to the same thing "private
> repositories that are owned by the Git project, with tightly
> controlled access", but to outsiders, it is not clear that they are
> the same thing.  Perhaps writing
>
>     ..., or the git/cabal repository (private repository owned by
>     the Git project with tightly controlled access).
>
> here, and replacing the later reference with just "the git/cabal
> repository", would be sufficient.

Fixed in the next version!

> > +  Contributors working on a fix should consider beginning by sending
> > +  patches to the git-security list (inline with the original thread),
> > +  since they are accessible to all subscribers, along with the original
> > +  reporter.
>
> Or we can make it a separate bullet point, which may make it simpler
> to read in the source form.

Fixed, thanks for pointing that out.

> > +- Once the review has settled and everyone involved in the review agrees that
> > +  the patches are ready, the Git maintainer, and others determine a release date
> > +  as well as the release trains that are serviced. The decision regarding which
>
> We typically know how involved the final changes would be (i.e. the
> minimum time it would take for us and involved others to prepare the
> release) way before all the t's are crossed and i's are dotted in
> the patches, so setting the release date may be done much earlier.

Distilled into s/ready/nearing the finish line/

>
> > +- Less than a week before the release, a mail with the relevant information is
> > +  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce
> > +  embargoed releases of open source projects to the stakeholders of all major
> > +  distributions of Linux as well as other OSes. This includes a Git bundle
> > +  of the tagged version(s), but no further specifics of the vulnerability.
>
> I am not sure how much value it adds to have ", but no further..."
> at the end.  Anybody who sees this e-mail has the Git bundle, which
> is relative to the last stable release, and can be used to create
> the full source of the releases by anybody who has access to the
> public Git repositories.  The source includes the release notes in
> the Documentation/RelNotes/ directory that describe everything to
> know about the vulnerabilities the releases address.

I think it makes sense to just remove the entire last sentence, as the
relevant information is referenced in the parenthetical "(see below)".
