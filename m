Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4EC11F954
	for <e@80x24.org>; Sun, 19 Aug 2018 02:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbeHSFQO (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 01:16:14 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40063 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeHSFQO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 01:16:14 -0400
Received: by mail-ua1-f66.google.com with SMTP id m13-v6so7875803uaq.7
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84hsDcY3esNJSrCB16SPHsSJuG/cK/07q2amekKlPRU=;
        b=kZN6wJKR8aZQ3uAVaX5bXq2nTon+5+9SBowfS33spY+YgGYzTcj2zS6yPncWOWSwdA
         HXvrfkpblbWrSc/i0rrrTh5TlQ+TKZEXO/swRgNhnw9uSXXgRJ5HH5FkenhjCOcSN+k1
         4WmBZ+Xxawbzozis/9OU+Tegz+G+ZJR3iuyxmtVzeJRoSTL4idwsbQcRdyrDTl9BWn5h
         QzcPaFu8Os/95VUTr0sad1lHMOThIPBAVN8G64nyC6vuGeAZR9uSzpdnr4UzmfVuV0JL
         lHTSxnC4IigKM+iPtgNMkrR//7QsqrxDtWvppWw+ggVfi87hyqtlh+/ej3snX9VNUhTN
         JpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84hsDcY3esNJSrCB16SPHsSJuG/cK/07q2amekKlPRU=;
        b=qm8kgvRNHeilB+4VUD+Iqr+zuB/IoW9Yu127Y7Lg7EBUOQMnJmxFQaHiEyPq4ZSmmS
         EE3eFKvMnNwK3wRIhSE46ZnkHIYx5et0vejdtuNFGAhWDoS7nnaHGsgozLaOaFNuCXxy
         FAIG3JkJYGb4QKZpBfvRBqWa6aaLj491pMsYYNuhhJ7NvsjJ/syt9Pty+aDmPvgGS5DJ
         26OmyClGJatG4UzW2xGdH3JFhkpR73Z5/U/ijW8cA5ioCpzZjYuwhg9W5zLQGHQzqaCa
         pFwIxg/ZSAQE/T7ardJ/64+GPt4iwpIMryZRtPN27wfDTXbNQCFH55mbZYM+koq9DlJt
         TTOQ==
X-Gm-Message-State: AOUpUlFNoZKYAf5i1YwLo39TeACoRIiSK7wygipSu+n9/iLSIQLKcqjS
        ry2gOPbx97anLQZpg1ov5vZkOKDTLMMjdC/yDHc=
X-Google-Smtp-Source: AA+uWPz6hSAmbH3vY3Pp7Al6QkQ0g8E9iQDF4KvTjjgsNGHkUCcgPdpcPVYJ7g2bqCGTpQhwH/nayPf2eomyxroMqQA=
X-Received: by 2002:ab0:3242:: with SMTP id r2-v6mr26912303uan.92.1534644387659;
 Sat, 18 Aug 2018 19:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
 <20180818225052.GE144170@aiede.svl.corp.google.com>
In-Reply-To: <20180818225052.GE144170@aiede.svl.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Aug 2018 19:06:16 -0700
Message-ID: <CABPp-BE+zfWOqQQoO0mvJPefODW3fDsfYuC6OzBzSD5fe1xarg@mail.gmail.com>
Subject: Re: git-bug: Distributed bug tracker embedded in git
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     batolettre@gmail.com, Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 18, 2018 at 3:50 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> (cc-ing Elijah Newren for the points about merging)

> [...]
> > Git doesn't provide a low-level command to rebase a branch onto
> > another without touching the index.
>
> Thanks for pointing this out.  There's been some recent work to make
> Git's merge code (also used for cherry-pick) less reliant on the index
> and worktree.  See https://crbug.com/git/12 for some references.
> There's also been some heavy refactoring of "git rebase" code to be in
> C and be able to make use of library functions instead of being a
> shell script.
>
> That's all to say that we're in a pretty good place to consider
> introducing commands like
>
>   git cherry-pick --onto=<branch> <revisions>

Yes, indeed, after the merge refactoring/rewriting stuff is complete,
this is one thing already on my list that I wanted to do with it.
Another thing I'd like to investigate with it is how much "in-memory"
merges could speed up interactive rebases, as suggested by Dscho[1].
Once we do "in-memory" merges for interactive rebases for performance
reasons, we're pretty close to having a
rebase-without-touching-index-or-worktree that we can make accessible
to other scripts like git-bug.  However, we have to have a pretty good
answer about what to do when we hit conflicts.

[1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet/
