Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2111F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeGPX35 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:29:57 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:52606 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbeGPX35 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:29:57 -0400
Received: by mail-it0-f74.google.com with SMTP id q77-v6so14659257itc.2
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=RJ6+ddABkpNIaB0l7uPBLv/Y7GEgrPfNXOfXREIk/9Y=;
        b=f1bdf6NwnIxt2DkWRMQpmf/AZalgOT2AvZ5i3YzCTKINRxBP19iz4BYlZFNe0Qpxjy
         jm2GX2I/wvQs17ywv+XpQsT3kTGheAScZnDI4nHb6fN8d7Kr2z/vhClmup9A2HPl+qUK
         66OhJhLD23ERXZnoBsj0WaRHaRlHGkyinG6hdL3fwC5LBo68SH56Xi5RFV/Y9+HegrQf
         /MjvEWGkiCWkXTbM+n/rTjUqTgJQNJYiKS+7gSf/sJF9hLeNAZKiQr0Cndvk9My/AApa
         ILe28vOwKPnBTbDvRtAcQ7Qluuw7zKgwAPBHnKmDxmfnCdna2/mDuJBG81CG6dzO1oLV
         muhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=RJ6+ddABkpNIaB0l7uPBLv/Y7GEgrPfNXOfXREIk/9Y=;
        b=cyCaj9bXZ+MP/Lk+qvGXe6FK3rD9bpZVwTYxOULw29Uu9gckCPZiFJDPk/NEcyBUUm
         GAhSkgMRt7Qmdj/fKg1thXhEy7rTb3bBrfQ9XUr44TpuWbHfpGhIOiXV1m+rvDOhXjPC
         sfko8bl118UbSKmVC0yiPb4MoOuQWA2nZz8QtEX6WtSn6Sjy5X9xJqxi4bPnxiUfFzKK
         5xRC1C60utw73deDPgsgAESvWkV8dWqhCRmSnYui2Dp3cQnXtWIvyGqRa+Z+CF4dIjEY
         8c+bMHJRRsFP1KWiLERBV8bmF1+cz9Xfr1Y+BjWqxKe4nX7Vlp+PQtdFyOO/gAUdqHEm
         EIPw==
X-Gm-Message-State: AOUpUlEWn7ZhlybKMw5qpdzB8Fc94DXToovwAaxebCbixtycnpc8h951
        N+GG/kyPaxmogaeAWqdScWT5SnDnymrmVPJ5NKi+
X-Google-Smtp-Source: AAOMgpdHiPNpeO6AEe3TxmVJHMbNFwcJYEfDlc7TVOBVTSWgFDt4AqGuIaZ1ojJvVGqhsVerEKI1xTalheTv1xbRrmiO
MIME-Version: 1.0
X-Received: by 2002:a24:4a:: with SMTP id 71-v6mr7540628ita.8.1531782022477;
 Mon, 16 Jul 2018 16:00:22 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:00:19 -0700
In-Reply-To: <6acc5e804ea7beabc7c813e4c1c067915a16087b.1531746011.git.gitgitgadget@gmail.com>
Message-Id: <20180716230019.257742-1-jonathantanmy@google.com>
References: <6acc5e804ea7beabc7c813e4c1c067915a16087b.1531746011.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.18.0.13.g5a7731b13
Subject: Re: [PATCH 08/16] test-reach: create new test tool for ref_newer
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> To use the new test-tool, use 'test-tool reach <method>' and provide
> input to stdin that describes the inputs to the method. Currently, we
> only implement the ref_newer method, which requires two commits. Use
> lines "A:<committish>" and "B:<committish>" for the two inputs. We will
> expand this input later to accommodate methods that take lists of
> commits.

It would be nice if "A" and "B" were "ancestor" and "descendant" (or
something like that) instead, so that I don't have to check which
direction the reach is calculated in.

> +int cmd__reach(int ac, const char **av)
> +{
> +	struct object_id oid_A, oid_B;
> +	struct strbuf buf = STRBUF_INIT;
> +	struct repository *r = the_repository;
> +
> +	setup_git_directory();
> +
> +	if (ac < 2)
> +		exit(1);
> +
> +
> +	while (strbuf_getline(&buf, stdin) != EOF) {
> +		struct object_id oid;
> +		struct object *o;
> +		struct commit *c;
> +		if (buf.len < 3)
> +			continue;
> +
> +		if (get_oid_committish(buf.buf + 2, &oid))
> +			die("failed to resolve %s", buf.buf + 2);

You can also use skip_prefix() instead of using arithmetic to determine
the start of the OID.

> +# Construct a grid-like commit graph with points (x,y)
> +# with 1 <= x <= 10, 1 <= y <= 10, where (x,y) has
> +# parents (x-1, y) and (x, y-1), keeping in mind that
> +# we drop a parent if a coordinate is nonpositive.
> +#
> +#             (10,10)
> +#            /       \
> +#         (10,9)    (9,10)
> +#        /     \   /      \
> +#    (10,8)    (9,9)      (8,10)
> +#   /     \    /   \      /    \
> +#         ( continued...)
> +#   \     /    \   /      \    /
> +#    (3,1)     (2,2)      (1,3)
> +#        \     /    \     /
> +#         (2,1)      (2,1)
> +#              \    /
> +#              (1,1)

This is quite a good design, thanks.

> +# We use branch 'comit-x-y' to refer to (x,y).

s/comit/commit/

> +	git show-ref -s commit-7-7 | git commit-graph write --stdin-commits &&
> +	mv .git/objects/info/commit-graph commit-graph-half &&

My understanding is that this writes for 7-7 and all its ancestors,
but...

> +test_expect_success 'ref_newer:hit' '
> +	cat >input <<-\EOF &&
> +		A:commit-5-7
> +		B:commit-2-3
> +	EOF
> +	printf "ref_newer:1\n" >expect &&
> +	test_three_modes ref_newer
> +'
> +
> +test_done

...both 5-7 and 2-3 are ancestors of 7-7, right? Which means that you
don't test the "half" commit graph here. (It's probably sufficient to
just adjust the numbers.)
