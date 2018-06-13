Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377651F403
	for <e@80x24.org>; Wed, 13 Jun 2018 05:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933982AbeFMFnB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 01:43:01 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:45216 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933685AbeFMFnB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 01:43:01 -0400
Received: by mail-yb0-f194.google.com with SMTP id x6-v6so480331ybl.12
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 22:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LFljnXJFLbwGuOtJXZyMJLBJrC7Yl3kkY+JJ0UUS/WQ=;
        b=IOU2dbogpWnq4CPsdLjHf4Wc02WQEiG8rznAbtegoilA5Y4AmdrzJLIQ+go6TTtfIA
         IqK9Gk5O07kK3ymiezgfwi75gTenTApj7Swq1feGgrgVI6qJJ0dTAIbpSIpE3bYc1pWb
         oeGUegP27s861gtSbfa2JMMMfMePaXkbZSEb4BXzxzHt21MSAPk3E89pEVMfGHt7V1Qa
         kCbj5DdL5IiD75A3APvCFc+4FE0RAlpN5cZv9tQZsif6TVgBIPHmyNvkWE/0GUPNDG8K
         G5yvTzzs70g1PKXl2ARoTy/mIuY5J/7+6eE8xPkcG92Sj68UAkzyDPrl7jMxP8ITU88r
         Su/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LFljnXJFLbwGuOtJXZyMJLBJrC7Yl3kkY+JJ0UUS/WQ=;
        b=Nlhze6sDXlzeHrGLm9bxxtqbW7Cut97MEmz8KJMxPwhKWHRUzua9eMOgNdM9U6UhlL
         WsoR2RvMcErva3I+YZHT8vXVJu7PX8XXpOnjvDCE67bxAfCNBb7Vb04HZqliuM3eRPn7
         VYMq3UozQRZ/NQFu8CNNmz+8GezYrUn41yS4f0JWISe8AmEZAvONXaF1dEE1qPl1zsVc
         zNJ2Qbwul+vQy8xqog9DAwsiLToyzY7MYFdtHohiT1M8C+N60UMaW2wAEXQGM0tf+Img
         UkxUURgKUtZ1k702sfZv7Ibjia4F1aEV7/SEYIj382AAa2U/dNiHIN+eGIC5jhNULixz
         yhjA==
X-Gm-Message-State: APt69E3VlbORj5Z5h0v4ffI3bfPOyXCQM6WSXWBsf8jJ1Lyr4RTrBfWp
        qb19qqEntHJ5TR1d+/o+nHU4719NFiVEWdrk7Lc=
X-Google-Smtp-Source: ADUXVKLLChhHGdO4KzDOpfDKE2yo9tvyWnPDEdTpgzSoot6BuejPiMWo9IfQrFY/VOAg+sk2zYcWszB8hhIQCad45gM=
X-Received: by 2002:a25:8751:: with SMTP id e17-v6mr1643545ybn.194.1528868580468;
 Tue, 12 Jun 2018 22:43:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 22:42:59
 -0700 (PDT)
In-Reply-To: <20180613031040.3109-3-tmz@pobox.com>
References: <20180607051958.759-1-tmz@pobox.com> <20180613031040.3109-3-tmz@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 13 Jun 2018 01:42:59 -0400
X-Google-Sender-Auth: QCHTS7fswWztzk_gJcmgj0_yLkc
Message-ID: <CAPig+cRcPD9vh1WMX7UkiD9R_A-DrybvOYwi3R8U2bskfOV_1w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] git-credential-netrc: minor whitespace cleanup
 in test script
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 11:10 PM, Todd Zullinger <tmz@pobox.com> wrote:
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> diff --git a/contrib/credential/netrc/t-git-credential-netrc.sh b/contrib/credential/netrc/t-git-credential-netrc.sh
> index 58191a62f8..c5661087fe 100755
> --- a/contrib/credential/netrc/t-git-credential-netrc.sh
> +++ b/contrib/credential/netrc/t-git-credential-netrc.sh
> @@ -17,15 +17,15 @@
>         # set up test repository
>
>         test_expect_success \
> -    'set up test repository' \
> -    'git config --add gpg.program test.git-config-gpg'
> +               'set up test repository' \
> +               'git config --add gpg.program test.git-config-gpg'

Since you're touching all the tests in this script anyhow, perhaps
modernize them so the title and opening quote of the test body are on
the same line as test_expect_success, and the closing body quote is on
a line of its own?

    test_expect_sucess 'setup test repository' '
        ...test body...
    '

I also changed "set up" to "setup" to follow existing practice.

(Not necessarily worth a re-roll.)

>         # The external test will outputs its own plan
>         test_external_has_tap=1
>
>         test_external \
> -    'git-credential-netrc' \
> -    perl "$TEST_DIRECTORY"/../contrib/credential/netrc/test.pl
> +               'git-credential-netrc' \
> +               perl "$TEST_DIRECTORY"/../contrib/credential/netrc/test.pl
>
>         test_done
>  )
