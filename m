Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ADA21F597
	for <e@80x24.org>; Fri,  3 Aug 2018 00:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbeHCB6u (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 21:58:50 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:37419 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbeHCB6u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 21:58:50 -0400
Received: by mail-yb0-f179.google.com with SMTP id r3-v6so2024273ybo.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 17:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zr4yIeS/5t/3ZD6TVa89x/7KCsyR5K3/BG2KVddxfaU=;
        b=fu1zmMHRTq9ItlGTuPuTgIIMYpksV1n6pj3fc1AyxSNCfBkpp5d2WiirUsQtlXKJwT
         TOI9YH5WkqO4VCMzRUFQkY4u0BVUA6K4dMAebDtQyJARuWTsxCMVHRYky49Pjbqfvmyd
         hW+Hbiw7g6XNcAGtYz6xEyWS5tAocO7tAUZJBUcLLmQsnBZWDkkvqWus3Z83AnxeZFxx
         LCbG+enPyOuL71F9h5qGrEhI7I5OMPDH0vsOFw1L+jMYv2rKUzZlZZjZJ2CJyVWx77m5
         7NqGtCdoCKJxOCdSVhvMVB1pUlfIBH/UtxiK+CjcXlBovhPe50s3kD6IgXCk66loXrIK
         bFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zr4yIeS/5t/3ZD6TVa89x/7KCsyR5K3/BG2KVddxfaU=;
        b=Ooki9rxjCwJrs9G6LS4mpT04UasHO+/v7zVrfjXDxkga/aHZUQ28olG2no9zvJcP4w
         883RN0+RoDLO0bVJJKIBP3hRH4YoohGqf6cxR+5iOE8+A28M5qehpY592JSGT+cGpF+c
         jasowt+pkBL5TFVOQ/dW82bJp2NGiGlB2y/HCMcWgOFDVTvqrvYMZOL+TKZSvqE/Aq3v
         wYg05P0HAQDlcr72lIW/6VIl3Vk0qChcT8vy4bGDwDjEECGwDm5lg8sJoL5h9uNvsPAQ
         Hi5nK7WppJfg3G9ZrI2REkLFCRO1WjTexbyWTMQyOSWZ9kGFLdaQuxY1NYAADlkessxB
         9k0w==
X-Gm-Message-State: AOUpUlHwcyDYY1gG/fdzMHLlo+hhixcp0xSy8vpICAnghwMnh2pSyLsb
        PJlIR8iNJc4ut0VRQJuAg2JcEZKbMCi+ce3m6J1XOw==
X-Google-Smtp-Source: AAOMgpdMYO7zGsJzMt9zQaz6vYVIPOldZVa2UsY1VElUIXd0KtBFSB4AcBsc42UOy3Kc984DnPyvohUw4uokfDGC8QM=
X-Received: by 2002:a25:ea13:: with SMTP id p19-v6mr902112ybd.167.1533254717268;
 Thu, 02 Aug 2018 17:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 2 Aug 2018 17:05:06 -0700
Message-ID: <CAGZ79kZ1R8sxmtfgPOQcpoWM7GWV1qiRaqMq_zhGyKBB3ARLjg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 4:02 PM Junio C Hamano <gitster@pobox.com> wrote:

> * sb/config-write-fix (2018-08-01) 3 commits
>  - git-config: document accidental multi-line setting in deprecated syntax
>  - config: fix case sensitive subsection names on writing
>  - t1300: document current behavior of setting options
>
>  Recent update to "git config" broke updating variable in a
>  subsection, which has been corrected.
>
>  Not quite?
>  cf. <xmqq4lgc1rbv.fsf@gitster-ct.c.googlers.com>

I'd rather point to
https://public-inbox.org/git/xmqqftzx67vo.fsf@gitster-ct.c.googlers.com/
https://public-inbox.org/git/xmqqva8t4s63.fsf@gitster-ct.c.googlers.com/
instead (reason: shoddiness),

as the message you refer to points out *another*
bug, using the old notation, that was there before that
series and still is there after the series.

Personally I do not want to care about the old notation
and by implementing it the way the series is, the
old notation doesn't see any *changes*.

>
> * ds/commit-graph-with-grafts (2018-07-19) 8 commits
>   (merged to 'next' on 2018-08-02 at 0ee624e329)
>  + commit-graph: close_commit_graph before shallow walk
>  + commit-graph: not compatible with uninitialized repo
>  + commit-graph: not compatible with grafts
>  + commit-graph: not compatible with replace objects
>  + test-repository: properly init repo
>  + commit-graph: update design document
>  + refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
>  + refs.c: migrate internal ref iteration to pass thru repository argument
>
>  The recently introduced commit-graph auxiliary data is incompatible
>  with mechanisms such as replace & grafts that "breaks" immutable
>  nature of the object reference relationship.  Disable optimizations
>  based on its use (and updating existing commit-graph) when these
>  incompatible features are in use in the repository.

Makes sense as a whole, but I dislike the first 2 patches
(they were my suggestion) for the refs API. I plan to re send patches
https://public-inbox.org/git/20180730194731.220191-1-sbeller@google.com/
but fixed for real.

(do not let this stop you from merging down this series)

> * sb/histogram-less-memory (2018-07-23) 4 commits
>   (merged to 'next' on 2018-08-02 at cfb02aa3b5)
>  + xdiff/histogram: remove tail recursion
>  + xdiff/xhistogram: move index allocation into find_lcs
>  + xdiff/xhistogram: factor out memory cleanup into free_index()
>  + xdiff/xhistogram: pass arguments directly to fall_back_to_classic_diff
>
>  "git diff --histogram" had a bad memory usage pattern, which has
>  been rearranged to reduce the peak usage.
>

Reminder to self: I need to work on the documentation patches
for diffing, too.

>
> * sb/submodule-update-in-c (2018-07-18) 6 commits
>  - submodule--helper: introduce new update-module-mode helper
>  - builtin/submodule--helper: factor out method to update a single submodule
>  - builtin/submodule--helper: store update_clone information in a struct
>  - builtin/submodule--helper: factor out submodule updating
>  - git-submodule.sh: rename unused variables
>  - git-submodule.sh: align error reporting for update mode to use path
>
>  "git submodule update" is getting rewritten piece-by-piece into C.
>
>  Will merge to 'next'.

Please do not, AFAICT this is still breaking in combination with the
series merged at 7e25437d35a (Merge branch 'sb/submodule-core-worktree',
2018-07-18) and I do not recall fixing the interaction between those two.

Stefan
