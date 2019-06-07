Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E221F462
	for <e@80x24.org>; Fri,  7 Jun 2019 14:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfFGOnd (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 10:43:33 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:45882 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfFGOnd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 10:43:33 -0400
Received: by mail-qk1-f180.google.com with SMTP id s22so1373185qkj.12
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KpXxZubDZ78dgSxi2TWu7/tP1ZUSwTYbHk4m8v3xn7U=;
        b=C33dNeWtrBVfc5cxerXJnYqsgYx2NcR9H2KxKbElMI76b9A7s3FzNiuyG0e+yABrdy
         ouWNc9oaxCtwLs7ZKZ5DgFeOyCDpzKj8m3ybHAXQWh+kvvEdXgI2UW0sKqjLLkkTA6gm
         N8kVio3p0Txq4HXt7jBJAYCqZjRqlThvFvwj/sA0kJZUMKc2D3pXtFez7FMeJFmUuX6V
         DxcD3vMMzKdODF6RpZ3NqB8EWNTTW4xHHIJfAtbekFSyhA9sub/yId/iegvLSNTbkKeX
         drBKr0hG+jmvqsfej0Px2Z7AYjm+BIjSXWd0t/C9JwVzX6no/fOcN0LDMXuTJLo+Qvii
         6bIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KpXxZubDZ78dgSxi2TWu7/tP1ZUSwTYbHk4m8v3xn7U=;
        b=aQt+d9GtBcs/B6iC6ZzhSHT5M1z2OFF+GZnht+rZH50bS4NX/vvCc4WuHk5ArVeTX8
         sCeMPMxaM5L+PkADifsgD6/DFtCts4RYEolDoq/9OOrCFbDDC+2RXqLM4IisU/cWkZ51
         wxKmidrFbvhHMc83TLN14J9ILlZp1WkBH/4GaXF7QdomkuaGfshhY+dwG5rm5eN8DA1d
         NHiqZcOTr0/4wr9uk3gM0jBTt5FrnBd3OF7RCz+KAkqzJldoAJVZu56g4O8szKj80EfA
         oRpWm23w2vfvZjoe8cKWHTaev7vd8gXXr24Kb/8Iz9oOPo/PUsNdWKsH6jQpc+4vbm7f
         ZvQQ==
X-Gm-Message-State: APjAAAXBYjBjwEayjg75gxzThTXG87dmBINOLAmo3yb7ICjDhsayi1fr
        nh6mBJXH8T1NQYzhf+22do2TnfMs
X-Google-Smtp-Source: APXvYqwjgomt2V+uJvB4m2GpSDiNrn+fac5XLBxHpVWS3MkqfxTIrX+JRUJz/yLCWvbxEXwL1AUT9g==
X-Received: by 2002:ae9:ee0b:: with SMTP id i11mr39491682qkg.96.1559918611977;
        Fri, 07 Jun 2019 07:43:31 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4daa:35d6:a381:1849? ([2001:4898:a800:1012:fedd:35d6:a381:1849])
        by smtp.gmail.com with ESMTPSA id s35sm1331593qts.10.2019.06.07.07.43.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 07:43:31 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, June 6 2019)
From:   Derrick Stolee <stolee@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <396091fc-5572-19a5-4f18-61c258590dd5@gmail.com>
Message-ID: <29379827-541e-fe75-f46a-661eb727fc1d@gmail.com>
Date:   Fri, 7 Jun 2019 10:43:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <396091fc-5572-19a5-4f18-61c258590dd5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2019 9:19 PM, Derrick Stolee wrote:
> commit-graph.c
> a53af50b 346) if (!oideq(&oids[n], &cur_g->oid) ||
> a53af50b 347)     !hasheq(oids[n].hash, g->chunk_base_graphs + g->hash_len * n)) {
> a53af50b 348) warning(_("commit-graph chain does not match"));
> a53af50b 349) return 0;

I'm calling myself out that this warning() should be hit by the "verify" checks, as
this is a critical behavior check.

> cd556367 353) cur_g = cur_g->base_graph;

Here is an example of a line where I definitely hit this block when I add a die()
statement.

I think I figured out the reason the coverage report was reporting coverage
incorrectly sometimes: I was accidentally running the test suite in parallel.
This causes lots of issues with how gcov tracks coverage as there are lots of
race conditions. Running without parallelism takes a LOT longer, so I'll need
to use my own machine instead of a hosted build.

> cd556367 396) warning(_("invalid commit-graph chain: line '%s' not a hash"),

I'm lukewarm on how important it is to test this, but I'll give it a try.

> 4ece4fc1 945) if (find_commit_in_graph(parent->item,
> 4ece4fc1 948) edge_value = pos;

This case is triggered by an octopus merge with a not-first parent being
in the base graph instead of in the tip file. I'll add a test that covers
this situation, as it could be prone to errors.

> 00a8cb54 1523)     (max_commits && num_commits > max_commits))) {

This is a reminder that I forgot to add tests for the '--max-commits' argument.

> c6b73769 1540) ctx->num_commit_graphs_after = 1;
> c6b73769 1541) ctx->new_base_graph = NULL;

This is another subtle case that I should test: we are writing a commit-graph
with the --split option and we think we should write a tip graph, but the
current file is the old (non-split) commit-graph file _and_ it is in an alternate.
This prevents us from trying to move the commit-graph in the alternate, and we
must write a single commit-graph file in our object directory.

> 0e2ec504 1617) duplicates++;
> 0e2ec504 1620) ctx->commits.list[last_distinct + 1] = ctx->commits.list[i];
> 0e2ec504 1628) ctx->num_extra_edges += num_parents - 2;

This code in deduplicate_commits() is doing somewhat important work: it takes
the combined commit lists from multiple levels of the commit-graph and then
de-duplicates the lists. However, if we are writing the commit-graphs properly
then they will never have duplicates at this point. I don't think it is valid
to have duplicates, either, as then a commit will have ambiguous graph position.

Perhaps deduplicate_commits() should remove the duplicate logic and replace it
with a BUG() or die() statement upon finding a duplicate. The sorting and
checking for octopus merges is still important.

Thanks,
-Stolee
