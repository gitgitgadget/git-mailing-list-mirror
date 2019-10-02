Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBBEA1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 21:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfJBVrP (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 17:47:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45417 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfJBVrO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 17:47:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id q7so381139pgi.12
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 14:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZoQy8UOq3VZ/ODnZ/Z89R45ZYyQw5VbiiagBJ88BNJ0=;
        b=RztsGIba54tM2a/Zh8NTN7nq5k5uQ3VHdY2md2jHfQRKPoTnPmiDmJ+H4gcCXJG2PZ
         mWTvOI9aCkpPQ1O32DS0C1N+TiZwv4vgcYl6TU0fOkWYT7NMEfuovbezuiLKI5XxUit2
         iDyIfPZgF/d/STTpxFCO4xoML1AWg0KSW2MLrWkXMvDEjiHG/VHWRZdqKEP7LMzWpY5h
         9KBO44vI0bZo6keAPIwi7f4sc7xfiPGgruZ/yfjRf47rf/rd15nwouv2Zwe74626ke7g
         1hahLyHafr2QgbKXIVPY3P41UQuA76LWEIUk8ecawaddWrliZPB+Ya99tKA51cqxieqr
         x+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZoQy8UOq3VZ/ODnZ/Z89R45ZYyQw5VbiiagBJ88BNJ0=;
        b=VI3XbZr13LUmFcXFoHblVzuWEtlMhcoNQqUxS/qaYX7rnbhUAWsdVmuDW7LxFNBxxf
         pGOj4wMPQqhEvaKI4uj3/I6er4nouPg54se1TA4Obi6XT9hLgkQhh9kjSdBLs8H+Be6V
         joIVFpZTpWlaYz1zODQSgZ50fxXtRyy7XzXkF2G9kP+tBxFyG5mjb4vPs8pNi+Y0+/kZ
         0+m/nYypZH2F0gCT10UK+xtWbbs1OYzJXa4Pu1yknjh0kH4EQR3yoYxMWGPyzaTlSahj
         mugI/MQkhEAv0So3tefUIa9qxJPherRlgc71IbwelKj13kJrUVH1r5HXbrpPNp08xXOM
         oHLQ==
X-Gm-Message-State: APjAAAXBdeQOKdm/zWGrxFvPiXARh8EAofPNFW0nN3OEeT/0n+FG796F
        kOkLh5vXSLfZFAP7heydJzc=
X-Google-Smtp-Source: APXvYqz4v5xFZ4DjGfDJPYRwKO6cIDoGj2yf9X54FZ95hrkXiTPUE2MZEXygZQVl2mFhgYsWBBUW/g==
X-Received: by 2002:a63:e114:: with SMTP id z20mr5858916pgh.278.1570052833104;
        Wed, 02 Oct 2019 14:47:13 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id 195sm417331pfz.103.2019.10.02.14.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 14:47:11 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:47:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] format-patch: document and exercise that -o does
 only create the trailing directory
Message-ID: <20191002214709.GA51809@generichostname>
References: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aeacd8af4b83142f160c63be4746554e823cfc3.1570051490.git.bert.wesarg@googlemail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bert,

> Subject: format-patch: document and exercise that -o does only create the trailing directory

s/does only create/only creates/ ?

Anyway, as a prepatory patch, I don't think that it's necessary. Maybe
it's just me but I assume that most tools create at most one directory
deep. Even mkdir won't created nested dirs unless you pass `-p`. I
dunno.

On Wed, Oct 02, 2019 at 11:26:11PM +0200, Bert Wesarg wrote:
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
>  Documentation/config/format.txt    |  3 ++-
>  Documentation/git-format-patch.txt |  4 +++-
>  t/t4014-format-patch.sh            | 16 ++++++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
> index 414a5a8a9d..e17c5d6b0f 100644
> --- a/Documentation/config/format.txt
> +++ b/Documentation/config/format.txt
> @@ -80,7 +80,8 @@ format.coverLetter::
>  
>  format.outputDirectory::
>  	Set a custom directory to store the resulting files instead of the
> -	current working directory.
> +	current working directory. Only the trailing directory will be created
> +	though.
>  
>  format.useAutoBase::
>  	A boolean value which lets you enable the `--base=auto` option of
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index b9b97e63ae..fe7492353e 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -66,7 +66,9 @@ they are created in the current working directory. The default path
>  can be set with the `format.outputDirectory` configuration option.
>  The `-o` option takes precedence over `format.outputDirectory`.
>  To store patches in the current working directory even when
> -`format.outputDirectory` points elsewhere, use `-o .`.
> +`format.outputDirectory` points elsewhere, use `-o .`. Note that only
> +the trailing directory will be created by Git, leading directories must
> +already exists.
>  
>  By default, the subject of a single patch is "[PATCH] " followed by
>  the concatenation of lines from the commit message up to the first blank
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index ca7debf1d4..bf2715a503 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1632,6 +1632,22 @@ test_expect_success 'From line has expected format' '
>  	test_cmp from filtered
>  '
>  
> +test_expect_success 'format-patch -o with no leading directories' '
> +	rm -fr patches &&
> +	git format-patch -o patches master..side &&
> +	test $(git rev-list master..side | wc -l) -eq $(ls patches | wc -l)

For test case you write, please use the following pattern:

	git rev-list master..side >list &&
	test_line_count = $(ls patches | wc -l) list

The first benefit is that we get to take advantage of the
test_line_count function that's already written for us. The second is
that when we write tests, we shouldn't put Git commands in the upstream
of a pipe because if they fail, their return codes will be lost and we
won't be able to fail the test properly.

> +'
> +
> +test_expect_success 'format-patch -o with leading existing directories' '
> +	git format-patch -o patches/side master..side &&
> +	test $(git rev-list master..side | wc -l) -eq $(ls patches/side | wc -l)
> +'
> +
> +test_expect_failure 'format-patch -o with leading non-existing directories' '
> +	rm -fr patches &&
> +	git format-patch -o patches/side master..side
> +'

As above, I wouldn't really call this a bug in Git. I think we should
leave this test case off until the next patch.

> +
>  test_expect_success 'format-patch format.outputDirectory option' '
>  	test_config format.outputDirectory patches &&
>  	rm -fr patches &&
> -- 
> 2.23.0.11.g242cf7f110
> 
