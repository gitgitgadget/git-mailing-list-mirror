Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2BB8207FF
	for <e@80x24.org>; Fri,  5 May 2017 17:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdEERuw (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 13:50:52 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34763 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdEERuv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 13:50:51 -0400
Received: by mail-io0-f194.google.com with SMTP id 12so3003286iol.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ld+jT5twfOWQQft6GEzCGHGxS7b+txDQZs2S/Vct/yI=;
        b=uSPbwZKDWEUq6ws/Cvy6JWFEVWeq64/1+PjiASn2kbRxVyrpQzWg0DYC5xyu43ixKs
         ZwGcrNbhP5WgJn55/HnefssTBylbndzA+0PLjiZp14swq8Q9fBtwm/aywFgcVH/QNaA/
         Y3Ky/VBpRcl+TeGRI3dCLKdO539a2n91Jnwzl7GFmKS27fOJP6m1Kt2m6iLdHoVcaK+r
         2KV6GI2o5VDGFGbLIMITrTXsGS0gbSPBq7g5W9OOzrqVnGfx8rBaGZmWMVBeShuc3Ss+
         Lt/p1aJYC10H/xQBGGCKTqhEMcIg+w998WH9nMxkQ9BcfLybCNtGUTYPCdRAdJ++O3iW
         CNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ld+jT5twfOWQQft6GEzCGHGxS7b+txDQZs2S/Vct/yI=;
        b=bXMD3kqj9M4NxJ2DGqWDHik80t0qLfMUYYffgrH2a0Syk7Zlkz/XwLdU6EgX1ZOXjf
         jLEjwExLa3u/JEApaCo0eVkI4qYAMYlTgmZRIyL2S6BjmvLganTEPSPibNiv6erdPdia
         QuZy6+H6WbFCbygFhtJEzsh7kY1YNYe4U8LBWnMJayrfva3Oh6QMb4tmCkK1IcNSC67m
         tOEeyxeHEU0vxVPWd78JyOA/UwA+oENp57/oGLuVnQBqIGWY74P0w/oKvgc50ATZRlTJ
         tA9DQt3Q3nK4t88p31/mvcHMVk07+aTl0nLCiOUDUVM5SNt2kzskdQ6Tuh0NQWrgLnX/
         7Bxw==
X-Gm-Message-State: AN3rC/51N8qBOuk2SxejCO3H3qbDIRm5AjpFrq4GMfccIIN57cWVtWyy
        g7NPYzvIvbPC+QREW8cbsgLqfu0gdA==
X-Received: by 10.107.138.9 with SMTP id m9mr45920696iod.80.1494006650589;
 Fri, 05 May 2017 10:50:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 5 May 2017 10:50:29 -0700 (PDT)
In-Reply-To: <20170505173841.20555-1-sbeller@google.com>
References: <20170505154053.58128-1-larsxschneider@gmail.com> <20170505173841.20555-1-sbeller@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 5 May 2017 19:50:29 +0200
Message-ID: <CACBZZX6ZzrJk77ReJ592rJrNR1xhVCQid6_5KTonwTot5eq-hQ@mail.gmail.com>
Subject: Re: [PATCH] t7406: fix i18n expectation of error message
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 5, 2017 at 7:38 PM, Stefan Beller <sbeller@google.com> wrote:
> The error message from "submodule update" is internationalized, which
> makes sense. The test however did not check for the translated version,
> but used a hardcoded string, which breaks the test when run with
> GETTEXT_POISON.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7406-submodule-update.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 4ac386d98b..12f6435ab0 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -441,13 +441,11 @@ test_expect_success 'submodule update - command in .git/config catches failure -
>         test_i18ncmp actual expect
>  '
>
> +sq="'"
>  test_expect_success 'submodule update - command run for initial population of submodule' '
> -       cat >expect <<-EOF &&
> -       Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
> -       EOF
>         rm -rf super/submodule &&
>         test_must_fail git -C super submodule update 2>actual &&
> -       test_cmp expect actual &&
> +       test_i18ngrep "Execution of ${sq}false $submodulesha1${sq} failed in submodule path ${sq}submodule${sq}" actual &&
>         git -C super submodule update --checkout
>  '

I have a fix for this in my gettext fixup series (so far lingering on
the list, not in pu):
https://public-inbox.org/git/20170421185757.28978-1-avarab@gmail.com/

The diff is quite a bit smaller than yours:

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4ac386d98b..034914a14f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -447,7 +447,7 @@ test_expect_success 'submodule update - command
run for initial population of su
        EOF
        rm -rf super/submodule &&
        test_must_fail git -C super submodule update 2>actual &&
-       test_cmp expect actual &&
+       test_i18ncmp expect actual &&
        git -C super submodule update --checkout
 '

Do you prefer to use i18ngrep for whatever reason? Seems better to use
i18ncmp there.
