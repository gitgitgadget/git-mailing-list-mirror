Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166551F597
	for <e@80x24.org>; Wed, 18 Jul 2018 23:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbeGSAVl (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 20:21:41 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:41310 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGSAVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 20:21:40 -0400
Received: by mail-yw0-f173.google.com with SMTP id q129-v6so2395754ywg.8
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+HI4FZhjZWbe+3eShOPWNwyHqwar11TbwAoANjou9A=;
        b=u1I2yAuNUG2IKQ5z1t6mUZG1k+P4gYSI+7u3elCogL+GbhEpX+PIkS6CKKgrWM26QF
         oA33P/DyLheGxjZhY5rvjNkXTs2AhGVzuXbLbf/g7/fHA2xKLeupfFOopwPQ9v6nPOyH
         iMkj6YPcgaM6INXNSE3cVArsROZOtmSilbRS9dfEWkmlzWiLOeIVfzBMEctnFW0qdaBW
         1Hs9vuGNNbENdTKAnd+GLh6yYVSBsAnJ8g5u3uMmS+LR3y+1852L3z7g8yZzRW2bUnxz
         RuEBG9pG55sQMA6Mt9EzPOYGPsItP7LRGMWKEIrQhzfgRYQPjd1HNF/wX9H4cw+/LMje
         1rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+HI4FZhjZWbe+3eShOPWNwyHqwar11TbwAoANjou9A=;
        b=hhH2QFaW2wdoim9haOVxZ41cOLJ9wiLomIhTawfc7vyv0bTJznJ9+AceOjoVaF6txR
         WnxpbDxcCRJQskjJrMJP/gFMY9nALYdd/AO2Ad87Orj0mUk2GMrAdMcA/qyjvilVInjJ
         8CamrP6WDRsHRYBZPkr7qgCHZB4Cv5VjxJzLhHv7F/w2MUJF63MJGK8Jk+C//Xf1kxEb
         2X3hTl1VKq1eIJCz8acytFdBLxHP62bPnsESkqoCqRY5pZDd5C8dIcQawUcmDMoN/pb0
         cZ2goKQUP6E7uH7hK8l3876Nof7m0rVlv2pX0JNQha94cCa16CqO2PGM6ndrjoh5hIyp
         nkQQ==
X-Gm-Message-State: AOUpUlHOi2h5P1rMyDrLIygr746SFb4GoJkrLWgVNXG5tsk0g4O+7J7s
        X837xcbgGo2IqsH1Mul59uTECZCOiUNkgGZHMjyZBQ==
X-Google-Smtp-Source: AAOMgpf9CXw49rEPlxxWBdXHreeV2RmBZ84N8nfbUDdzoAGGqg38HXEAILdSsbngDnATe5bxTapszWy20U4BN3cFvig=
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr4137632ywd.500.1531957284497;
 Wed, 18 Jul 2018 16:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 16:41:13 -0700
Message-ID: <CAGZ79kY15nPGwtOF=i09gQpykcxT4ZRzakuBr=aD94wRXtKOAQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2018, #02; Wed, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote:

> Many topics have moved to 'master' and 'next' from 'next' to 'pu'
> respectively.  As I needed to re-resolve semantic merge conflicts
> while reordering some topics (i.e. some that were merged earlier in
> 'pu' are left in 'pu' while another topic that had interactions with
> them and required evil merge to resolve semantic conflicts
> leapfrogged to 'next'---the semantic conflict resolution then need
> to happen at a different merge than done earlier in 'pu' while
> rebuilding today's integration), I didn't have enough time to spend
> on new topics posted to the list in the past few days.
>

> * sb/submodule-update-in-c (2018-07-17) 6 commits
>  - submodule--helper: introduce new update-module-mode helper
>  - builtin/submodule--helper: factor out method to update a single submodule
>  - builtin/submodule--helper: store update_clone information in a struct
>  - builtin/submodule--helper: factor out submodule updating
>  - git-submodule.sh: rename unused variables
>  - git-submodule.sh: align error reporting for update mode to use path
>
>  "git submodule update" is getting rewritten piece-by-piece into C.
>
>  It seems to pass its own self-tests standalone, but seems to break
>  horribly when merged to 'pu'.

It actually breaks combined with sb/submodule-core-worktree  :-(
as that introduces another user of $name in git-submodule.sh
which we eliminate in this series.

I'll build on top of that and send a fixed version.

Sorry about being confused and breaking so much lately,

Stefan
