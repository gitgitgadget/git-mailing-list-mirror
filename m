Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E48B1F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 15:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbeFBPwr (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 11:52:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39272 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbeFBPwp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 11:52:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so6772190wmc.4
        for <git@vger.kernel.org>; Sat, 02 Jun 2018 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HmDg8dfkJi8T/NBHbcbSX8oScjpRBufDqDrm7M9Ttyk=;
        b=kiwLHkojl0sHbC8+Ef6K9GI4LFoq9ks9Qvgh9xHf/FsMchYN7UGo+I1sLYRQk+tHyU
         eopFM+E0HKFk9QV5rnHABm9esAr/6w40R6lVgLhxts53/GnBIiNvduLIpqBX9AskniV+
         k+/YmrE8U5bUCa7Z/8Fq3CZEsfYNJ+i1ejKdk+7OSfJqot/dGMdTwxPOpmZNsjBypt28
         yfls+L6P4Nu+i3dBReCcNwuPZlBqGQaCCjnBrBhsrZUVAQEyt/cH+gzPdYut3VhR8FjU
         ISkqU466bDYSTTPviS5xw9BzHD+/7wGTXJPKgnEPb2bcCWE8g0wkaOFZgAuFlS8StwSe
         mgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=HmDg8dfkJi8T/NBHbcbSX8oScjpRBufDqDrm7M9Ttyk=;
        b=Vp7+8HJu62By4zHeo9NS74eTpJvZ6qUUQmiqKY1KBOBE/dJ9HLG30K7PeYXL3G02cy
         H8ipQvSLmJ483I1E3niKCmYIMkIK+VSbRZ2HSDJAqCsQWqoi6rcuCbZB6QSWgSYluYWm
         tpmPXhI60Rbq3ZLrHObpg3XGWNDMzKZrj1bZAt01PM5IMcYJjvruORV0sFk3mH7EEwug
         5WyIMBPfgo/P5NM4hsIf+cYIEet4bx1LmLOaNj9BV8Gt1H56tsqeT1REmASorh/mg0aq
         hNSlP82VJgagtqOZWx0If8KA6Nmwi9Owb/WzMMTZlcYpLBnvw8aSoSPkGVff2+eu/j1s
         AzrA==
X-Gm-Message-State: APt69E17oudP0DSTCZYe/V1snCuBeNbvwspjF7VcwGr9Rc3pEOxxxmBD
        L/EsspymKjFodYByKGPR3Y4=
X-Google-Smtp-Source: ADUXVKJZ/ajSUajpjWX72APQNNkcpcp7KGGcTN79k6jRX07mMUDaOAW+6h/KMWj1FEXu0DCTFqk2aw==
X-Received: by 2002:a1c:3a91:: with SMTP id h139-v6mr4209695wma.94.1527954764522;
        Sat, 02 Jun 2018 08:52:44 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abri204.neoplus.adsl.tpnet.pl. [83.8.102.204])
        by smtp.gmail.com with ESMTPSA id e63-v6sm3202434wma.46.2018.06.02.08.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Jun 2018 08:52:43 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "stolee\@gmail.com" <stolee@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "marten.agren\@gmail.com" <marten.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 16/20] commit-graph: verify contents match checksum
References: <20180511211504.79877-1-dstolee@microsoft.com>
        <20180524162504.158394-1-dstolee@microsoft.com>
        <20180524162504.158394-17-dstolee@microsoft.com>
