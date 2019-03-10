Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A3C20248
	for <e@80x24.org>; Sun, 10 Mar 2019 10:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfCJKJj (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 06:09:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52668 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfCJKJi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 06:09:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id f65so1558230wma.2
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nVc3hqYPAxorr9OBGzUHBb4PC7RCRGZ8mnQAWZ6omoo=;
        b=ON/JGCrk6/feeShic6yk973CGJ5FK5ocYCQUYUZyypptD1XT8swyexMXavQhUiNIWI
         UQOfFlxnGWGvvPrsv9E1rZaK/AjtYmxBF5yF9pjoSKUOWST+hsh2ys2g3FU8fxCCHFuL
         CrFL5GuGaU5wJ0GfsoBsI+AIUOuyJvQcCbNjUtPgSx4IPVXK+nMTisDCieEAO8q/GYeU
         sxOOK/Le5Q8CRMH561CiXJTyMWSvVZmv+j7HgXe7K10JO1fqlsAq1rqNF90+utUPCsEF
         05/YVjrhfN1dGHN00XogJB5kdueXbJ0de6wbilfGXeXm+i2j8HDxFVtEDRs2voWy71TP
         mUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nVc3hqYPAxorr9OBGzUHBb4PC7RCRGZ8mnQAWZ6omoo=;
        b=ozbTNZmk0sYu0ylFG8cQNtve9ye6sG4RDiyDWlQdrE2ykiKh14HY3rjqpwQj8MSgMJ
         +Nebs8lcXWU7Z2+KD0QhWmYOCqOobNypFu/bHXBLWgrwfngkwayZdVAz+6Sos9ipFoLB
         NdxjiqEcXubYwukfVPXNsl7N6EEfg0w8pzP6Y4vyIwkSlvprxJGlaQ2cnL+9noIyP9mU
         T4v1hT5fr6GlfWJa7I1uPwalY3K8gsvvusLB3UVM21tMoQyttvyi3uYwOzq0Gk0QrVH+
         WfQhVGedV0bkvPNm6BT7IJtlRlFz/IPd0gmXZ8d1oJoHrFRjQOb4/H47N2N0+IjnuUgA
         8ifQ==
X-Gm-Message-State: APjAAAWnmUuGZ682qhzTovkS45DTKMcUhJbkQsvyLmQRqDUQkvjAHHYd
        SrRCGXfmsMupyDhwtO94/GjrnWNenuc=
X-Google-Smtp-Source: APXvYqyhjTIR/NoRFrYFRkBDbT+xQtgtIvFV2WKMafBKpvqXFkBtYhe8M0pPEPVyWMaIylrYdvMoVQ==
X-Received: by 2002:a1c:5fc5:: with SMTP id t188mr13709393wmb.86.1552212576838;
        Sun, 10 Mar 2019 03:09:36 -0700 (PDT)
Received: from [10.33.1.6] ([185.230.127.241])
        by smtp.gmail.com with ESMTPSA id d15sm10636226wrw.36.2019.03.10.03.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 03:09:36 -0700 (PDT)
Subject: Re: [PATCH v3 19/21] t: add tests for switch
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-20-pclouds@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <e27faf58-16f4-4f53-1afa-7c5cea868b50@gmail.com>
Date:   Sun, 10 Mar 2019 11:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190308095752.8574-20-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/8/19 10:57 AM, Nguyễn Thái Ngọc Duy wrote:
> ---
>  t/t2060-switch.sh | 87 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100755 t/t2060-switch.sh
> 
> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> new file mode 100755
> index 0000000000..1e1e834c1b
> --- /dev/null
> +++ b/t/t2060-switch.sh
> @@ -0,0 +1,87 @@
> +#!/bin/sh
> +

[snip]

> +
> +test_expect_success 'switching ignores file of same branch name' '
> +	test_when_finished git switch master &&
> +	: >first-branch &&
> +	git switch first-branch &&
> +	echo refs/heads/first-branch >expected &&
> +	git symbolic-ref HEAD >actual &&
> +	test_commit expected actual

s/commit/cmp/

> +'
> +
> +test_expect_success 'guess and create branch ' '
> +	test_when_finished git switch master &&
> +	test_must_fail git switch foo &&
> +	git switch --guess foo &&
> +	echo refs/heads/foo >expected &&
> +	git symbolic-ref HEAD >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_done
> 

