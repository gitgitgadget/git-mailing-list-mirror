Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8532620133
	for <e@80x24.org>; Fri,  3 Mar 2017 13:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbdCCNEg (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 08:04:36 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32874 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdCCNEf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 08:04:35 -0500
Received: by mail-pg0-f67.google.com with SMTP id 16so4164654pga.0
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 05:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljkXtOzr9cbFaAoTqiyySskhpfui+7lCvXRZiHwT2io=;
        b=QxSrf4Do7Yt9x0yynL6gykf7SUOI3dC5nmbgew0rJxIh229+owWqTWg9srMw9iqGFw
         Ge87e5e6nG+qZY9vPJ9IPIezVYGFiW6z9TH2Y1LH5FM7OHFmhZD05xjAIsp1yHyRPuj4
         OIMuyN5js8OZCQ91HJaDbdBxv4Y/QpUbcRFfmiVr6exCcs7RqIXOtIwhUTch7mazU71U
         9cGt9u3tiivlfMAdJMD5W8fnFsA66hwBqNicREXfL4t6tdZjjmInfzj6pYaU64LivjlV
         XIu3fo2TFLkEZPpgrOkLlMoTj5h3wJoWrk/m1DFqIi6oPxcC9dZ9ilBLEQKhgCJqEKaY
         wyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljkXtOzr9cbFaAoTqiyySskhpfui+7lCvXRZiHwT2io=;
        b=Cf1A2VLwk43jCexuuKFX8fYqCuQTx9qoHym5x4EfuRsBn63Vjfqjyfg4HWxsZXJE13
         /Vk97qf9Qoy/7o2QEP56vcs6lp7lbNC1NGLVa8KxkqhOLcVT5JcF/1DILzNJmSJWFnHI
         qEAB4ni1XzlEdQ4fGdancqp41vS0E1DlhflgHvlgVlsscG+fHT1V5WXtzQn16/tsnPDK
         sP00QxhvskahtRXEwa3Tgw23lVlZYxrrzIFHdd+G/XBBMNybJtMPlILU8l8b+7JtAGnE
         aBkPB3K65YvrOmdnVy8jmzdvFvYEGPzCyRV2zNwMOKFQEyd6p6ccjY0XZpAbqkoIJqt3
         IKLw==
X-Gm-Message-State: AMke39nvkcXfaUajnqlxFywhAc3BaecidzTK9rOMsGcuoMJNRNfB/oUe2ugisMpY6CPSdQ==
X-Received: by 10.99.174.4 with SMTP id q4mr3240092pgf.186.1488544778376;
        Fri, 03 Mar 2017 04:39:38 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id c195sm23321636pfb.60.2017.03.03.04.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Mar 2017 04:39:36 -0800 (PST)
Date:   Fri, 3 Mar 2017 04:39:34 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/3] Add --gui option to mergetool
Message-ID: <20170303123934.4cau7ansprx2xpc7@gmail.com>
References: <20170303115738.GA13211@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170303115738.GA13211@arch-attack.localdomain>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:57:38AM -0800, Denton Liu wrote:
> This fixes the discrepancy between difftool and mergetool where the
> former has the --gui flag and the latter does not by adding the
> functionality to mergetool.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/git-mergetool.txt        |  8 +++++++-
>  contrib/completion/git-completion.bash |  3 ++-
>  git-mergetool.sh                       |  5 ++++-
>  t/t7610-mergetool.sh                   | 28 +++++++++++++++++++++++++++-
>  4 files changed, 40 insertions(+), 4 deletions(-)

Would you mind splitting up this patch so that the
completion part is done separately?


> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 381b7df45..5683907ab 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -145,6 +147,30 @@ test_expect_success 'custom mergetool' '
>  	git commit -m "branch1 resolved with mergetool"
>  '
>  
> +test_expect_success 'gui mergetool' '
> +	test_when_finished "git reset --hard" &&
> +	test_when_finished "git config merge.tool mytool" &&
> +	test_when_finished "git config --unset merge.guitool" &&
> +	git config merge.tool badtool &&
> +	git config merge.guitool mytool &&
> +	git checkout -b test$test_count branch1 &&
> +	git submodule update -N &&
> +	test_must_fail git merge master >/dev/null 2>&1 &&

It'd probably be better to use test_expect_code instead of
test_must_fail here:

	test_expect_code 1 git merge master ...


> +	( yes "" | git mergetool -g both >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool -g file1 file1 ) &&
> +	( yes "" | git mergetool --gui file2 "spaced name" >/dev/null 2>&1 ) &&
> +	( yes "" | git mergetool --gui subdir/file3 >/dev/null 2>&1 ) &&

I realize that this test is based on an existing one, but I'm curious..
is "yes" used above because it's prompting, and using -y or --no-prompt
here would eliminate the need for the 'yes ""' parts?

Looks good otherwise.

Thanks,
-- 
David
