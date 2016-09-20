Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DE3F209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbcITT2L (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:28:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34279 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbcITT2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:28:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id l132so4992332wmf.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uILQjeHe4D6Mf7fVVOfgUM1cjVqb17RrQNA9nhiv7WY=;
        b=REBUSrr+QNRVIUveFRkiSGHEQc0t4P813Bvg1PecDIViBAA1QhgVoA+123DsbNRUnU
         AbJMPXIoVjmdmHw/c0JMD/5ebxWdIw/1+AW83TYkFGor7jo8aqdSX9gJ2AoBUP7oSvOG
         qHKnpaPXKH4aF/D9p9LFjRqaXs1KGI2Gr9aa/bLuBlQQFKRoq/gsG2cCl8ya58x94djX
         tFJ/oeUZM32+vki/eGMYcts9KmM6sE3/1To+SapTPyC43/gSflxfOEnDqX/IShdQtccu
         6dpcdd8RTMiJxtmopXZta6GkvWsQI3A6gLFVzXu9D7QfwnK2hpzlZ85dJA0gD1X4mdm/
         boxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uILQjeHe4D6Mf7fVVOfgUM1cjVqb17RrQNA9nhiv7WY=;
        b=Y20x6R2uMY8XjmaFIwrEtbHu9iHLFtX5NWPhCxzM3pmA9u2Ec5JIZO2P/XIdv4EhUp
         SJkxXOnIYXseM8EVWzeyw7m4Tk/btFRKKmPggAE9uZNrv6C2mkqylI3NxkTmB5SdmoUe
         6Rv1981FI1oh3sU7dqeDoSgXpmioMhqG8jmg0SR1mHFTWNkNbFBv07PvKUQH39+M8L1W
         zWCXAliJV95/VW+fqklnSx1dcMgHVlzUwTb2M9gUc8WK/LAPGSDZh1M/oJ8jo/yeNQMi
         3B5vwS9X8VR8ZRqr8u+4PDALqOi+K173NIxlAKKKGJXGVU/BBkVO+dqgJf/HSZhZvhrn
         Agkg==
X-Gm-Message-State: AE9vXwP7Xw5znLieebIeRgVTSK0isfvvTRZaF1/ajoI+v+wtEQnDRm+izijzVTLCmbMb3g==
X-Received: by 10.194.0.116 with SMTP id 20mr29922841wjd.123.1474399688840;
        Tue, 20 Sep 2016 12:28:08 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id bo7sm29874996wjb.28.2016.09.20.12.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Sep 2016 12:28:07 -0700 (PDT)
Date:   Tue, 20 Sep 2016 20:28:28 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH tg/add-chmod+x-fix 1/2] t3700-add: create subdirectory
 gently
Message-ID: <20160920192828.GF8254@hank>
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 09/20, Johannes Sixt wrote:
> The subdirectory 'sub' is created early in the test file. Later, a test
> case removes it during its clean-up actions. However, this test case is
> protected by POSIXPERM. Consequently, 'sub' remains when the POSIXPERM
> prerequisite is not satisfied. Later, a recently introduced test case
> creates 'sub' again. Use -p with mkdir so that it does not fail if 'sub'
> already exists.

Thanks for catching and fixing this.  Having a look at the tests shows
that this happens through a git reset --hard at the start of the tests
that require POSIXPERM, which makes me wonder whether we should do
such a cleanup somewhere unconditionally, or move the tests that do
require POSIXPERM to the end of the test file to possibly prevent
similar breakages in the future?

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t3700-add.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 0a962a6..16ab2da 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -380,7 +380,7 @@ test_expect_success 'no file status change if no pathspec is given' '
>  '
>  
>  test_expect_success 'no file status change if no pathspec is given in subdir' '
> -	mkdir sub &&
> +	mkdir -p sub &&
>  	(
>  		cd sub &&
>  		>sub-foo1 &&
> -- 
> 2.10.0.85.gea34e30
> 

-- 
Thomas
