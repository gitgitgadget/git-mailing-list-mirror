Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CBBD20248
	for <e@80x24.org>; Sun, 10 Mar 2019 17:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfCJR73 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 13:59:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32812 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfCJR73 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 13:59:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id i8so2647714wrm.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nut01jsiM8sNTQuPjUE2IPwqRdRbyrlTuE0FsxTAzJE=;
        b=hIROgo0bahGtro/3GG9h+slHiOTGxGoamV8hYmDsqRNUob2UGwZ2Qa3gvJu5MRGPZs
         knHDN32G8Est1xe3Z916H7X9iPRcwq4YeweLfEIPyTJN6fyQ5z/ma3TTbl6z+xAlLo+i
         J82ed2PnLakRuZRbiX6dvhO1gd60IK21acUVwvYwCGJe29fcSOpaouG8i9caG0Xrovve
         OnmQlHhrQDKEm7oOhaFE7XI89imgGyyIT7htBQSU1DgOguZhhw4e5hsxUc09dYQjGbM2
         oo5bSzTADCB1c7pNp0swEK6UxNppiSaKFpDPeqCtZTd4h2ayb3eHjJL2vDaWcrk3w5lr
         EhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nut01jsiM8sNTQuPjUE2IPwqRdRbyrlTuE0FsxTAzJE=;
        b=ehJw07KtfGoxVdpBh2rxxbCCXQevPV/aKqJZT4WDPqIWl6HmqRo/g11swPA0okTm4r
         2D19MapjHDmn7yhWv+iDXJmKLSCSrEEV44qvoJrknlYBd5WgFJq3jWjQRdJTWo4x/5ae
         UqiwxVcRIEP9FfEV0hB3TgLT9cC8CwjNIhvJniURP1ODKAefszxWTxx3PCQoT6Ej6AmO
         PCE5My44vcPlxHHioZpEBXw5NZi3g5LJ743KuZ18ywjIIPhZG94PDV3EaVJi12fIFN+G
         vYxFyabtQNR2L6d3/3FhKh1fFig/xVO6zkRHoCyQT1rVweBO56yH5ibfy/ettyVH4CfJ
         k4HQ==
X-Gm-Message-State: APjAAAW1zrXtZF2O5vCC1+J+7glVFb0Ihfyll0EewpbnT9/WDxdGd3Fd
        FTsLcZl51zMiO6QAX5bsNNM=
X-Google-Smtp-Source: APXvYqwavROrP8OkZH1r77FFQdFLsGf1PZ3Fj8/rWOO9bfycFj06edn0IDaxh7QbJhxOPIx5CIvwpA==
X-Received: by 2002:adf:a2cc:: with SMTP id t12mr17877465wra.253.1552240767081;
        Sun, 10 Mar 2019 10:59:27 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id h10sm26267206wmf.2.2019.03.10.10.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 10:59:25 -0700 (PDT)
Date:   Sun, 10 Mar 2019 17:59:24 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Chang <ttjtftx@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [GSoC][PATCH v2 1/5] t0000-basic: fix an indentation error
Message-ID: <20190310175924.GF31533@hank.intra.tgummerer.com>
References: <20190309164508.GB31533@hank.intra.tgummerer.com>
 <20190310080739.63984-1-ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190310080739.63984-1-ttjtftx@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/10, Jonathan Chang wrote:
> Hi,
> 
> Thanks for the reviews.
> 
> Here are the changes in the second version:
> 	- bug fixes
> 	- add preparatory patch
> 	- seperate different files to different patch
> 	- change to use test_line_count in a seperate patch
> 
> Also I found that there is no such function as test_char_count, 
> is it worthwile to add such function? Here are some stat:
> 
> `git grep 'test_line_count' | wc -l` = 626
> `git grep 'wc -l' | wc -l` = 294
> `git grep 'wc -c' | wc -l` = 68

I do think it would be helpful to introduce that helper, especially if
it is useful in this patch series.  There seem to be enough other
places where it can be useful to make it worth adding the helper.

> -- >8 --
> 
> This is a preparatory step prior to removing the pipes after git
> commands, which discards git's exit code and may mask a crash.

The commit message should also describe why we need this preparatory
step. Maybe something like:

      To reduce the noise in when refactoring this pipeline in a
      subsequent commit fix the indentation.  This has been wrong
      since the refactoring done in 1b5b2b641a ("t0000: modernise
      style", 2012-03-02), but carries no meaning.

> Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
>

Out of curiosity, how did you create the patch?  'git format-patch'
would add a '---' line followed by the diffstat, where you would
usually put the commentary that you put before the scissors line.  It
seems like 'git am' still handles this fine, which I didn't know, just
something I noticed because I'm used to the other format.

Since this patch series is now 5 patches, that commentary should go
into a cover letter (see the --cover-letter option in format-patch),
so the reviewers can read that first, and read the patches with that
in mind, focusing on the patch only, and not additional commentary
that applies to the whole series when reading the patch.

> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index b6566003dd..53821f5817 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1132,7 +1132,7 @@ test_expect_success 'git commit-tree records the correct parent in a commit' '
>  
>  test_expect_success 'git commit-tree omits duplicated parent in a commit' '
>  	commit2=$(echo NO | git commit-tree $P -p $commit0 -p $commit0) &&
> -	     parent=$(git show --pretty=raw $commit2 |
> +	parent=$(git show --pretty=raw $commit2 |
>  		sed -n -e "s/^parent //p" -e "/^author /q" |
>  		sort -u) &&
>  	test "z$commit0" = "z$parent" &&
> -- 
> 2.21.0
> 
