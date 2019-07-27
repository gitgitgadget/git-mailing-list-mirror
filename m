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
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FF51F462
	for <e@80x24.org>; Sat, 27 Jul 2019 20:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfG0Uk0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 16:40:26 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:43317 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbfG0Uk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 16:40:26 -0400
Received: by mail-vs1-f54.google.com with SMTP id j26so38339808vsn.10
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWDlA/WTcLDBmOJdI4F1WfhGEk5+0IggYBEtBSYMssg=;
        b=iTQo8j/3HgMIWSS0PKpJr2FBiVRRxUCjMQRF/bI23LxucVj61xE1RTdsjS/+llAP/G
         ATabAuXOD65Rr5ggq59RAi2pbL1ldERtc9gFa9qwflZYB+NiQr5v9Ppy0Dsm3/CkWtk5
         XLHPIAS5CKl1d9okZn1pAJ4IXq/UsNx1JuG45PGgqjPeG6AKBH9Nnl4U9d6KYiCSpfbQ
         eeeQnMrkPJ0HWd2Sw6BCYF7pupfbcio0xcfkwgGxeIUievierzfPwHtTs9I8VlL/qaFk
         8xAPqC5SjIulmTRSh+98g3VO7RVFThpcJSdWSuu99ZDuBBQhrvotmc1U6vSmOXTa3Mxi
         gMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWDlA/WTcLDBmOJdI4F1WfhGEk5+0IggYBEtBSYMssg=;
        b=E9KSP/83YXN5pOUH4/TVIvEUDLopCSiW8RIjr9sGBEQMOk5/ZtoazVSqSnWe6Oeapb
         UYmaFvVFLx6T6hh3mLO3wvgxftZ2tJ5xLIQnSXHcC/eu5AfTByAwY8mJADGNa02+B6He
         KwdIFNVR+1CrcU+EON7TzQDo5h+7XKb8o2xDuIXmm8Y+N1yarMYuWlBPAK08Aa5JQniV
         tVeDkYDWf2FURndFFqbzzvSxoQgQBlrAHsy4qVJmdB7hBBKPJjFFtjFmY7JgLv3b/noS
         BMjgmw1MjmixfSWMbPQ52XlKhChw0Icc1tDoHv86iaf/vsYKjyuJg7ll4BgC2sYCN85G
         a10A==
X-Gm-Message-State: APjAAAVXb7KWIz6MWtczFEm+i/8gzQqpwnvul2GvxA3HOYUuJhWqFy2T
        6hKVmFdgq45vtHAZNb4JTUqNiRmtBdI4XyQSHlQ=
X-Google-Smtp-Source: APXvYqzc+4M+0+5dXWn9TeKRvG8uPfgguYND47/F1syiXB9vrZnp+2fMqra1hr1uF6ynUn3aicttEiVpJcNl/k/O6PM=
X-Received: by 2002:a67:300f:: with SMTP id w15mr59497498vsw.116.1564260024500;
 Sat, 27 Jul 2019 13:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com> <20190727193814.7400-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190727193814.7400-1-rohit.ashiwal265@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 27 Jul 2019 13:40:13 -0700
Message-ID: <CABPp-BEq+d=9G+U4im4fSEL2jGhggBwpoa+X7ZUjEGMPOPuFTw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

Let me attempt to answer on Junio's behalf...

On Sat, Jul 27, 2019 at 12:48 PM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> Hi Junio
>
> On Thu, 25 Jul 2019 17:19:23 -0700 Junio C Hamano <gitster@pobox.com> wrote:
> >
> > * ra/rebase-i-more-options (2019-07-23) 4 commits
> >  - SQUASH???
>
> There are only 3 commits in this "series".

There are four, including Junio's commit he had to add in order to
make the series merge with pu (a rename of your t3431 to the
unoccupied t3433 slot).  He labelled that commit "SQUASH???" and it's
still quoted above.  However, in general, when you submit the next
round of your series, you should certainly include his fixups from his
squash (or alternative fixes) inside your commits in order to get rid
of the need for the squash commit.

> >  - rebase -i: support --committer-date-is-author-date
> >  - sequencer: add NULL checks under read_author_script
> >  - rebase -i: add --ignore-whitespace flag
>
> The correct order should be:
>    - rebase -i: add --ignore-whitespace flag
>    - sequencer: add NULL checks under read_author_script
>    - rebase -i: support --committer-date-is-author-date

Are you thinking in order of application, or order that would be shown
by `git log --oneline`?  Junio includes the latter in his report.

> I'll soon send another revision and while on it, let's merge
> these topics into one. Should I also rebase them on the tip
> of git/git's master?

What do you mean by merge these topics into one?  Do you mean merge
all the commits into a single commit (which would be bad), or that
your two original topics should be one, much like Junio already did?

In general, once submitted, avoid rebasing unless needed to integrate
with someone else's work and clean up conflicts.


Hope that helps,
Elijah