Date:   Sat, 02 Jun 2018 17:52:40 +0200
In-Reply-To: <20180524162504.158394-17-dstolee@microsoft.com> (Derrick
        Stolee's message of "Thu, 24 May 2018 16:26:01 +0000")
Message-ID: <86muwdtcc7.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The commit-graph file ends with a SHA1 hash of the previous contents. If
> a commit-graph file has errors but the checksum hash is correct, then we
> know that the problem is a bug in Git and not simply file corruption
> after-the-fact.
>
> Compute the checksum right away so it is the first error that appears,
> and make the message translatable since this error can be "corrected" by
> a user by simply deleting the file and recomputing. The rest of the
> errors are useful only to developers.

Should we then provide --quiet / --verbose options, so that ordinary
user is not flooded with error messages meant for power users and Git
developers, then?

>
> Be sure to continue checking the rest of the file data if the checksum
> is wrong. This is important for our tests, as we break the checksum as
> we modify bytes of the commit-graph file.

Well, we could have used sha1sum program, or test-sha1 helper to fix the
checksum after corrupting the commit-graph file...

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c          | 16 ++++++++++++++--
>  t/t5318-commit-graph.sh |  6 ++++++
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index d2b291aca2..a33600c584 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -841,6 +841,7 @@ void write_commit_graph(const char *obj_dir,
>  	oids.nr = 0;
>  }
>  
> +#define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
>  static int verify_commit_graph_error;
>  
>  static void graph_report(const char *fmt, ...)
> @@ -860,7 +861,9 @@ static void graph_report(const char *fmt, ...)
>  int verify_commit_graph(struct commit_graph *g)
>  {
>  	uint32_t i, cur_fanout_pos = 0;
> -	struct object_id prev_oid, cur_oid;
> +	struct object_id prev_oid, cur_oid, checksum;
> +	struct hashfile *f;
> +	int devnull;
>  
>  	if (!g) {
>  		graph_report("no commit-graph file loaded");
> @@ -879,6 +882,15 @@ int verify_commit_graph(struct commit_graph *g)
>  	if (verify_commit_graph_error)
>  		return verify_commit_graph_error;
>  
> +	devnull = open("/dev/null", O_WRONLY);
> +	f = hashfd(devnull, NULL);
> +	hashwrite(f, g->data, g->data_len - g->hash_len);
> +	finalize_hashfile(f, checksum.hash, CSUM_CLOSE);
> +	if (hashcmp(checksum.hash, g->data + g->data_len - g->hash_len)) {
> +		graph_report(_("the commit-graph file has incorrect checksum and is likely corrupt"));
> +		verify_commit_graph_error = VERIFY_COMMIT_GRAPH_ERROR_HASH;
> +	}

Is it the best way of calculating the SHA-1 checksum that out internal
APIs provide?  Is it how SHA-1 checksum is calculated and checked for
packfiles?

> +
>  	for (i = 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit;
>  
> @@ -916,7 +928,7 @@ int verify_commit_graph(struct commit_graph *g)
>  		cur_fanout_pos++;
>  	}
>  
> -	if (verify_commit_graph_error)
> +	if (verify_commit_graph_error & ~VERIFY_COMMIT_GRAPH_ERROR_HASH)
>  		return verify_commit_graph_error;

So if we detected that checksum do not match, but we have not found an
error, we say that it is all right?

>  
>  	for (i = 0; i < g->num_commits; i++) {
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 240aef6add..2680a2ebff 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -279,6 +279,7 @@ GRAPH_COMMIT_DATA_WIDTH=`expr $HASH_LEN + 16`
>  GRAPH_OCTOPUS_DATA_OFFSET=`expr $GRAPH_COMMIT_DATA_OFFSET + \
>  				$GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS`
>  GRAPH_BYTE_OCTOPUS=`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4`
> +GRAPH_BYTE_FOOTER=`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4 \* $NUM_OCTOPUS_EDGES`
>  
>  # usage: corrupt_graph_and_verify <position> <data> <string>
>  # Manipulates the commit-graph file at the position
> @@ -388,4 +389,9 @@ test_expect_success 'detect incorrect parent for octopus merge' '
>  		"invalid parent"
>  '
>  
> +test_expect_success 'detect invalid checksum hash' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> +		"incorrect checksum"

This would not work under GETTEXT_POISON, as the message is marked as
translatable, but corrupt_graph_and_verify uses 'grep' and not
'test_i18grep' from t/test-lib-functions.sh

> +'

If it is pure checksum corruption, wouldn't this fail because it is not
a failure (exit code is 0)?

> +
>  test_done
