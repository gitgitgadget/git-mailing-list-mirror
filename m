Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1549A2023D
	for <e@80x24.org>; Fri, 19 May 2017 18:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756326AbdESSaf (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 14:30:35 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33364 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbdESS3I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 14:29:08 -0400
Received: by mail-qk0-f196.google.com with SMTP id o85so11229445qkh.0
        for <git@vger.kernel.org>; Fri, 19 May 2017 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bCHpl9T4ZvvATJQFHfvzxmkfETIgZh5tVrQkz2KKL88=;
        b=aW7I4lGMbUZnUFfjAGhR/6vU/pbBvxILjSm0MVyOg2uCEEP2Kyojc4oYPg2hpdPkqf
         RpX/HACdaWyUnOcRv/s0UyhQl9qS5+A+9cvQ8a9dRPqKN+TCoBDzUX5+RekwPmTlcSeO
         98P6A2puPClXz6WodNRHKkhFMbspbb0gVcuhXDw67jI5Ittu289fwWEHYPvSGUsY40NV
         yWDg3yH/Pw5sF+P/s2dMsdQ63XmZfR/7nbB+7LGKVx9LhUgfPLCod7btptlMRB6syurO
         pnTnPzYugo66tLh0gydpCy3zg4EQeGTg0Ps3jS8A6Nf/afh4Il33ZNnO/yvoBTyeWuMr
         iFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bCHpl9T4ZvvATJQFHfvzxmkfETIgZh5tVrQkz2KKL88=;
        b=lYaHdfcl8k+aPXMeBFYiNZ4ZfW5IagEIFWqAQ8d6nvYwqe0CA1sYPXD4UeEn/9FvqS
         0DjtxbZ9RgmmM1QH9NZAdj6FR3cEV7hf8F6HXWyrNemsExbNcxedvc3tvE0lWQii9tUR
         DM6lt1+Wd01mcTnGwupgAL5IqiNcsxTW7SIGvELiwH4H7Sd3ZR1AYmaMAGMXPJEK/nOs
         v6/Xuw9uS52OouMRDWW9KMRSk5g/+d+QqrcqaThVt6tdWaQTEzSuthtHbzQkFtLOXnU9
         m7XeoWhTjO034cRKzYe9YMOV/m1PTAWCyyqQp+GmKvA8+v9r6+XtL2KMHAfAsPMe/34+
         ZdwA==
X-Gm-Message-State: AODbwcCu6VCac3bIl2UBxdrO3xAwQW1FlqsvNPVXwZEXWxvjpEdAYQBi
        03CVQ64Qy6XgAQ==
X-Received: by 10.55.105.2 with SMTP id e2mr9531127qkc.48.1495218532307;
        Fri, 19 May 2017 11:28:52 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 27sm4490283qtz.17.2017.05.19.11.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 May 2017 11:28:51 -0700 (PDT)
Subject: Re: [WIP/RFC 00/23] repository object
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <20170518232134.163059-1-bmwill@google.com>
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com
From:   Ben Peart <peartben@gmail.com>
Message-ID: <82cb1f56-4a26-4b27-3c8a-506821847c0e@gmail.com>
Date:   Fri, 19 May 2017 14:28:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glad to see you tackling this.  This is definitely a step in the right 
direction.

I realize that it will take a lot of work and that intermediate steps 
may just be pushing it the global state one level higher but eventually 
it would be great to see an entire code path global state free!

I'm personally interested because reducing the reliance on global state 
also helps us in our performance work as it makes it more possible to 
use threading to scale up the performance.

Ben

On 5/18/2017 7:21 PM, Brandon Williams wrote:
> When I first started working on the git project I found it very difficult to
> understand parts of the code base because of the inherently global nature of
> our code.  It also made working on submodules very difficult.  Since we can
> only open up a single repository per process, you need to launch a child
> process in order to process a submodule.  But you also need to be able to
> communicate other stateful information to the children processes so that the
> submodules know how best to format their output or match against a
> pathspec...it ends up feeling like layering on hack after hack.  What I would
> really like to do, is to have the ability to have a repository object so that I
> can open a submodule in-process.
>
> Before this becomes a reality for all commands, much of the library code would
> need to be refactored in order to work purely on handles instead of global
> state.  As it turned out, ls-files is a pretty simple command and doesn't have
> *too* many dependencies.  The biggest thing that needed to be changed was
> piping through an index into a couple library routines so that they don't
> inherently rely on 'the_index'.  A few of these changes I've sent out and can
> be found at 'origin/bw/pathspec-sans-the-index' and
> 'origin/bw/dir-c-stops-relying-on-the-index' which this series is based on.
>
> Patches 1-16 are refactorings to prepare either library code or ls-files itself
> to be ready to handle passing around an index struct.  Patches 17-22 introduce
> a repository struct and change a couple of things about how submodule caches
> work (getting submodule information from .gitmodules).  And Patch 23 converts
> ls-files to use a repository struct.
>
> The most interesting part of the series is from 17-23.  And 1-16 could be taken
> as is without the rest of the series.
>
> This is still very much in a WIP state, though it does pass all tests.  What
> I'm hoping for here is to get a discussion started about the feasibility of a
> change like this and hopefully to get the ball rolling.  Is this a direction we
> want to move in?  Is it worth the pain?
>
> Thanks for taking the time to look at this and entertain my insane ideas :)
>
> Brandon Williams (23):
>   convert: convert get_cached_convert_stats_ascii to take an index
>   convert: convert crlf_to_git to take an index
>   convert: convert convert_to_git_filter_fd to take an index
>   convert: convert convert_to_git to take an index
>   convert: convert renormalize_buffer to take an index
>   tree: convert read_tree to take an index parameter
>   ls-files: convert overlay_tree_on_cache to take an index
>   ls-files: convert write_eolinfo to take an index
>   ls-files: convert show_killed_files to take an index
>   ls-files: convert show_other_files to take an index
>   ls-files: convert show_ru_info to take an index
>   ls-files: convert ce_excluded to take an index
>   ls-files: convert prune_cache to take an index
>   ls-files: convert show_files to take an index
>   ls-files: factor out debug info into a function
>   ls-files: factor out tag calculation
>   repo: introduce new repository object
>   repo: add index_state to struct repo
>   repo: add per repo config
>   submodule-config: refactor to allow for multiple submodule_cache's
>   repo: add repo_read_gitmodules
>   submodule: add is_submodule_active
>   ls-files: use repository object
>
>  Makefile                               |   1 +
>  apply.c                                |   2 +-
>  builtin/blame.c                        |   2 +-
>  builtin/commit.c                       |   3 +-
>  builtin/ls-files.c                     | 348 ++++++++++++++++-----------------
>  cache.h                                |   4 +-
>  combine-diff.c                         |   2 +-
>  config.c                               |   2 +-
>  convert.c                              |  31 +--
>  convert.h                              |  19 +-
>  diff.c                                 |   6 +-
>  dir.c                                  |   2 +-
>  git.c                                  |   2 +-
>  ll-merge.c                             |   2 +-
>  merge-recursive.c                      |   4 +-
>  repo.c                                 | 112 +++++++++++
>  repo.h                                 |  22 +++
>  sha1_file.c                            |   6 +-
>  submodule-config.c                     |  40 +++-
>  submodule-config.h                     |  10 +
>  submodule.c                            |  51 +++++
>  submodule.h                            |   2 +
>  t/t3007-ls-files-recurse-submodules.sh |  39 ++++
>  tree.c                                 |  28 ++-
>  tree.h                                 |   3 +-
>  25 files changed, 513 insertions(+), 230 deletions(-)
>  create mode 100644 repo.c
>  create mode 100644 repo.h
>
