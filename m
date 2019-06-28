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
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F761F461
	for <e@80x24.org>; Fri, 28 Jun 2019 19:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfF1TLi (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 15:11:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54998 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfF1TLi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 15:11:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id g135so10090905wme.4
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n+LTJU5RlfvSaUtTEMGxryCMk1hA/IVLttJ8H4fXOfQ=;
        b=r8wSQKVBn+WdsbDi1eNsIAHQdepFJ933NgM0yBemKe7vTkGTcmW4Tw4X2NcW7v/Abq
         m+3eicLCzWQz29jwRy96do5Sjkr0C8BIXCgP7EuRC3GNF2hXE0mITjC7pUzCshmyVsB2
         Zbbi1ha0eAI2Q9iP8qPHNPWVgcZl/LUX4b0J8TyDXHy4tgxia+3k7hmyLK1f4r3Oy2F4
         AoDgmYlD3BT9cvivaXxdZsfVrn1c3eDPLiDKMt7iAvB+FrflLrqzIJeKoIz/lNPlP65b
         UKoBIapHHrbyk0h1VHFXU+/kZKoYEwW4iLszdUR6HJU0VuxcI28CdNHci7UbykTKpmW5
         dcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n+LTJU5RlfvSaUtTEMGxryCMk1hA/IVLttJ8H4fXOfQ=;
        b=RNACGx7Vyyk/eyJGpqibzV1QO4YvVnsRejUE0TL2q5S4xnG0DE+QCaKB7cj6zu6GnJ
         7/+fL4zMj5OE7UZsO5ghwaJnabqMM/ETt5PcK09BCU/CDqoQy+BMdCgnafvTDDnzpnhK
         dh7z8KDUPs++v6iCKiQjbpJq+0GCPJQQn75DUn4Ey8tnQaL9N6idCTipdIQeyBuafLxd
         RGYvYgm2Q7tJXUpiUmBbwki01BjezEpfj5y4pbq7IUNSMd268NThEjltKOuMPySTox31
         emlw5HKau8sK0+R6aOudpJXGKNfwxb0HWgavgMa7jgWfMAOvoYy9LdAOM3kCgBxaaGW2
         FsqA==
X-Gm-Message-State: APjAAAXU1wIgM2YZdWwSEwlotzXuQQRxz/wUsCdzGXmtC5J1V0HNy6X3
        tTAty0ZiW81FzxxygztliDw=
X-Google-Smtp-Source: APXvYqzg1mntfuSBINJq76TjyLht5/jM6Q5WJiE7mRB1nh3Sz/4+zi+hyY/MT4fozjDyQhi7yD+vOg==
X-Received: by 2002:a1c:c74a:: with SMTP id x71mr8234855wmf.121.1561749096109;
        Fri, 28 Jun 2019 12:11:36 -0700 (PDT)
Received: from localhost (adsl-24.176.58.195.tellas.gr. [176.58.195.24])
        by smtp.gmail.com with ESMTPSA id g8sm5104263wme.20.2019.06.28.12.11.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 12:11:35 -0700 (PDT)
Date:   Fri, 28 Jun 2019 20:11:33 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
Message-ID: <20190628191133.GA15477@hank.intra.tgummerer.com>
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/26, Junio C Hamano wrote:
> * ra/cherry-pick-revert-skip (2019-06-24) 6 commits
>  - cherry-pick/revert: advise using --skip
>  - cherry-pick/revert: add --skip option
>  - sequencer: use argv_array in reset_merge
>  - sequencer: rename reset_for_rollback to reset_merge
>  - sequencer: add advice for revert
>  - advice: add sequencerInUse config variable
> 
>  "git cherry-pick/revert" learned a new "--skip" action.
> 
>  Is this one ready for 'next'?

Yes, I believe this is ready for 'next'.  I had a look at the latest
round, and only had a minor comment on the organization of the patch
series that is probably not worth a re-roll.

I also added Phillip to Cc, as he's been heavily involved in reviewing
this series, in case he has any more comments.
