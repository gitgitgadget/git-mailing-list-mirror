Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2990B1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 19:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437169AbfJXTqc (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 15:46:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39161 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437157AbfJXTqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 15:46:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so57341otr.6
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HbFEUZkJLVPpvPrDWGikyacLV8OxPiYfyACUr1Mnhpo=;
        b=L1s1sctkzsv/NrBDf96j5nIMYMTwYkg775ZLwTQRM41glcRyditQnaBzeZqmlkqDdN
         Ntr4RDbyGXWMS/vpdXvzZAACjyZ18C4TRv1btVFH2FirrKBvSnG3gyjSRXLnt+VUs9bW
         xNZJl+yX8oxV2V7UH+hHypMgWn+ie8I+QDb7HfUMdsJus0+6Kw1gEzGwEsXvbnupJB3N
         vWqX1AmtDND32eZ1WwJk8NQqH1gIZB3axnNE2dWbFHwN/puR/TSZoUowLrAM6I5p0ugP
         OgITStJytrEDRKGlOn54kwGtnqgtcEzk3TFJI6f2ATPubLTpkvXR1Wzd3T52KYeP3ygG
         28LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HbFEUZkJLVPpvPrDWGikyacLV8OxPiYfyACUr1Mnhpo=;
        b=rJ1nrTg09mhLg1iIqPXBphLWp5nemzTjfkteaJct7rpJBWtDyWEisKpGXYfqkY33Js
         zxnTLj6KfQncT3Nhj8D4ci/64hF/NedKOEKRJCUvbyJDC+ILOGuVp2TKmkFLMpqtRdLg
         eJaNzQh0npGQrNAqxT9BLXzFJY4JKKVDIaZUQzixEHo/8MMGK3CcIyxYjwif4FNDapce
         izYFTZPHqyOUi5udaMGevck/NuIH8t7DHMWQzsEcWdEeXcE/e2oytvIkSyWp/Jam46j5
         c6j9aSKAkBknih7c5Pjf6KQp4URA9FW7OwXyEGCfTkPYVWl40r0drwusiQZA8yOeSY51
         npFg==
X-Gm-Message-State: APjAAAURj3TNpgrWIW3BFGaouIX/ulNMPeiSVf4r7+NEltgN8qz21Gax
        rhV5Q2ftjZWrUZTRLB5RSYGeU+wd6Sxcdqtunf4=
X-Google-Smtp-Source: APXvYqwWocVPy7Y0ydiVV+WSvzaF49TCoaps9TZHCQEZTg70DGLdzCF4yKoDCOB733jGYEJtruI4mqzaIcohJJ3eFvY=
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr13442557otn.316.1571946391385;
 Thu, 24 Oct 2019 12:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
In-Reply-To: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 24 Oct 2019 12:46:20 -0700
Message-ID: <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com>
Subject: Re: RFC: Moving git-gui development to GitHub
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 24, 2019 at 2:45 AM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> Hi everyone,
>
> I recently had some discussions with Dscho about whether it is a better
> idea to use GitHub for development instead of email [0]. His argument
> was that GitHub makes it easier for newcomers to contribute, since more
> people are familiar with GitHub compared to mailing lists. Also, it is
> somewhat difficult to set up an email-based workflow.

Interesting; I had been pondering asking the opposite question for
filter-repo: Even though filter-repo is tracked externally to git.git
(since we seem to want to move to a batteries-not-included model),
would it be okay to ask that filter-repo contributors send patches to
the git mailing list (possibly specially marked somehow)?

I'm debating between:
  - Ask contributors to send filter-repo patches to the git mailing
list (if okay).
  - Try out GerritHub (GitHub + Gerrit; see gerrithub.io) and maybe use it
  - Assume there won't be many contributions (wouldn't be surprising)
and put up with GitHub PRs

GitHub is great for ease of creating new repos, learning about other
developers, finding similar projects, creation of webhooks, etc.  But
it's *awful* for code review.  Gerrit is a lot better at code reviews
(though still has problems); so maybe dealing with both GitHub and
Gerrit would be reasonable.  (Reviewable also exists, and is kinda
decent, but I can't respect anything that doesn't offer reviewability
of commit messages.  And it makes me feel bad by making me want to
swat butterflies.)  Email is a horrible medium for sending/receiving
changes, but at least it gets the overall code review model right
(commit-messages-are-first-order-objects-that-can-be-reviewed,
review-individual-commits, merge-per-topic, cover-letter included,
range-diff for high-level comparison of different iterations,
reversing-commit-order-display-based-on-author-timestamps-is-NOT-forgivable,
Change-IDs-are-ugly, magic-refs-are-disgusting, etc.), something no
GUI tool (yet) does to my knowledge.


So...would anyone object if I asked filter-repo contributors to send
contributions via email to the git mailing list?

Thanks,
Elijah
