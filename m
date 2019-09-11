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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E79C1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 11:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfIKLuZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 07:50:25 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41614 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIKLuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 07:50:25 -0400
Received: by mail-yb1-f194.google.com with SMTP id x4so3590496ybo.8
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4/BsVmrqxGoXJrDaWngtjd3Ld7sVSNCEcwPufmo/p/A=;
        b=dfR4E39gAJcs2W7556/ooF0+lhKo3EUpdnxXavfFIZHs8StEbXrxlaGyCqMmZvK7+k
         r/l+ZvmibYsxVwxKP7RjzigJ2QIw4yKQzOConOOj8Jqgyw1uxOVdkh3PWHdbeSI3uIBh
         s9dRt3iWjfj8oFcjD8kKVImaSfsPrVaCtU8Rewcg/7Ds4Kt1LVMGOT8dyB+w3Bbb0s6O
         0ALQEDs5bKASRSooql5jBX4+076kooaEvaKzExPAEY4dXNt5t2JV4EFXoOHsqgzTl5P7
         It0OtUmyuMsDiPpT3+NIlKkF+pkfLSJHBOXKPqawxmWBW7l89GvR3EtAKh40tdlAv3a/
         MOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4/BsVmrqxGoXJrDaWngtjd3Ld7sVSNCEcwPufmo/p/A=;
        b=TlXa0z59LG3kdnHTUWidkh7nu7GRvx4uAtN1TExXpU5ogiseNdtkBqAd+XTa4o4T+i
         6m+gE4bgJE80MWGKgWAPp3/RYz24JYm0ixuUQjEU6kcuUHHB792358wGsb2hvS82eS0D
         SwVZnWTKKbFm2bYUuQ9BGilwclOgGcVyxd4nyEJdGRO3TfNnlhuWGtmSbXQkHyQoDAzM
         k164/OCmHYhOoJ4XvJOaCUtUfe20QBXK+I7IoOydV5DMNvO7t7o/FB940ton7WmElFzb
         bw7DvnKlhepp2Zv8wdyo1jgk5KpmGiwwmCekFlbrK04XrXK5EuL6ji2BwswJ0MF7GM/I
         Zq6w==
X-Gm-Message-State: APjAAAX4ULB/v5tmtAsEzQmiCtHE3jBmKkpPThtmka6vFG27/tu0eXQC
        ATZH5Di168k0lBUsvDqZzRo=
X-Google-Smtp-Source: APXvYqxSLksYseNfAAHgFZiEr9oSV2eBsbTrb1BvfSbbW3C0FBw9Cjbx4fxEDiOliFFDJp1rWnYppQ==
X-Received: by 2002:a5b:305:: with SMTP id j5mr23076995ybp.256.1568202622808;
        Wed, 11 Sep 2019 04:50:22 -0700 (PDT)
Received: from [192.168.1.9] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id n85sm4299590ywd.17.2019.09.11.04.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 04:50:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] doc: small formatting fix
To:     Cameron Steffen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Cameron Steffen <cam.steffen94@gmail.com>
References: <pull.330.git.gitgitgadget@gmail.com>
 <5248e3332c90e91c1c6a911090d331f005789014.1568071262.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <56b90e69-a1b2-fcaa-d300-8962565ef87b@gmail.com>
Date:   Wed, 11 Sep 2019 07:50:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <5248e3332c90e91c1c6a911090d331f005789014.1568071262.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/9/2019 7:21 PM, Cameron Steffen via GitGitGadget wrote:
> From: Cameron Steffen <cam.steffen94@gmail.com>
> 
> move an incorrectly placed backtick

The change below is simple enough, but we prefer using full sentences in the commit messages. This includes capitalization and punctuation.

Thanks,
-Stolee
 
> Signed-off-by: Cameron Steffen <cam.steffen94@gmail.com>
> ---
>  Documentation/pretty-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 079598307a..b87e2e83e6 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -208,7 +208,7 @@ endif::git-rev-list[]
>  '%GP':: show the fingerprint of the primary key whose subkey was used
>  	to sign a signed commit
>  '%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
> -	minutes ago`}; the format follows the rules described for the
> +	minutes ago}`; the format follows the rules described for the
>  	`-g` option. The portion before the `@` is the refname as
>  	given on the command line (so `git log -g refs/heads/master`
>  	would yield `refs/heads/master@{0}`).
> 
