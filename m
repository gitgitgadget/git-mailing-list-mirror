Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF0D01FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754751AbdDFUId (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:08:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36285 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752825AbdDFUIb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:08:31 -0400
Received: by mail-wr0-f196.google.com with SMTP id o21so9299594wrb.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6PX0y3oNp5Z4sGQpzd26RaaBdPlFHuM+DW6yLUEHYwY=;
        b=oFuas9Jt9J4BTSAJpmKFlzwiqE+Oz+A5GsJQIP8nKYAJ5PqAhRkjMONwxxmeHyV+I2
         Tm/qOnB072I1mxC/rL3FqBvhmPV+10A9Wd9enm/4spDUiA4q/JLsz4d5PELY2WpqxG1u
         JyyFlrsybGTwCK7dvLt0SSKixNqwRdNSEIQmNuPNQyH0F+dTJOOuTKMe1XXyDTCl9v7e
         B5Zpi4qPHp5kfEgfz8NmXmk4+O31CbxOYSAx4lrnXKnzaIxgJGlFC7poHW10H/P7cy06
         DwA7FPR9YKDOfLvs5eclL7vUE21RtY5PVVBazSA1bejEmjh2rCKk2fIbc5eN1NGcrKMW
         gEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6PX0y3oNp5Z4sGQpzd26RaaBdPlFHuM+DW6yLUEHYwY=;
        b=SeRvAcagaX1QyEPPRhXttZjB4Wbnx6ah5JdU/5gLlpu+VkDyuQLqbBcJcUm87FkFGa
         kG2ozgVuusN5LEsGljcjUYgfDI6y5qK3UrLEX9wt9NmROZDaUz2Yex5OwUWcdJBuOouX
         VkmjhdXjgJYd6WojteEwIARvDpIIxNQUyVVc/CBrs1KA95sC8aWHLOawD57N6T/YjQsy
         feaHw/qrvjjW/Z7XGp0xk5ZhNuTmwtSWUY3b+B6JFJ4qdwpaJe+8FSXye8wO4fmnSBaW
         lzbYHQ/9JsEWZ6bgtu+Ng6Gyw85lYGC0bkVHNLBIMP28xi0Woes4CGPxyk4xaAyTT14l
         xL0Q==
X-Gm-Message-State: AFeK/H3Icqtkf0KT1VbZs2JouqBPsQDrDy/LDYmRYGcciULnUgB+u878
        am3osW9ug9CVNOUZpU8=
X-Received: by 10.28.69.72 with SMTP id s69mr25864778wma.85.1491509309616;
        Thu, 06 Apr 2017 13:08:29 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id m29sm3338495wrm.4.2017.04.06.13.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Apr 2017 13:08:28 -0700 (PDT)
Date:   Thu, 6 Apr 2017 23:14:53 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 2/2] p0005-status: time status on very large repo
Message-ID: <20170406221453.GA32223@hank>
References: <20170406134508.31711-1-git@jeffhostetler.com>
 <20170406134508.31711-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406134508.31711-3-git@jeffhostetler.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/06, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/perf/p0005-status.sh | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100755 t/perf/p0005-status.sh
> 
> diff --git a/t/perf/p0005-status.sh b/t/perf/p0005-status.sh
> new file mode 100755
> index 0000000..704cebc
> --- /dev/null
> +++ b/t/perf/p0005-status.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +test_description="Tests performance of read-tree"
> +
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +test_checkout_worktree
> +
> +## usage: dir depth width files
> +make_paths () {
> +	for f in $(seq $4)
> +	do
> +		echo $1/file$f
> +	done;
> +	if test $2 -gt 0;
> +	then
> +		for w in $(seq $3)
> +		do
> +			make_paths $1/dir$w $(($2 - 1)) $3 $4
> +		done
> +	fi
> +	return 0
> +}
> +
> +fill_index () {
> +	make_paths $1 $2 $3 $4 |
> +	sed "s/^/100644 $EMPTY_BLOB	/" |
> +	git update-index --index-info
> +	return 0
> +}
> +
> +br_work1=xxx_work1_xxx
> +dir_new=xxx_dir_xxx
> +
> +## (5, 10, 9) will create 999,999 files.
> +## (4, 10, 9) will create  99,999 files.
> +depth=5
> +width=10
> +files=9
> +
> +## Inflate the index with thousands of empty files and commit it.
> +## Use reset to actually populate the worktree.
> +test_expect_success 'inflate the index' '
> +	git reset --hard &&
> +	git branch $br_work1 &&
> +	git checkout $br_work1 &&
> +	fill_index $dir_new $depth $width $files &&
> +	git commit -m $br_work1 &&
> +	git reset --hard
> +'
> +
> +## The number of files in the branch.
> +nr_work1=$(git ls-files | wc -l)

The above seems to be repeated (or at least very similar to what you
have in your other series [1].  Especially in this perf test wouldn't
it be better just use test_perf_large_repo, and let whoever runs the
test decide what constitutes a large repository for them?

The other advantage of that would be that it is more of a real-world
scenario, instead of a synthetic distribution of the files, which
would give us some better results I think.

Is there anything I'm missing that would make using
test_perf_large_repo not a good option here?

[1]: http://public-inbox.org/git/20170406163442.36463-3-git@jeffhostetler.com/

> +test_perf "read-tree status work1 ($nr_work1)" '
> +	git read-tree HEAD &&
> +	git status
> +'
> +
> +test_done
> -- 
> 2.9.3
> 
