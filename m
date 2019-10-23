Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010FD1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 15:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392408AbfJWPEJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 11:04:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35517 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390431AbfJWPEI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 11:04:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so22079401wrb.2
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 08:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=n1NlXqGalmEOzL/e28YFBwW9ppJJlxE7tHN4/hrxuVc=;
        b=AJ/lrBwBE1FbnnkXTx2Zbhufn1CmdNnM0HaRyXntaim4xIsW0lgNjZejbk8jPJs+Xv
         0pEJBQHaNLeESw9IJb6lfC8rheFhotFdu/3DEUjtz1gjpQvtmYkXg87q26BbDlWE37CL
         ebrf4IaaynTDJTcle74NqRQIn3OXedL+E7khL0tGrE8xOaIcO01snrMKmETnak2vGivW
         h+TZvqriXJ39pgopIihjwOJY18Tg+7519MmcQQ5dOrGocp/shGPwQr9sTCWY68hwN8pF
         Dd4p+XPX9kJA8cP6DCqT53TYlHhlePnlzw+NcRYUHvY+OWuYZ3fJ1X4Gc8E/hu4Tv3ux
         wDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=n1NlXqGalmEOzL/e28YFBwW9ppJJlxE7tHN4/hrxuVc=;
        b=lWCWJBfFYiZxVgYneVVYm6wL9nhjJ98mE3iL4bOTcKBGwvmpOn64p588cVVVwwvIpi
         En5wTlHr8F+bWkbTZEGu3Aj0vpXdBnxOup2U0WkYOqGo7wXpKPdMG0O3UEYwPJ+ZZoCb
         hrZsDTIu4eYU30fdAdYqwtTILA6S+kQ5hqflFcFRA2qWeFQ6+pIOzYaSx2SdFQKlTzQq
         vSJT7JIXrJk4acG3k3jR7rpKbmxAltkjeJAGmJ0Brq7/Td0lmM5RLPJ8wW/0BqxSBIQ0
         aIJziEzZ4mjC8borvBWerWgn2ZecB7z09jsfYOiwU/UvVOltGVp2Hw4mMh9MWNWmUUzl
         EKJw==
X-Gm-Message-State: APjAAAViG2GgT4JcWHcK5AuhcNXDv14r0a6rwdFWjUh1sv4NKZSOLXqx
        Wiu60XB+o6s2I/9p5tvQi9w=
X-Google-Smtp-Source: APXvYqwQhxBRiW+kRL4+dZa4lZyU9DzmVgj2BHlLHczQ5BQe1C2mgrcOA8bkBvoiadF44++KJZF7rQ==
X-Received: by 2002:adf:dc11:: with SMTP id t17mr1785424wri.163.1571843045037;
        Wed, 23 Oct 2019 08:04:05 -0700 (PDT)
Received: from szeder.dev (x4db97b71.dyn.telefonica.de. [77.185.123.113])
        by smtp.gmail.com with ESMTPSA id r13sm33792373wra.74.2019.10.23.08.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 08:04:04 -0700 (PDT)
Date:   Wed, 23 Oct 2019 17:04:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] commit-graph: fix writing first commit-graph
 during fetch
Message-ID: <20191023150402.GB26017@szeder.dev>
References: <pull.415.git.1571765335.gitgitgadget@gmail.com>
 <pull.415.v2.git.1571835695.gitgitgadget@gmail.com>
 <ca59b118f1fa4176214f55b8993145b5e1db39a0.1571835695.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca59b118f1fa4176214f55b8993145b5e1db39a0.1571835695.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 23, 2019 at 01:01:35PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The previous commit includes a failing test for an issue around
> fetch.writeCommitGraph and fetching in a repo with a submodule. Here, we
> fix that bug and set the test to "test_expect_success".
> 
> The prolem arises with this set of commands when the remote repo at

s/prolem/problem/

