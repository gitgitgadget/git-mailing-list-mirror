Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493241F461
	for <e@80x24.org>; Wed,  4 Sep 2019 00:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfIDA3e (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 20:29:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39947 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfIDA3e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 20:29:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id f10so18010598qkg.7
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 17:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B7/D6Ae5QWRWmB4B6Fr7RAHYULOZeHY4dqrNlwAdQ+I=;
        b=DBt5QN6O2jLBTnRTLeNrfMSwFY6Ix+CgpTsBDM9uA13GFqG96SiPZhUdhkmF+Gwz+Z
         cx2vnSqhcNKV7RSub7IRiicDB51qp37kU4amkdinFTkqjS+2KsSPA5mFnD3bDNSqz1JD
         27A58EDp+sQaQH4VdHOEhVc+vO27VVNUpqP23tabaJ5x9ZeFrRkbcHNO8mK9I8oCSBOS
         3RmZ61EfBOVYl/53CrKkCCZKMGTeqVxyr3vi0lQtr0ycBazQAU/pSCh7CvhTnFG1McBJ
         3Nq5ajUFlEpcpoV4c7TFLDptMVwFfxw+oFsBtRCqm6NJOQMVYYkKzr5UJsi20e61QBWw
         oz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B7/D6Ae5QWRWmB4B6Fr7RAHYULOZeHY4dqrNlwAdQ+I=;
        b=ueZsRr0eHgZTRaVap5li+M25nhE2wuQAjAq7wzthjYgqTqOFYf1rPNACV7C3x3vH1C
         7CSxtFl5gXaUCwlb3C49v+aibNtBRuIi6/358lNeRFskx9NWcE8hEHtWg5kOIrHtljBo
         4OO+KIXzfH/NeZMeMe1XdahyU9Vf/uoYPyX94JrRN8Nre4bTODKwf1PgCTC91jVYwf5g
         GKWjGyYn79Dk8lRLxpxNZeGI71S3A713OF65QQpV1m4mrHHXO26HrfVhJUi6rfS03jL6
         lVHJOvXqWtlXd1aeR7l1iy8Bpiv3lTNS50XBf0cRvK5ffGHyPONXy8WzhtNZF2Iz6gCj
         WHAA==
X-Gm-Message-State: APjAAAV6rPNoZoU915+CULGqL3EKyUO4v9ljcDk7D1JRI26LkID3SXm4
        Y28tXF1d2ouXMqNji2aAwj34p/o3DC4=
X-Google-Smtp-Source: APXvYqxJBrzbYShg2q8WY6+2Q1Q14NP/Ef0lSzEhWMGcfRZ4dqYW38gRz1W6QmGMzSzVQ5i322RchA==
X-Received: by 2002:a37:bac3:: with SMTP id k186mr35610097qkf.61.1567556972922;
        Tue, 03 Sep 2019 17:29:32 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:24fd:2e2b:8aac:d853])
        by smtp.gmail.com with ESMTPSA id h10sm6201892qtk.18.2019.09.03.17.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 17:29:31 -0700 (PDT)
Date:   Tue, 3 Sep 2019 20:29:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: use LF variable defined in the test harness
Message-ID: <20190904002930.GA76383@syl.lan>
References: <xmqqwoeprsp1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwoeprsp1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Sep 03, 2019 at 02:11:22PM -0700, Junio C Hamano wrote:
> A few test scripts assign a single LF to $LF, but that is already
> given by test-lib.sh to everybody.

I didn't know that 't/test-lib.sh' provided '$LF' (as I'm sure was the
case for the respective authors of those tests below ;-)), so removing
the bespoke definitions and relying on the one already defined makes
good sense.

> Remove the unnecessary reassignment.

I did find a couple of extra spots when I went looking through 't'
myself. I ran:

  $ git grep "='$" -- t

which in addition to the three spots below turned up a couple more
interesting locations, as well as a few false positives. They are:

  - t/t3005: this script calls the variable '$new_line', but could be
    renamed to LF and then removed in a second patch

  - t/valgrind/analyze.sh: this script also calls the variable
    '$new_line', but does not ever source test-lib.sh, so I think this
    spot can be ignored.

So I think that my recommendation is to either:

  * introduce a prepratory patch that updates t3005 to rename
    '$new_line' to '$LF', and then amend the patch below to also blow
    away t3005's use of '$LF', or

  * do both steps in one larger patch

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t3404-rebase-interactive.sh | 2 --
>  t/t4013-diff-various.sh       | 3 ---
>  t/t5515-fetch-merge-logic.sh  | 3 ---
>  3 files changed, 8 deletions(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 461dd539ff..31114d0bbb 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -155,8 +155,6 @@ test_expect_success 'rebase -x with empty command fails' '
>  	test_i18ncmp expected actual
>  '
>
> -LF='
> -'
>  test_expect_success 'rebase -x with newline in command fails' '
>  	test_when_finished "git rebase --abort ||:" &&
>  	test_must_fail env git rebase -x "a${LF}b" @ 2>actual &&
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index a9054d2db1..5ac94b390d 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -7,9 +7,6 @@ test_description='Various diff formatting options'
>
>  . ./test-lib.sh
>
> -LF='
> -'
> -
>  test_expect_success setup '
>
>  	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
> diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
> index e55d8474ef..961eb35c99 100755
> --- a/t/t5515-fetch-merge-logic.sh
> +++ b/t/t5515-fetch-merge-logic.sh
> @@ -12,9 +12,6 @@ GIT_TEST_PROTOCOL_VERSION=
>
>  . ./test-lib.sh
>
> -LF='
> -'
> -
>  test_expect_success setup '
>  	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
>  	GIT_COMMITTER_DATE="2006-06-26 00:00:00 +0000" &&

The rest of the patch here looks obviously good.

Thanks,
Taylor
