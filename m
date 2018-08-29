Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BA2E1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeH3BDX (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:03:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36763 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeH3BDX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:03:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id m27-v6so6094626wrf.3
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=69K0ou4GQCXEJaCc5VmRmQdHUJb4KVZAQmGKBRKvQbM=;
        b=bY1ugoj69+HmC3hDeVNxlAKxJwFu50TnvjYb1hqHra6TkyeaqDFQl+rQccdvBkp1aU
         6s/KNhuZo+/zEyKPA23L7Zx0hYNWOMz6uFKmLtkm78JYGfopc8alTTYduxkciOn9MMag
         yeMVcPYaqQo90Dxx3k0F25CwWKu75nW9mxZVZXtCLr9S8ojkO6VcUEAO/yW8oOhgnJpb
         tDsJpIxbwTjvaBd644mL9gy2nGg4/lBsoQ7ttBP6MDeWNk//EgFOY+apQO6BxWvChm3F
         qOGsaxFyWO5eTHD4L2bPDXUg0Oqf3tZMHOnGYtMd4G2ZAZuDoy1pbjCoWCHfewnac6aJ
         VYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=69K0ou4GQCXEJaCc5VmRmQdHUJb4KVZAQmGKBRKvQbM=;
        b=t1M7zHVlNwEKvFO7vzkOSb9lADivrvM2Kp1mq7IKQiwZeZhQCe5yTOcNBTAY2QBIBV
         Kk7ubpds+4NwpaBpQsWhs0+3741CVGPF20JpD+4Pm33oZonDd2HkFswjRKchM+bhQQIi
         NPH662ypM/+4fHlhLezJDFjIWFmgHHBZBIia71GMIQOyuXY1Rn/cxqrydmuUEOWt5rsO
         BAXzpThKmAc7jdCp/LxE+jvdCz8FbwLE3dD7MzZu1DZ4SvIY08cYdOqRFoB6VVTpcUtf
         e2fWy06Pd4awvhEdVRcgZKDExuaMuTxHVC8tXa7CdS2Eb9v5o0s1Ha/l4B3aJSXvNctd
         PRVQ==
X-Gm-Message-State: APzg51Bj35E4Pp5A4b8UO/xGbkV2vog3OdOQI1J6IOxIfs7h0MzybNpR
        WskfxnvFMLBTcWfzZ3RjPwQSLFc+
X-Google-Smtp-Source: ANB0VdZbJd/Vw+SY5tb/ufvtQFXT+W4AbSRNXF8oOHyX9p4YzXAMdOPaxSTX2G8MaWz3uTrSi4gzwg==
X-Received: by 2002:adf:9b11:: with SMTP id b17-v6mr5780399wrc.119.1535576682382;
        Wed, 29 Aug 2018 14:04:42 -0700 (PDT)
Received: from localhost (62-165-238-163.pool.digikabel.hu. [62.165.238.163])
        by smtp.gmail.com with ESMTPSA id k63-v6sm8881783wmd.46.2018.08.29.14.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 14:04:41 -0700 (PDT)
Date:   Wed, 29 Aug 2018 23:04:36 +0200
From:   SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] t2013: add test for missing but active submodule
Message-ID: <20180829210436.GA31707@localhost>
References: <20180827221257.149257-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827221257.149257-1-sbeller@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 03:12:56PM -0700, Stefan Beller wrote:
> When cloning a superproject with the option
>  --recurse-submodules='.', it is easy to find yourself wanting
> a submodule active, but not having that submodule present in
> the modules directory.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t2013-checkout-submodule.sh | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
> index 6ef15738e44..c69640fc341 100755
> --- a/t/t2013-checkout-submodule.sh
> +++ b/t/t2013-checkout-submodule.sh
> @@ -63,6 +63,30 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
>  	! test -s actual
>  '
>  
> +test_expect_success 'setup superproject with historic submodule' '
> +	test_create_repo super1 &&
> +	test_create_repo sub1 &&
> +	test_commit -C sub1 sub_content &&
> +	git -C super1 submodule add ../sub1 &&
> +	git -C super1 commit -a -m "sub1 added" &&
> +	test_commit -C super1 historic_state &&
> +	git -C super1 rm sub1 &&
> +	git -C super1 commit -a -m "deleted sub" &&
> +	test_commit -C super1 new_state &&

These six consecutive commands above all specify the '-C super1'
options ...

> +	test_path_is_missing super1/sub &&
> +
> +	# The important part is to ensure sub1 is not in there any more.
> +	# There is another series in flight, that may remove an
> +	# empty .gitmodules file entirely.
> +	test_must_be_empty super1/.gitmodules

... and both of these two checks use the 'super1/' path prefix.  I
think it would be more readable to simply 'cd super1' first.

> +'
> +
> +test_expect_failure 'checkout old state with deleted submodule' '
> +	test_when_finished "rm -rf super1 sub1 super1_clone" &&
> +	git clone --recurse-submodules super1 super1_clone &&
> +	git -C super1_clone checkout --recurse-submodules historic_state
> +'
> +
>  KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
>  test_submodule_switch_recursing_with_args "checkout"
>  
> -- 
> 2.18.0
> 