> <url> has a submodule. Note that --recurse-submodules is not needed to
> demonstrate the bug.
> 
> 	$ git clone <url> test
> 	$ cd test
> 	$ git -c fetch.writeCommitGraph=true fetch origin
> 	Computing commit graph generation numbers: 100% (12/12), done.
> 	BUG: commit-graph.c:886: missing parent <hash1> for commit <hash2>
> 	Aborted (core dumped)
> 
> As an initial fix, I converted the code in builtin/fetch.c that calls
> write_commit_graph_reachable() to instead launch a "git commit-graph
> write --reachable --split" process. That code worked, but is not how we
> want the feature to work long-term.
> 
> That test did demonstrate that the issue must be something to do with
> internal state of the 'git fetch' process.
> 
> The write_commit_graph() method in commit-graph.c ensures the commits we
> plan to write are "closed under reachability" using close_reachable().
> This method walks from the input commits, and uses the UNINTERESTING
> flag to mark which commits have already been visited. This allows the
> walk to take O(N) time, where N is the number of commits, instead of
> O(P) time, where P is the number of paths. (The number of paths can be
> exponential in the number of commits.)
> 
> However, the UNINTERESTING flag is used in lots of places in the
> codebase. This flag usually means some barrier to stop a commit walk,
> such as in revision-walking to compare histories. It is not often
> cleared after the walk completes because the starting points of those
> walks do not have the UNINTERESTING flag, and clear_commit_marks() would
> stop immediately.
> 
> This is happening during a 'git fetch' call with a remote. The fetch
> negotiation is comparing the remote refs with the local refs and marking
> some commits as UNINTERESTING.
> 
> You may ask: did this feature ever work at all? Yes, it did, as long as
> you had a commit-graph covering all of your local refs. My testing was
> unfortunately limited to this scenario. The UNINTERESTING commits are
> always part of the "old" commit-graph, and when we add new commits to a
> top layer of the commit-graph chain those are not needed. If we happen
> to merge layers of the chain, then the commits are added as a list, not
> using a commit walk. Further, the test added for this config option in
> t5510-fetch.sh uses local filesystem clones, which somehow avoids this
> logic.

Does this last sentence still holds, given that a submodule plays a
crucial role in triggering this bug?  I think it either doesn't, or
I still don't completely understand the situation.

> I tested running clear_commit_marks_many() to clear the UNINTERESTING
> flag inside close_reachable(), but the tips did not have the flag, so
> that did nothing.
> 
> It turns out that the calculate_changed_submodule_paths() method is at
> fault. Thanks, Peff, for pointing out this detail! More specifically,
> for each submodule, the collect_changed_submodules() runs a revision
> walk to essentially do file-history on the list of submodules. That
> revision walk marks commits UNININTERESTING if they are simiplified away

s/simiplified/simplified/

> by not changing the submodule.
> 
> Instead, I finally arrived on the conclusion that I should use a flag
> that is not used in any other part of the code. In commit-reach.c, a
> number of flags were defined for commit walk algorithms. The REACHABLE
> flag seemed like it made the most sense, and it seems it was not
> actually used in the file. The REACHABLE flag was used in early versions
> of commit-reach.c, but was removed by 4fbcca4 (commit-reach: make
> can_all_from_reach... linear, 2018-07-20).
> 
> Add the REACHABLE flag to commit-graph.c and use it instead of
> UNINTERESTING in close_reachable(). This fixes the bug in manual
> testing.

I'm inclined to agree that using a flag that is not used anywhere else
is the safest thing to do, and at -rcX time safest is good.  I'm not
sure whether it's the right thing to do in the long term, though.

Furthermore, calling this flag REACHABLE is misleading, because the
code actually means SEEN.
Consider the following sequence of commands:

  # Create a pack with two commits
  $ git commit --allow-empty -m one &&
  $ git commit --allow-empty -m two &&
  $ git repack -ad &&
  # Make one of those commits unreachable
  $ git reset --hard HEAD^ &&
  # Not even from reflogs!
  $ git reflog expire --expire-unreachable=now --all
  # Now write a commit-graph from that pack file
  $ git commit-graph write
  Computing commit graph generation numbers: 100% (2/2), done.

