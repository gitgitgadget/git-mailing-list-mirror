Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E716C1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbeJLGWz (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:22:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46210 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJLGWz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:22:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id g32-v6so9753111edg.13
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JLuJML2EtMWajszO0qrDjrdkeUMqg2cSzmsvksbYpRs=;
        b=AtLyjLHYN81w3ufOzjoSzZ4YRgTBgVUpKa6185OnSeY0GpZuLdn4PtZULcaYzlbIAD
         NWxsJUPtVjj7zKVQs9s5GMfgSh/sO65jHFiiiAyC6sOIoaig39NocdIujmF5/T/qkEa2
         BljmseZ10032IAQWi+40cnpDic721VrO5UrNMZx9ULY/EB1KUkJOer2cUPiJi2IOG4uW
         aHBz2gUccbkqaLfoglzSYKFHmSZkGhkFQqgINXzaZqykOlI+wwRrdg1NVw+RZY9qlmX9
         OVmqV8kAme+Au4MQ1cpv3GdX6CeaxSGn67i4mpsiWVYn0/K42qrjBtmuuBdKXr1Vprf/
         vBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JLuJML2EtMWajszO0qrDjrdkeUMqg2cSzmsvksbYpRs=;
        b=ZztQwZj1+WZyxYlZTDEEbY0d8gCkpbNXrtTThmQ+N72zlHisEqFMq1H6BHyMWLUqcF
         hY3qDAYENwZiEL5FQlzANp8Tl0S/PZVh6hQkG0WNjOlbIl1rLrv/3OqZyrnxG48vSKBr
         m0zkdcfQJXRCVHNe+XDO0os8MdYX+k5XcO6yGOlGl946Jt5LYVLo+pXSmVqIxrMjQEwc
         fKusKJLD98t/IyEqC1xtB7EIrbCtImwtKYHRq3Z9xEs7/PZbYMIRJPuXeFD3bnVs6HRC
         ahlrzm6DK0jk5yS3K+XC6irp+5RQZHaYcL0k23TVRwiPix9/HpJWXAW95fagLSH+nA8v
         bz5A==
X-Gm-Message-State: ABuFfogwwE6qYdipcHx9SrVTJBsipX82YJfv/NsGazJb7eRuhWj5M1Yv
        wqORIInBBPUppQygfBQWHCwoKnSb
X-Google-Smtp-Source: ACcGV63MqTEgxAfEqTLoCBdqw7kUzqGyYWM34041OXPQXHPsxWT68uAjchr2Ypg2B3QBVofuDM08Ww==
X-Received: by 2002:a17:906:e0d5:: with SMTP id gl21-v6mr4443193ejb.92.1539298409394;
        Thu, 11 Oct 2018 15:53:29 -0700 (PDT)
Received: from szeder.dev (x4dbd43b4.dyn.telefonica.de. [77.189.67.180])
        by smtp.gmail.com with ESMTPSA id l42-v6sm9004259edb.24.2018.10.11.15.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 15:53:28 -0700 (PDT)
Date:   Fri, 12 Oct 2018 00:53:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
Message-ID: <20181011225326.GC19800@szeder.dev>
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181010205432.11990-2-daniels@umanovskis.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 10:54:32PM +0200, Daniels Umanovskis wrote:

[...]

> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index ee6787614..e9bc3b05f 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -100,6 +100,47 @@ test_expect_success 'git branch -v pattern does not show branch summaries' '
>  	test_must_fail git branch -v branch*
>  '
>  
> +test_expect_success 'git branch `--show-current` shows current branch' '
> +	cat >expect <<-\EOF &&
> +	branch-two
> +	EOF
> +	git checkout branch-two &&

Up to this point everything talked about '--show-current' ...

> +	git branch --current >actual &&

... but here and in all the following tests you run

  git branch --current

which then fails with "error: unknown option `current'"

> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git branch `--show-current` is silent when detached HEAD' '
> +	git checkout HEAD^0 &&
> +	git branch --current >actual &&
> +	test_must_be_empty actual
> +'
> +
> +test_expect_success 'git branch `--show-current` works properly when tag exists' '
> +	cat >expect <<-\EOF &&
> +	branch-and-tag-name
> +	EOF
> +	git checkout -b branch-and-tag-name &&
> +	git tag branch-and-tag-name &&
> +	git branch --current >actual &&
> +	git checkout branch-one &&
> +	git branch -d branch-and-tag-name &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'git branch `--show-current` works properly with worktrees' '
> +	cat >expect <<-\EOF &&
> +	branch-one
> +	branch-two
> +	EOF
> +	git checkout branch-one &&
> +	git branch --current >actual &&
> +	git worktree add worktree branch-two &&
> +	cd worktree &&
> +	git branch --current >>../actual &&
> +	cd .. &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'git branch shows detached HEAD properly' '
>  	cat >expect <<EOF &&
>  * (HEAD detached at $(git rev-parse --short HEAD^0))
> -- 
> 2.19.1.330.g93276587c.dirty
> 
