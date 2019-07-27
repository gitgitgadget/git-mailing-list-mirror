Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92CF1F462
	for <e@80x24.org>; Sat, 27 Jul 2019 21:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbfG0VA0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 17:00:26 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:39322 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388035AbfG0VAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 17:00:25 -0400
Received: by mail-pf1-f169.google.com with SMTP id f17so22102633pfn.6
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fr1b7jpH0T6ffKiO9caVwpcfOibxm9vY1UwuRn6sEHE=;
        b=sF/4Z+v8sO3kH8ikSDJt7RT5hDLHy2kfJqOwbus9G2zLAjeOxLMlpglPxZsmQW+2IV
         zfK1Oxo29jdPdMrQtuPh/5D8vdIwReXSQCXR3IboxyK6++tM5hAVzhUKyJqfZds/llYt
         RXb/9ykSzV+V5XG4CF8Rq5RgXzc0/nztLUaukfIP33knYJbTgTfiMayMpu5nwl8uyrjs
         y1Gz0CkEQETTi9XZ1oVvR6tNtGku8ZWBg/1hMiZrqtjTtLhY4IiFASrcC156YxWZ4HjM
         Jt5syu5e5AQvc5NyToY8Nm9NA/IyPwyTtinHNXm1HsZ3cE5Oaowpkf8pBFFjNyy4qDmn
         q3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fr1b7jpH0T6ffKiO9caVwpcfOibxm9vY1UwuRn6sEHE=;
        b=p5CMdl0he5NjlnPESUkZaQuv2H/KAH7T794x6gbdy1D0JCn7BM6wLJWrMF7cBDsqoc
         8QVwzOCwzhoPqcHrKy88K757HlytoJwb5L6Q+3CP03DkcjQNbB9LvVzMsoHOHDeaVjdK
         x8iO8CjBqkAHgHMEk4vC+TBr0wGVu4sPExKKsXLgjbf+E1LlH+Tez0UZ2QR/B1e+JUCF
         409yewIKf9606vXpJcX8Iwma0tAccxn4E+G8EKiE02nSTAmx9XA18MtmYlUitAbIeBUk
         h6TcdkG9NLavq1mT6/shVFbXjhuhd7muGgsD7K4m/cknJpTbk/sOjw+1Upt4Adzm4yzy
         lpjA==
X-Gm-Message-State: APjAAAUMIVE4Ja6G5QUreNuwNA27UXwqfEyFlV3+muzpFdh7ilPjJTqk
        FTln5dzzWlGSkRmiF177Zc0d0hp8eFI=
X-Google-Smtp-Source: APXvYqxoL8pxl8tnDOyjz5ZTdQTzABd8lV5VmXvBJHj8QI2wodU+e/HLiSxlVvGcuknfN8lWDgG2RA==
X-Received: by 2002:a63:4041:: with SMTP id n62mr26192108pga.312.1564261224615;
        Sat, 27 Jul 2019 14:00:24 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id s3sm18016661pgq.17.2019.07.27.14.00.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 14:00:23 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, rohit.ashiwal265@gmail.com
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Date:   Sun, 28 Jul 2019 02:27:32 +0530
Message-Id: <20190727205732.16361-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CABPp-BEq+d=9G+U4im4fSEL2jGhggBwpoa+X7ZUjEGMPOPuFTw@mail.gmail.com>
References: <CABPp-BEq+d=9G+U4im4fSEL2jGhggBwpoa+X7ZUjEGMPOPuFTw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On Sat, 27 Jul 2019 13:40:13 -0700 Elijah Newren <newren@gmail.com> wrote:
> 
> Let me attempt to answer on Junio's behalf...

:)

> [...]
> There are four, including Junio's commit he had to add in order to
> make the series merge with pu (a rename of your t3431 to the
> unoccupied t3433 slot).  He labelled that commit "SQUASH???" and it's
> still quoted above.  However, in general, when you submit the next
> round of your series, you should certainly include his fixups from his
> squash (or alternative fixes) inside your commits in order to get rid
> of the need for the squash commit.

Understood!

> > >  - rebase -i: support --committer-date-is-author-date
> > >  - sequencer: add NULL checks under read_author_script
> > >  - rebase -i: add --ignore-whitespace flag
> >
> > The correct order should be:
> >    - rebase -i: add --ignore-whitespace flag
> >    - sequencer: add NULL checks under read_author_script
> >    - rebase -i: support --committer-date-is-author-date
> 
> Are you thinking in order of application, or order that would be shown
> by `git log --oneline`?  Junio includes the latter in his report.

If applied in this order, I think, there is no need of fixups.
But renaming t3431 to t3433 is still required.

> > I'll soon send another revision and while on it, let's merge
> > these topics into one. Should I also rebase them on the tip
> > of git/git's master?
> 
> What do you mean by merge these topics into one?  Do you mean merge
> all the commits into a single commit (which would be bad), or that
> your two original topics should be one, much like Junio already did?

I am thinking of mergin the original topics, yes, just like Junio did.

> In general, once submitted, avoid rebasing unless needed to integrate
> with someone else's work and clean up conflicts.

I have not checked but git/git:master is like 569 commits ahead of
r1walz/git:master, there _might_ be conflicts. Should I rebase if
need be?

Thanks
Rohit

