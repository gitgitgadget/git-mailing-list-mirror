Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 028471FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 21:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbdDFVUS (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 17:20:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36100 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdDFVUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 17:20:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id o21so9725154wrb.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 14:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=286/tetAVynT5E4IRLIjg7hJMi3P490xYGbUWfYNniQ=;
        b=H7lADujY+69ClwOOBoaAoynDAQ8SkhV9vXIdo/IGzkM8Vht36yfYRrMnqARiu7c5RY
         YdLrMpSiXxv9U5Z4CFNSOZLLJwN1LLQbC4WOPHzbCBw/yyiwfeGfOvIjoLpdoMBWkrqM
         qJqPN7hSl02itX6p4VcZXJznvxjE+afAwPvQ3kAj8UGkAAmTW5d0vfnFy8H9z2I1AK6E
         N4a+BRi4QKTxk9T+we1uHUbMOi2JxvfnKJQUs6jHMFY2qLM7LYxTDgkEsc9DGGJNhkyM
         16s2h+SLUm/A3TUwQ33ALWqgVdaPLiPBDeuNb7rp2+E2BwdKHTYS8R6oQQ07Tc2a13hJ
         y0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=286/tetAVynT5E4IRLIjg7hJMi3P490xYGbUWfYNniQ=;
        b=cG80H9TBGLfSgq+NgKdgLwWI3JP0xqAPX2EPZUUnOqoGjOj1gIbkbA7ew3GzZcTgDZ
         sm2I19GewW2FZNdLI/2sf8Vtu/O7xGIkcKOcjGL1u+HlYCg0Ce9Dexz4TbN2U07TsycA
         viz1YE6MY5jalxpJYmfFBWh+jJaP9w4F/JP2XwQTfsnkSRgL2IgBaWxiMrtYe7O9U/C1
         XgJF9iN6BKTYiTdoz97NPMMcsQPy1jNtUaiF62PXw02q7RgqlTSIp1B2TjMGxY8BLEkq
         48+snRdAH+c+dO/jRUwSCfZKXdZ06ycmEfLZ/lsm+u59Mou7RIsR5L6hRZ0E1CsthxCK
         HElA==
X-Gm-Message-State: AFeK/H39+pgi6JjNVHH8pKjACBm+uhqD4JSyMfCsOgDi8Kmmq+DM5OvLoIWsu+Ekj8iFdg==
X-Received: by 10.223.172.133 with SMTP id o5mr27865366wrc.23.1491513615109;
        Thu, 06 Apr 2017 14:20:15 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 60sm3493656wrg.60.2017.04.06.14.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Apr 2017 14:20:14 -0700 (PDT)
Date:   Fri, 7 Apr 2017 00:26:39 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 2/2] p0005-status: time status on very large repo
Message-ID: <20170406232634.GB32223@hank>
References: <20170406134508.31711-1-git@jeffhostetler.com>
 <20170406134508.31711-3-git@jeffhostetler.com>
 <20170406221453.GA32223@hank>
 <590f6863-801b-58e9-3700-962168f8315e@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <590f6863-801b-58e9-3700-962168f8315e@jeffhostetler.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/06, Jeff Hostetler wrote:
> 
> 
> On 4/6/2017 6:14 PM, Thomas Gummerer wrote:
> >On 04/06, git@jeffhostetler.com wrote:
> >>From: Jeff Hostetler <jeffhost@microsoft.com>
> >>
> >>Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> >>---
> >> t/perf/p0005-status.sh | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 61 insertions(+)
> >> create mode 100755 t/perf/p0005-status.sh
> >>
> >>diff --git a/t/perf/p0005-status.sh b/t/perf/p0005-status.sh
> >>new file mode 100755
> >>index 0000000..704cebc
> >>--- /dev/null
> >>+++ b/t/perf/p0005-status.sh
> >>@@ -0,0 +1,61 @@
> >>+#!/bin/sh
> >>+
> >>+test_description="Tests performance of read-tree"
> >>+
> >>+. ./perf-lib.sh
> >>+
> >>+test_perf_default_repo
> >>+test_checkout_worktree
> >>+
> >>+## usage: dir depth width files
> >>+make_paths () {
> >>+	for f in $(seq $4)
> >>+	do
> >>+		echo $1/file$f
> >>+	done;
> >>+	if test $2 -gt 0;
> >>+	then
> >>+		for w in $(seq $3)
> >>+		do
> >>+			make_paths $1/dir$w $(($2 - 1)) $3 $4
> >>+		done
> >>+	fi
> >>+	return 0
> >>+}
> >>+
> >>+fill_index () {
> >>+	make_paths $1 $2 $3 $4 |
> >>+	sed "s/^/100644 $EMPTY_BLOB	/" |
> >>+	git update-index --index-info
> >>+	return 0
> >>+}
> >>+
> >>+br_work1=xxx_work1_xxx
> >>+dir_new=xxx_dir_xxx
> >>+
> >>+## (5, 10, 9) will create 999,999 files.
> >>+## (4, 10, 9) will create  99,999 files.
> >>+depth=5
> >>+width=10
> >>+files=9
> >>+
> >>+## Inflate the index with thousands of empty files and commit it.
> >>+## Use reset to actually populate the worktree.
> >>+test_expect_success 'inflate the index' '
> >>+	git reset --hard &&
> >>+	git branch $br_work1 &&
> >>+	git checkout $br_work1 &&
> >>+	fill_index $dir_new $depth $width $files &&
> >>+	git commit -m $br_work1 &&
> >>+	git reset --hard
> >>+'
> >>+
> >>+## The number of files in the branch.
> >>+nr_work1=$(git ls-files | wc -l)
> >
> >The above seems to be repeated (or at least very similar to what you
> >have in your other series [1].  Especially in this perf test wouldn't
> >it be better just use test_perf_large_repo, and let whoever runs the
> >test decide what constitutes a large repository for them?
> >
> >The other advantage of that would be that it is more of a real-world
> >scenario, instead of a synthetic distribution of the files, which
> >would give us some better results I think.
> >
> >Is there anything I'm missing that would make using
> >test_perf_large_repo not a good option here?
> 
> Yes, it is copied from the other series.  I make the same change
> that Rene just suggested on it to use awk to create the list.
> 
> I did this because I need very large repos.  From what I can tell
> the common usage is to set test_perf_large_repo to linux.git, but
> that only has 58K files.  And it defaults to git.git which only
> has 3K files.

Yeah true.  Back when I worked on "index v5" for my GSoC project, I
used to use the webkit repository, which at the time had
300-something K files.  Nowadays the better test might be the chromium
repository, but I'm not sure (cloning that takes a while on my
connection :) ).  

> Internally, I test against the Windows source tree with 3.1M files,
> but I can't share that :-)

Heh.  I'd love to see the performance numbers for that though!

> So I created this test to generate artificial, but large and
> reproducible repos for evaluation.
> 
> I could change the default depth to 4 (giving a 100K tree), but
> I'm really interested in 1M+ repos.  For small-ish values of n
> the difference between O(n) and O(n log n) operations can hide
> in system and I/O noise; not so for very large n....

Makes sense to me.  Thanks for the explanation!

> >
> >[1]: http://public-inbox.org/git/20170406163442.36463-3-git@jeffhostetler.com/
> >
> >>+test_perf "read-tree status work1 ($nr_work1)" '
> >>+	git read-tree HEAD &&
> >>+	git status
> >>+'
> >>+
> >>+test_done
> >>--
> >>2.9.3
> >>
