Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001A31F453
	for <e@80x24.org>; Mon, 24 Sep 2018 13:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbeIXTdb (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 15:33:31 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37416 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbeIXTdb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 15:33:31 -0400
Received: by mail-qk1-f196.google.com with SMTP id c13-v6so11137834qkm.4
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=sgMnmofaDBJrEx0plFo6eHPuoblZYBPYyoOWOGahYLs=;
        b=DmEQzgSidFRWvEOyn+eqSMOQOJhjBiXRaV2YFSgJBkxnPJiIRS9gwh6anlKy5L6XfC
         WL0A0eJcgi0GJeqHrgMahulJQbOklBhptlJielQ+0zaO6vFoSU8aneMYxWWXMd28RNtv
         2ANEIx2behdfeszFOwwqO9D3ryK6XWahvgCbKoi7diAQPtpLS+dEYrWMNe/KCIgal+DY
         nbSIWWkf+BD5zr7UyI3s5slkyL+CUkjAWvQWBD/wmfslU8moFzXk3uoruEooC+KsIQjW
         sxhLft64T6hiSOMX0t3FQ9I6gmlo6EFvKI93J/dtMYukGkVhE2dulFxGHfCkAeT413Wz
         iV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sgMnmofaDBJrEx0plFo6eHPuoblZYBPYyoOWOGahYLs=;
        b=c7telXZt0kY50E8c1zREqKoMu3iqJUhgXvHvuZHR8ou71gjsL8qobf2u0htoPDrM8T
         IaBrLaYNSY2E6zCzZrf5Hu8eU7pRSTnyz08yhi//WGQPXlTAbInOlCoPv/qqEUjAwv3x
         TDlGg+Z+4e5T2P/Vhc7POL68R0gCVDgj3MaI2vkq0+MACQq1mcb1Lv+7NCG1RsjkX7Uz
         4evs3C16c7M4KuIYZ7EkTsxxD4oe+VXmNXEQ0blMMuTCqiGfaFRNaKB00OURrUY+zE4o
         TmGXHbf7+nFMjZXqh//68JuoEdyV7DJxqEGdlT5Y0fGYWI9bYgOXHRWxLASYTOj/h5Jp
         XeTA==
X-Gm-Message-State: ABuFfohXvrxyZ+Oqk54w7GR1nQfBFSlvbwXBFK8i6MMeT5o1TDFZYpW9
        dBE0ZQTjieMc7nmRjbV3xlFia7PL
X-Google-Smtp-Source: ACcGV619d89lLIfqDxKvNwNHwRZaO53Ol3SsVofXU40eCwS9xaXQK2Bz1NctxCm67FGs30y7M5LpQw==
X-Received: by 2002:a37:170d:: with SMTP id i13-v6mr831018qkh.125.1537795877955;
        Mon, 24 Sep 2018 06:31:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c0ea:9fdb:fe08:b63a? ([2001:4898:8010:0:aa20:9fdb:fe08:b63a])
        by smtp.gmail.com with ESMTPSA id j88-v6sm21625450qte.49.2018.09.24.06.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 06:31:16 -0700 (PDT)
Subject: Re: [PATCH 1/3] t7001: reformat to newer style
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180921235833.99045-1-sbeller@google.com>
 <20180921235833.99045-2-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7f77be2b-a084-5b8d-df65-1bb4b9c5da82@gmail.com>
Date:   Mon, 24 Sep 2018 09:31:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921235833.99045-2-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2018 7:58 PM, Stefan Beller wrote:
> The old formatting style is a real hindrance of getting people up to speed
> contributing as they use existing code as an example and follow that style.
> So let's get rid of the old style and reformat it in our current style.
I was suspicious of your automated approach catching everything, so I 
looked carefully at this patch. There are still a lot of things 
happening that we would not recommend doing in new tests.
>
> Reported-by: Derrick Stolee <stolee@gmail.com>
> Reported-by: Jeff Hostetler <git@jeffhostetler.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   t/t7001-mv.sh | 268 +++++++++++++++++++++++++-------------------------
>   1 file changed, 134 insertions(+), 134 deletions(-)
>
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 36b50d0b4c1..2251d24735c 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -3,74 +3,74 @@
>   test_description='git mv in subdirs'
>   . ./test-lib.sh
>   
> -test_expect_success \
> -    'prepare reference tree' \
> -    'mkdir path0 path1 &&
> -     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
> -     git add path0/COPYING &&
> -     git commit -m add -a'
> +test_expect_success 'prepare reference tree' '
> +	mkdir path0 path1 &&
> +	cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
> +	git add path0/COPYING &&
> +	git commit -m add -a
> +'
>   
> -test_expect_success \
> -    'moving the file out of subdirectory' \
> -    'cd path0 && git mv COPYING ../path1/COPYING'
> +test_expect_success 'moving the file out of subdirectory' '
> +	cd path0 && git mv COPYING ../path1/COPYING
> +'
Perhaps split this line on the &&?
>   
>   # in path0 currently
> -test_expect_success \
> -    'commiting the change' \
> -    'cd .. && git commit -m move-out -a'
> +test_expect_success 'commiting the change' '
> +	cd .. && git commit -m move-out -a
> +'

This "cd .." should probably be removed and use a subshell in the test 
above where we "cd path0".

>   
> -test_expect_success \
> -    'checking the commit' \
> -    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
> -    grep "^R100..*path0/COPYING..*path1/COPYING" actual'
> +test_expect_success 'checking the commit' '
> +	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
> +	grep "^R100..*path0/COPYING..*path1/COPYING" actual
> +'
>   
> -test_expect_success \
> -    'moving the file back into subdirectory' \
> -    'cd path0 && git mv ../path1/COPYING COPYING'
> +test_expect_success 'moving the file back into subdirectory' '
> +	cd path0 && git mv ../path1/COPYING COPYING
> +'

Split at &&, use subshell?


> +test_expect_success 'commiting the change' '
> +	cd .. && git commit -m move-in -a
> +'

Drop "cd .." (and the comments about being in path0)

[big snip]

> +test_expect_success 'moving to existing tracked target with trailing slash' '
> +	mkdir path2 &&
> +	>path2/file && git add path2/file &&
This line in particular looks a bit strange. What is this doing? At 
least we should split the &&.
> +	git mv path1/path0/ path2/ &&
> +	test_path_is_dir path2/path0/
> +'
> +
> +test_expect_success 'clean up' '
> +	git reset --hard
> +'
> +
> +test_expect_success 'adding another file' '
> +	cp "$TEST_DIRECTORY"/../README.md path0/README &&
> +	git add path0/README &&
> +	git commit -m add2 -a
> +'
> +
> +test_expect_success 'moving whole subdirectory' '
> +	git mv path0 path2
> +'
> +
> +test_expect_success 'commiting the change' '
> +	git commit -m dir-move -a
> +'
> +
> +test_expect_success 'checking the commit' '
> +	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
> +	grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
> +	grep "^R100..*path0/README..*path2/README" actual
> +'
> +
> +test_expect_success 'succeed when source is a prefix of destination' '
> +	git mv path2/COPYING path2/COPYING-renamed
> +'
> +
> +test_expect_success 'moving whole subdirectory into subdirectory' '
> +	git mv path2 path1
> +'
> +
> +test_expect_success 'commiting the change' '
> +	git commit -m dir-move -a
> +'
> +
> +test_expect_success 'checking the commit' '
> +	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
> +	grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
> +	grep "^R100..*path2/README..*path1/path2/README" actual
> +'
> +
> +test_expect_success 'do not move directory over existing directory' '
> +	mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
> +'

Split this line.

Thanks,

-Stolee