It added two commits to the commit-graph, although one of them is
clearly not reachable anymore, so marking it as REACHABLE while
enumerating all commits feels wrong.

> Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Szeder Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c   | 11 +++++++----
>  commit-reach.c   |  1 -
>  object.h         |  3 ++-
>  t/t5510-fetch.sh |  2 +-
>  4 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index fc4a43b8d6..0aea7b2ae5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -41,6 +41,9 @@
>  #define GRAPH_MIN_SIZE (GRAPH_HEADER_SIZE + 4 * GRAPH_CHUNKLOOKUP_WIDTH \
>  			+ GRAPH_FANOUT_SIZE + the_hash_algo->rawsz)
>  
> +/* Remember to update object flag allocation in object.h */
> +#define REACHABLE       (1u<<15)
> +
>  char *get_commit_graph_filename(const char *obj_dir)
>  {
>  	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
> @@ -1030,11 +1033,11 @@ static void add_missing_parents(struct write_commit_graph_context *ctx, struct c
>  {
>  	struct commit_list *parent;
>  	for (parent = commit->parents; parent; parent = parent->next) {
> -		if (!(parent->item->object.flags & UNINTERESTING)) {
> +		if (!(parent->item->object.flags & REACHABLE)) {
>  			ALLOC_GROW(ctx->oids.list, ctx->oids.nr + 1, ctx->oids.alloc);
>  			oidcpy(&ctx->oids.list[ctx->oids.nr], &(parent->item->object.oid));
>  			ctx->oids.nr++;
> -			parent->item->object.flags |= UNINTERESTING;
> +			parent->item->object.flags |= REACHABLE;
>  		}
>  	}
>  }
> @@ -1052,7 +1055,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
>  		display_progress(ctx->progress, i + 1);
>  		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
>  		if (commit)
> -			commit->object.flags |= UNINTERESTING;
> +			commit->object.flags |= REACHABLE;
>  	}
>  	stop_progress(&ctx->progress);
>  
> @@ -1089,7 +1092,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
>  		commit = lookup_commit(ctx->r, &ctx->oids.list[i]);
>  
>  		if (commit)
> -			commit->object.flags &= ~UNINTERESTING;
> +			commit->object.flags &= ~REACHABLE;
>  	}
>  	stop_progress(&ctx->progress);
>  }
> diff --git a/commit-reach.c b/commit-reach.c
> index 3ea174788a..4ca7e706a1 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -10,7 +10,6 @@
>  #include "commit-reach.h"
>  
>  /* Remember to update object flag allocation in object.h */
> -#define REACHABLE       (1u<<15)
>  #define PARENT1		(1u<<16)
>  #define PARENT2		(1u<<17)
>  #define STALE		(1u<<18)
> diff --git a/object.h b/object.h
> index 0120892bbd..25f5ab3d54 100644
> --- a/object.h
> +++ b/object.h
> @@ -68,7 +68,8 @@ struct object_array {
>   * bisect.c:                                        16
>   * bundle.c:                                        16
>   * http-push.c:                                     16-----19
> - * commit-reach.c:                                15-------19
> + * commit-graph.c:                                15
> + * commit-reach.c:                                  16-----19
>   * sha1-name.c:                                              20
>   * list-objects-filter.c:                                      21
>   * builtin/fsck.c:           0--3
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index e8ae3af0b6..7bfbcc2036 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -583,7 +583,7 @@ test_expect_success 'fetch.writeCommitGraph' '
>  	)
>  '
>  
> -test_expect_failure 'fetch.writeCommitGraph with submodules' '
> +test_expect_success 'fetch.writeCommitGraph with submodules' '
>  	pwd="$(pwd)" &&
>  	git clone dups super &&
>  	(
> -- 
> gitgitgadget
