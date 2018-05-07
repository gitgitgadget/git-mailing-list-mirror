Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE30200B9
	for <e@80x24.org>; Mon,  7 May 2018 15:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752233AbeEGPUO (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 11:20:14 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:39413 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbeEGPUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 11:20:12 -0400
Received: by mail-qk0-f176.google.com with SMTP id z75so22142395qkb.6
        for <git@vger.kernel.org>; Mon, 07 May 2018 08:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=NkIPGaa4MXgsyLHdl3c3P2CywS4NojKasNe3VYKwk+I=;
        b=K+jQt7OyQ4vVgSOJ1Db8wzHP3jMuBevFnJysH2X1SnL2tsBONFmUssaJFcy8FVI8P7
         WFwyF6v3X4P5wSLZgEjRkH4Zeb70nP4iohOlwb/nzvWj+P7Nj4bDNPRgNxWyDXhQxcbS
         XKOYKoorDei5H1RBXNxQhAVSIpTRKtFDmAqW1m4fHbEDME3/0ERLre4w6dmAj+0Umofp
         VLENvZZcJQ7fP/02McdTiZObnnu43UOGCjIcghs9rmC50FUIcItsgLkDfFED/bL+LcMX
         4H1tNBBKNOu92ooaDLhl+kDl6VJ3E+MprUC8dfxiAAlO5Lfh02NCJgD4xspCC289Olr/
         c1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NkIPGaa4MXgsyLHdl3c3P2CywS4NojKasNe3VYKwk+I=;
        b=BILCQrMXRSPbFo9irURgCgOlerjm6pG5T8TXAXX9lwGBO+gzmoP8E9ble85p774ZVN
         3kBPmclAb5MBwnlU0EDPJhqj5Hr2MCk5bs9g1RrTlBBqdvHhHBHaaKeDQlHAWmTIRgtP
         MQDm0wyPfhiQ/kvuALaaSA5iHrAAdx7dZQR7FVdT7GBhuhwN5pQduvaN4/lJvXIFgBiL
         l3d2kO8BIwJsAXpvpsCPct8uzmbOiS13Q/0966BtzaL10TpeWtqiYr7aczxP/J10ivsi
         VTnW10GwEbSOmFDv+SeTxWH31UUjbiysav/0PHThxn2OnUoFZfM4Ga/naDkmO04SrkeH
         GLuQ==
X-Gm-Message-State: ALQs6tBK9UyMgjU2pGGfWNVyo6xhkOJcgckEw/SoKxwDnM3/jzlP3yCr
        nV8d0JQGBfhC/9SmtQ1JPeE=
X-Google-Smtp-Source: AB8JxZoE4UJ9Dcg02Q1DEm+RUnD+RJwir/1JNZNVu9P7PwOehIZnvPZHwbB98C0J3b2eEOVOJEUqNw==
X-Received: by 10.55.11.146 with SMTP id 140mr31282776qkl.359.1525706411486;
        Mon, 07 May 2018 08:20:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id m27-v6sm18247547qtg.75.2018.05.07.08.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 08:20:10 -0700 (PDT)
Subject: Re: What's cooking in git.git (May 2018, #01; Mon, 7)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jakub Narebski <jnareb@gmail.com>
References: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1bb666a1-ce44-3eb0-e63c-a6a9e2a675dd@gmail.com>
Date:   Mon, 7 May 2018 11:20:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7tbpl5q.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/7/2018 10:58 AM, Junio C Hamano wrote:
> * ds/generation-numbers (2018-05-02) 11 commits
>   - commit-graph.txt: update design document
>   - merge: check config before loading commits
>   - commit: use generation number in remove_redundant()
>   - commit: add short-circuit to paint_down_to_common()
>   - commit: use generation numbers for in_merge_bases()
>   - ref-filter: use generation number for --contains
>   - commit-graph: always load commit-graph information
>   - commit: use generations in paint_down_to_common()
>   - commit-graph: compute generation numbers
>   - commit: add generation number to struct commmit
>   - ref-filter: fix outdated comment on in_commit_list
>   (this branch uses ds/commit-graph and ds/lazy-load-trees.)
>
>   A recently added "commit-graph" datafile has learned to store
>   pre-computed generation numbers to speed up the decisions to stop
>   history traversal.
>
>   Is this ready for 'next'?

I see that you squashed the fix from [1], so I think this is ready to 
go. Thanks!

[1] 
https://public-inbox.org/git/1cfe38f6-925b-d36b-53ae-6b586eed199c@gmail.com/

> * ds/lazy-load-trees (2018-05-02) 6 commits
>    (merged to 'next' on 2018-05-02 at d54016d9e3)
>   + coccinelle: avoid wrong transformation suggestions from commit.cocci
>    (merged to 'next' on 2018-04-25 at b90813f421)
>   + commit-graph: lazy-load trees for commits
>   + treewide: replace maybe_tree with accessor methods
>   + commit: create get_commit_tree() method
>   + treewide: rename tree to maybe_tree
>   + Merge branch 'bw/c-plus-plus' into ds/lazy-load-trees
>   (this branch is used by ds/generation-numbers; uses ds/commit-graph.)
>
>   The code has been taught to use the duplicated information stored
>   in the commit-graph file to learn the tree object name for a commit
>   to avoid opening and parsing the commit object when it makes sense
>   to do so.
>
>   Will merge to 'master'.
>
>
> * ds/commit-graph (2018-04-11) 16 commits
>    (merged to 'next' on 2018-04-25 at 18af3d28d9)
>   + commit-graph: implement "--append" option
>   + commit-graph: build graph from starting commits
>   + commit-graph: read only from specific pack-indexes
>   + commit: integrate commit graph with commit parsing
>   + commit-graph: close under reachability
>   + commit-graph: add core.commitGraph setting
>   + commit-graph: implement git commit-graph read
>   + commit-graph: implement git-commit-graph write
>   + commit-graph: implement write_commit_graph()
>   + commit-graph: create git-commit-graph builtin
>   + graph: add commit graph design document
>   + commit-graph: add format document
>   + csum-file: refactor finalize_hashfile() method
>   + csum-file: rename hashclose() to finalize_hashfile()
>   + Merge branch 'jk/cached-commit-buffer' into HEAD
>   + Merge branch 'jt/binsearch-with-fanout' into HEAD
>   (this branch is used by ds/generation-numbers and ds/lazy-load-trees.)
>
>   Precompute and store information necessary for ancestry traversal
>   in a separate file to optimize graph walking.
>
>   Will merge to 'master'.

These have been queued for master for a few weeks. Is anything delaying 
them? I'd love to see the community dogfood this feature by running the 
following on their local repos:

     git config core.commitGraph true
     git show-ref -s | git commit-graph write --stdin-commits

Thanks,
-Stolee
