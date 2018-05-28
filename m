Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A1BA1F42D
	for <e@80x24.org>; Mon, 28 May 2018 14:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162442AbeE1OHb (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 10:07:31 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36408 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162533AbeE1OF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 10:05:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id f16-v6so5154538wrm.3
        for <git@vger.kernel.org>; Mon, 28 May 2018 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5LKv7EIT6aec8RSfK93iWa4LHGtUweZTqm1RL2gVir8=;
        b=jh/I1GkGOBDyDc672uKSyDIQpGcXWMIURaYyAg2e2RN19GfDHNuoixqoci9Ep2WhIa
         DJhiP8Qb2XKxIbW9nmXGVueS2bkIejVV/6nugX+jLHxYcTsm5OB4TgW5MqoDkXcx8ve4
         ts1TTw+PnK4wqudo9Jx1eS2qqtwrERzYtZopXsZ/gVUsKkhQrP1htIG5FRGKaN893zo5
         H8aD+oN8oA1sagSLbOHU2c7V9RSACHdb0109WG9W4eHwHgfheVm/BWi82Nw9m/qxD6km
         r9Ug8yWQxORiy+DIEXdWNzj8Lh0pUCZg0WHDVfi9L4USMvMryCDd03GFfs+Of3XRqGQc
         i7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=5LKv7EIT6aec8RSfK93iWa4LHGtUweZTqm1RL2gVir8=;
        b=UUdNhfKRprGRX3fexf77hl144Oqaeh02cJziJcy2Cy33krMUUK0H+/hKiI6u2mIQpf
         p1d/fwqDxbXBn6Px8p7/UfhoRdEyOg0JhfJB4prbDGdLY53hRgD0uNadqb8kjV6tnMbo
         dVI3CIMgDkZDWkagat8XIELXhav33vH//TwG0SwATRFZozpu2+sIbGWWrvKffBDJD7sC
         Wm1syha+rI1COS4xWJK220HnBxCarvuB04uefmfxl6UO/VEXNTn+4h9NJ3kEJEL/1gXX
         /WWcqvMh7XyXV6sQnEwtpn77/WTkRmmxqMzSWBbWKZSarKhRM7TXFlPRa8wYGEMvym5Y
         0Myw==
X-Gm-Message-State: ALKqPwcG3G4G/TwlGqH1pfPvGmYgU1946Mk9CsN5/Q9kMzR634W1nJlU
        KBdbKzPLOIrxDHt7UAEpRmQ=
X-Google-Smtp-Source: AB8JxZpf3doab7SrPLWf0Bk3aKrcsaCVCBH5UA4GV8lxQWdBq4p5mAo1CnsHY6LMvONPHqvhAgO+tQ==
X-Received: by 2002:adf:e6d0:: with SMTP id y16-v6mr12100428wrm.35.1527516325998;
        Mon, 28 May 2018 07:05:25 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egb161.neoplus.adsl.tpnet.pl. [83.21.65.161])
        by smtp.gmail.com with ESMTPSA id e133-v6sm15507872wma.38.2018.05.28.07.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 07:05:25 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 07/20] commit-graph: verify catches corrupt signature
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-8-dstolee@microsoft.com>
Date:   Mon, 28 May 2018 16:05:23 +0200
In-Reply-To: <20180524162504.158394-8-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 24 May 2018 16:25:40 +0000")
Message-ID: <86muwjyixo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> This is the first of several commits that add a test to check that
> 'git commit-graph verify' catches corruption in the commit-graph
> file. The first test checks that the command catches an error in
> the file signature. This is a check that exists in the existing
> commit-graph reading code.

Good start.

This handles 3 out of 5 checks in load_commit_graph_one().  The
remaining are:
* too short file (length smaller than minimal commit-graph size)
* more than one chunk of one of 4 defined types

> Add a helper method 'corrupt_graph_and_verify' to the test script
> t5318-commit-graph.sh. This helper corrupts the commit-graph file
> at a certain location, runs 'git commit-graph verify', and reports
> the output to the 'err' file. This data is filtered to remove the
> lines added by 'test_must_fail' when the test is run verbosely.
> Then, the output is checked to contain a specific error message.

Thanks for an explanation.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t5318-commit-graph.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 6ca451dfd2..bd64481c7a 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -235,9 +235,52 @@ test_expect_success 'perform fast-forward merge in full repo' '
>  	test_cmp expect output
>  '
>  
> +# the verify tests below expect the commit-graph to contain
> +# exactly the commits reachable from the commits/8 branch.
> +# If the file changes the set of commits in the list, then the
> +# offsets into the binary file will result in different edits
> +# and the tests will likely break.
> +
>  test_expect_success 'git commit-graph verify' '
>  	cd "$TRASH_DIRECTORY/full" &&
> +	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
>  	git commit-graph verify >output
>  '

I don't quite understand what the change is meant to do.

Also, as I said earlier, I'd prefer if tests were as indpendent of each
other as possible, to make running individual tests (e.g. only
previously falling tests) easier.

I especially do not like mixing running actual test with setting up the
repository for future tests, as here.

>  
> +GRAPH_BYTE_VERSION=4
> +GRAPH_BYTE_HASH=5
> +
> +# usage: corrupt_graph_and_verify <position> <data> <string>
> +# Manipulates the commit-graph file at the position
> +# by inserting the data, then runs 'git commit-graph verify'
> +# and places the output in the file 'err'. Test 'err' for
> +# the given string.

Very nice to have this description.

> +corrupt_graph_and_verify() {
> +	pos=$1
> +	data="${2:-\0}"
> +	grepstr=$3
> +	cd "$TRASH_DIRECTORY/full" &&
> +	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
> +	cp $objdir/info/commit-graph commit-graph-backup &&
> +	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&

Using 'printf' with octal is much more portable than relying on 'echo'
supporting octal escape sequences (or supporting escape sequences at
all).

> +	test_must_fail git commit-graph verify 2>test_err &&
> +	grep -v "^+" test_err >err
> +	grep "$grepstr" err

Shouldn't this last 'grep' be 'test_i18ngrep' instead, to allow for
translated messages from 'git commit-graph verify' / 'git fsck'?

> +}

This function makes actual tests short and simple, without duplicated
code.  Very good.

> +
> +test_expect_success 'detect bad signature' '
> +	corrupt_graph_and_verify 0 "\0" \
> +		"graph signature"
> +'
> +
> +test_expect_success 'detect bad version' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
> +		"graph version"
> +'
> +
> +test_expect_success 'detect bad hash version' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \

When we move from SHA-1 (hash version 1) to NewHash (hash version 2),
this test would start failing... which is actually not a bad idea.

> +		"hash version"
> +'
> +
>  test_done
