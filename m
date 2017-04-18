Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90C771FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 00:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755458AbdDRAtF (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 20:49:05 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35698 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753768AbdDRAtD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 20:49:03 -0400
Received: by mail-lf0-f66.google.com with SMTP id i3so17889152lfh.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2017 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FkyWQl9hN84dWDx9ARoITOx6wvkp+BoRXByS9RcQMX4=;
        b=KwfWN4IDYA5jhqUzZyA64HvO0s/Jg+1rrFM/CUOrBYMS+YvG7BGbrQ5Nwks5VdXN5H
         1lakm3mWUa+V0tTWrFLTGDtQK7b1v9kkD71haaZA9Tsk8gLHmw5u/92UbyuNl1HYjSNv
         1sVV78Cc4wHpeTxjuheiZ4CzQRDY92s3wYgDIYBLkFe7W7nG5rsu7ZtH/YLynCdESR1k
         SsyeCycdUfKBVH3lqkkyavATkT2YB9RnqmNMCiQ8ScCBJhxEDv6OXeM+9WF/Uga+MaCo
         hd6gelA5lHOeK9uba+9+ec/21oIrTuerPYaaiF/ns6b9v6V53z2DR26Bo4nj3ZVkYnWk
         QQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FkyWQl9hN84dWDx9ARoITOx6wvkp+BoRXByS9RcQMX4=;
        b=OehbbljswGc39xCvHmOth9gK+dVDPvQjq5qBMklKt+jIH6xN0MLV18LlLtIyYyDjaP
         kAy9eCdGMVrBVvIKA4Y23vzXmO99uu+dClK9cyaMvuRpfivM1fH69ipKXjAyF1Kkl4Dy
         Ibc4Oa4e1e1/1i3HjTnstApk9tzFONWdcf36DSgOPWf2Ifeo3pfH/sJRQ3g9r+/ECvXI
         BEAciu3sA9rvVDiaQtWyvM5cZgb4Ndwc8ETP55mTDVA3P6gCyT6K5VZi8W6WCbtbK4Ra
         iG4sGiN6YZrkE+yVPAESAct1T9km7U6+rF6HEjDV0E+LYiGBVLxxBBBCjM1AKZ5mtDa6
         JDcg==
X-Gm-Message-State: AN3rC/5Gew6ulUzh0Hn8RYRl4qi7jBD4o+go6Mi3qkc6NH8jEtqf+sJw
        jcuUEBi4pV/8QAkkbajC9+R0b+Jn3w==
X-Received: by 10.25.153.137 with SMTP id b131mr2920634lfe.114.1492476541998;
 Mon, 17 Apr 2017 17:49:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Mon, 17 Apr 2017 17:48:41 -0700 (PDT)
In-Reply-To: <20170417223253.2934-1-giuseppe.bilotta@gmail.com>
References: <20170417223253.2934-1-giuseppe.bilotta@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 17 Apr 2017 17:48:41 -0700
Message-ID: <CA+P7+xqiMC-_wsTc7J+2ebAze6T-YXqm9UzdPKOkZJa=643=GA@mail.gmail.com>
Subject: Re: [PATCH] doc: trivial typo in git-format-patch.txt
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2017 at 3:32 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  Documentation/git-format-patch.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index f7a069bb92..c890328b02 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -557,7 +557,7 @@ series A, B, C, the history would be like:
>  ................................................
>
>  With `git format-patch --base=P -3 C` (or variants thereof, e.g. with
> -`--cover-letter` of using `Z..C` instead of `-3 C` to specify the
> +`--cover-letter` or using `Z..C` instead of `-3 C` to specify the

Makes sense. The wording is now "if you use either cover-letter or you
use Z..C instead of -3 C ..."

Thanks,
Jake

>  range), the base tree information block is shown at the end of the
>  first message the command outputs (either the first patch, or the
>  cover letter), like this:
> --
> 2.12.2.819.gfd8aacebd5
>
