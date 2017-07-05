Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDB0202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbdGESSD (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 14:18:03 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36731 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdGESSC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 14:18:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id u36so33133670pgn.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UWw16UiOzUnOVVEaxCqUwA3iXHZit4ZD2szs1+lCfUc=;
        b=CTPtJ17vylV8mLzWgfUYr7/qN6N3X6JPhVUZVfgJwOwp+sw3GBRqoxEHbrK7ro9Su6
         tz18m84RCqG6tZ47ewneGDK5ByJyu5efMLau7r5Mi2LPkX2afpFrvm0cVmkjfERkFgWF
         0L4DYFDdFJftvFTGzGBTsSVPtT4J8Y6QYYBnXdVK4lgg+VpRCZOL30FhQga2dTAB11IV
         h45gqw/rpPAzS7ZP7FGl0a56An8PQo5mnxX3a+62Vou2aavKhprXt6BO0CnOjLWpbfea
         G0a71iDN6br3xCveA8YjdZ1oAOfw8dAX3+yJwxrzH64FcaPouUfbtWavw6g6ru86xJPi
         FeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UWw16UiOzUnOVVEaxCqUwA3iXHZit4ZD2szs1+lCfUc=;
        b=J0FPBH9csL2cjrKM0WOXiLy+PVSqvxRM8YtA9rneUtpcD8ImRtiG2hbDaS6scW90T7
         98K7Xf2puQW/eAFz2YLNi0foTo+VxtQmzNPOBCu5bI12btRc0efOjDRCAGPgLIV55N7g
         TK+c0vJzcf1MOAc3V6VIwa9jpvNDXqrbFDSo0tCbmphMAsGzdzJoJKYIlioWlJCTigMW
         SCul/IDmVEAKxYpVDFRHTtZ0LYEIqcSnC07sEpXONJT0Qn4gZgquQCXZEvGOL8fDdB7D
         5KKV8tL1SfjivG7V83Z3DvRZiFVTmMnjLG2jLD4TAHO1N8Av4ElO8O7USohScrzzCvZ4
         jk1Q==
X-Gm-Message-State: AIVw112nyVI6O0VrshuoPmkBgdSObRq8WPDCbRL0YwVEhkFj0UeocwEm
        3FtdxshNS9dJDQ==
X-Received: by 10.84.149.197 with SMTP id a5mr23318008plh.3.1499278681952;
        Wed, 05 Jul 2017 11:18:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ad13:9505:c2bc:e887])
        by smtp.gmail.com with ESMTPSA id p65sm53167736pfj.8.2017.07.05.11.18.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 05 Jul 2017 11:18:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] comment: fix a typo in the comment
References: <20170705170324.21026-1-kaarticsivaraam91196@gmail.com>
Date:   Wed, 05 Jul 2017 11:18:00 -0700
In-Reply-To: <20170705170324.21026-1-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 5 Jul 2017 22:33:24 +0530")
Message-ID: <xmqq8tk2iw87.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> ---
>  Though very trivial, I wanted to correct this as I didn't
>  want to ignore it after seeing it.

Thanks for sharp eyes.  Sign-off?  (or Sign-of? ;-))

>
>  builtin/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 8d1cac0..aff6bf7 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -984,7 +984,7 @@ static int rest_is_empty(struct strbuf *sb, int start)
>  	int i, eol;
>  	const char *nl;
>  
> -	/* Check if the rest is just whitespace and Signed-of-by's. */
> +	/* Check if the rest is just whitespace and Signed-off-by's. */
>  	for (i = start; i < sb->len; i++) {
>  		nl = memchr(sb->buf + i, '\n', sb->len - i);
>  		if (nl)
