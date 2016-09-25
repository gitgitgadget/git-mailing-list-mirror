Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231591F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 14:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966403AbcIYOnP (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 10:43:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34064 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966241AbcIYOnO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 10:43:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id l132so10212198wmf.1
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=la6/olxhKXvBt/lFfUBOffvreU0ekIkU7LTuaWdCDU0=;
        b=uxZgBr8OIDJ/zoEB/4HN0E5eId4amInQO05XTKpoGZf/U1avr57ctQKtMrBDYwjY7s
         R069DFmrZYHS6WUL3hFSe1REEKjGlwK07jUlViQTVn2SfJ/eQHr1cfhpwkyMSdHuHWO1
         EY+oCnaVrqhXDPNRJrpflfm4aBSV2jHa2q6R3iDv86RTpxKXD3wYptMUwAV+Ha3Khll/
         t+/4WhWnQlbLXcAC90oD6SKvDsYlTaV94lien01fKxFxfNkNCOR+GgnyQwrG7wNNU2/f
         orllskXfPRwHkrdHAU+KNyiFGRg1lEiQ2N53yFy39l6JaYK52oo7kmBmVD9TkhFcqRkI
         5wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=la6/olxhKXvBt/lFfUBOffvreU0ekIkU7LTuaWdCDU0=;
        b=nLA2FIVYrDwrNxQ3yt7gFatUrZLd15Lry1RPyHTi1KWy40/fbr3wymA0+zzm2NljNv
         e9GKtnFmFI8hJDZA31K+AafEsSAza7zv63KVrN/N4qakvvkQqBy+2RUUxSHWnAMNYu9s
         GXvIWrrkaRy7TZeOOx4WP2CMa+oxX9+0qopd+TFlBmhxn2fdm5axLtNhFmpLvjfPLw9B
         jREjsv21Y1JjHgWS3Wz6zjCRfUlnkZ7oYwFSfXmV7Q7ClNsSq+V8B/taTfepfxqFfuzF
         M1mCji042n/M1i0FIhEks9df+mZWzDp/mWzcam683UIeFktsPm5ZSZhZargWxlOHULOi
         MK9g==
X-Gm-Message-State: AA6/9RlfUps4UWYVrYPU8cIdin5z7rM2oegH17NT4kLWZh5n2u7TwU/F3nGhT1AdqDOwuQ==
X-Received: by 10.194.200.6 with SMTP id jo6mr5305057wjc.77.1474814592632;
        Sun, 25 Sep 2016 07:43:12 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id r195sm520698wme.10.2016.09.25.07.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 07:43:11 -0700 (PDT)
Subject: Re: [PATCH v8 09/11] convert: modernize tests
To:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-10-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <1e2aac1a-b25d-d747-7bf6-6f842b3e438d@gmail.com>
Date:   Sun, 25 Sep 2016 16:43:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-10-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Use `test_config` to set the config, check that files are empty with
> `test_must_be_empty`, compare files with `test_cmp`, and remove spaces
> after ">" and "<".

That's good.

> 
> Please note that the "rot13" filter configured in "setup" keeps using
> `git config` instead of `test_config` because subsequent tests might
> depend on it.

This is good information to have for doing review (which could include
"post-mortem" review during bisect, so it should be in commit message
proper).

> 
> Reviewed-by: Stefan Beller <sbeller@google.com>

I have not reviewed this patch in detail, but it looks good.
A bit of nitpicking below.

> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/t0021-conversion.sh | 58 +++++++++++++++++++++++++--------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index e799e59..dc50938 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -38,8 +38,8 @@ script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
>  
>  test_expect_success check '

This patch is "while at it" already for this patch series, done
I guess for new tests to both use modern style, and be consistent
with the rest of test...

...that said, if you could modernize _naming_ of tests.  The t0021
test is quite inconsistent, and uses:

 * standard short names, like 'setup', without quotes (once),
   which is I think all right
 * cryptic short names, like 'check', without quotes (once)
 * snake_case name, like 'expanded_in_repo', without quotes (once)
 
>  test_expect_success "filter: clean empty file" '
>  test_expect_success "filter: smudge empty file" '

 * double quoted names (twice, see above)
 * proper modern names, with single quotes (the rest),
   which is as almost all the rest should be using

Best,
-- 
Jakub Narębski

