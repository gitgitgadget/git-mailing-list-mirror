Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64EC31F954
	for <e@80x24.org>; Sat, 18 Aug 2018 22:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeHSCAM (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 22:00:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34472 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHSCAM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 22:00:12 -0400
Received: by mail-pl0-f65.google.com with SMTP id f6-v6so5316876plo.1
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eRdPI6scb15tYlaX3Ou6UFLR1K6R7gT2jkJaavD1d/0=;
        b=q2/GHzQXSMPmaaUbMnSf3GtIZBWJ7l/krIDlnQpGuzbDSxlrzKmREw/57sI4OYSsCC
         hvSiOCg9zWpRDFaFoR4GYRiEJ6lqJIivxnVk6TZwVzALWw7Qu4xUHDQ5krxOWuoHcXjF
         iN+Ix65844Dg0inv15hOOYJfelJihBRn/c2Ng6O/IottggAYZk0a0Q5OLYkOfu3Jmm8w
         t98ip29ZlXqIsliqM9JKgDSQp2boYnRgdPDRRl8oDraipc/ou3nV/9JmDX5DsclhjiP3
         m0/aK2O90hyBfmYkgnv1sjIYReL+vztIR8KkW3ms/BfExXGHnfdqYwWa9D6CK+l37Mmc
         /ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eRdPI6scb15tYlaX3Ou6UFLR1K6R7gT2jkJaavD1d/0=;
        b=fmpG+m976/RDzctQTpfRO5s50UwCS5zOc7IeolhQKztdfVbbPdFtpSKY9rccJ/7hsq
         4pBX+EEke6IQjd98HqGV0AInU07A3DH2R26Mlj2JKWkrazb93xYvlkfmKt0cq5Xe8m5E
         2xDIdSJoKud6+kkgeaYbEMjHm+TOot77nIDSYr4Yq62y+hklK5L8dXwux7LUiuLq/mqI
         mlWfMRFK8bGR4yBV0Ad28cThBaQwJ2fKLoHkVQCWnO6L3vPuSFQfWcoxSmXW9YJ9YFd0
         QxvozdTML2eEBC1o9szCN7HZsbES9WGir6Dgg/W9alGXqa8A9aCMkqa9Pk52hCVy6WbJ
         q49Q==
X-Gm-Message-State: AOUpUlEkoxmzSyxaB4dijaIdBkzDl4NGrp7V12P3bIAjdYZ+zdrK0BC8
        zL0eXdYwAPcyY0OZa3ZgdCU=
X-Google-Smtp-Source: AA+uWPx1RNCZ6H8pOVGUxqy3+1b8sGFoIh4EFhl9oEMjFW661rgRYsIIYIaUG6QvnQqVGJtBBWEVpQ==
X-Received: by 2002:a17:902:59cf:: with SMTP id d15-v6mr2593790plj.184.1534632654569;
        Sat, 18 Aug 2018 15:50:54 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s73-v6sm8382283pfi.154.2018.08.18.15.50.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 15:50:53 -0700 (PDT)
Date:   Sat, 18 Aug 2018 15:50:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Michael =?utf-8?B?TXVyw6k=?= <batolettre@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: git-bug: Distributed bug tracker embedded in git
Message-ID: <20180818225052.GE144170@aiede.svl.corp.google.com>
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing Elijah Newren for the points about merging)
Hi again,

To avoid the other thread shadowing more important things:

Michael Muré wrote:

> Someone suggested in the Hacker News thread [0] to post it here as well.

Thanks to Ævar for that.

[...]
> git-bug use as identifier the hash of the first commit in the chain
> of commit of the bug.

Clever!  I like this approach to the naming problem.

[...]
> Git doesn't provide a low-level command to rebase a branch onto
> another without touching the index.

Thanks for pointing this out.  There's been some recent work to make
Git's merge code (also used for cherry-pick) less reliant on the index
and worktree.  See https://crbug.com/git/12 for some references.
There's also been some heavy refactoring of "git rebase" code to be in
C and be able to make use of library functions instead of being a
shell script.

That's all to say that we're in a pretty good place to consider
introducing commands like

  git cherry-pick --onto=<branch> <revisions>

In absence of that kind of thing, you can run commands that need to
touch the index (but not the working tree) by setting the GIT_INDEX
environment variable to point to a temporary index file.

> I'd love to have some feedback from you. Contribution are also very
> much welcomed.

Can you say more about the federation model it intends to support?
For example, do you imagine

- having multiple copies of a git bugs repo that automatically fetch
  updates from each other

- having explicit "pull request" synchronization moments when the
  owners of one copy of a bug tracker push or request a fetch of
  changes that have been happening on another

- individual contributors using an offline copy of the bug tracker
  and pushing push/pull mostly to synchronize with a single
  centralized copy

- something else?

Thanks,
Jonathan
