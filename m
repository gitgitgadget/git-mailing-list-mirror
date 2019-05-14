Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF321F461
	for <e@80x24.org>; Tue, 14 May 2019 09:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfENJo5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:44:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43508 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfENJo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:44:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id w33so21941485edb.10
        for <git@vger.kernel.org>; Tue, 14 May 2019 02:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=5ymzGF0io3IDo1uOD6g/2X6FtBc0BHqdooqRD84Vc3E=;
        b=TSTJ189otB0p856K8zL6bbCGuTuCdmT19MkP/0Jlw3rHu1R/X0193ckOURqJqjrIDG
         gb4mYRYt5mjiZ9+ITHW2YwgP4A8Q2G2rXAT6mNqczR0GprlUCGTkiGy8C/kkU+ISd7iT
         k7KKBThgPZ4n/Piv2rBm2IBx/INB6RGR3sYwaEAjxqrRBEE742VEkJMzYdy67tFfv3xC
         NRirPW/RpSD4HcqLqFQNpHdtuL53PfqkOrDCze8cqtK6mSdvY2wbjr6DNx8LIhFhZ7aR
         KreDW5Oz9ZbKvBv1oeEsiSEfAiq8IIVVnTAUCsnUKBY3GGps9WkyxfQG/VE7GNqrob1R
         /+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=5ymzGF0io3IDo1uOD6g/2X6FtBc0BHqdooqRD84Vc3E=;
        b=PXtWL81tJg1TO/WNkfSn264EW76vrBuaWyjtwXJ28UoAvyySV9a+rZijYyr+98ZGzs
         H60YZofC0Drm0haEWMspk8iiqxOkTs7NSvQZLBERE37ahbiUbkSEkOIE+C8fsul4SsAk
         SAGbfxLl80wTmNlDu+dqMG7hCOCrayYj8cuHqorwAIoTvl4IiR0MGvdV9B6bNSnqChSn
         G0D8uYxQRqQaP2hpJcXqRHJffvxql44xU5zFPxeK4PcTyHU9xjfTzX7RkqCzMDA+heSW
         jGS8lM9VHTAThwEoNMj2e12MX1W30PO/SD3dAADPhHB21Dd6DAgy0CaRxoJV7TzvXEGD
         oMPQ==
X-Gm-Message-State: APjAAAXraetdpyz6YO2pwepTzAeHit39QK6F3+ba05yQ3yv13d0zosgs
        oVF8kfhq5BrPBoflGjEZEH4=
X-Google-Smtp-Source: APXvYqw070rl0E3B6yW6lQq/l48FkV2JY0JRvFLnYnmVbbI5qlJsWFBIyLtBlgQ8TgpBShhbDjjT2A==
X-Received: by 2002:a17:906:61c3:: with SMTP id t3mr8194734ejl.273.1557827095498;
        Tue, 14 May 2019 02:44:55 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id f13sm2022192eja.17.2019.05.14.02.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 02:44:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] stash: document stash.useBuiltin
References: <pull.193.git.gitgitgadget@gmail.com> <6c250451658f34c1415bfcba35ee6303cecac0dc.1557825553.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <6c250451658f34c1415bfcba35ee6303cecac0dc.1557825553.git.gitgitgadget@gmail.com>
Date:   Tue, 14 May 2019 11:44:54 +0200
Message-ID: <87k1etwesp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 14 2019, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The stash.useBuiltin variable introduced in 90a462725e ("stash:
> optionally use the scripted version again", 2019-02-25) was turned on by
> default, but had no documentation.
>
> Let's document it so that users who run into any stability issues with
> the C rewrite know there's an escape hatch, and spell out that the
> user should please report the bug when they have to turn off the
> built-in stash.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/config/stash.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
> index c583d46d6b..d7bf6ec61f 100644
> --- a/Documentation/config/stash.txt
> +++ b/Documentation/config/stash.txt
> @@ -1,3 +1,18 @@
> +stash.useBuiltin::
> +       Set to `false` to use the legacy shell script implementation of
> +       linkgit:git-stash[1]. Is `true` by default, which means use
> +       the built-in rewrite of it in C.
> ++
> +The C rewrite is first included with Git version 2.22 (and Git for Windows
> +version 2.19). This option serves an an escape hatch to re-enable the
> +legacy version in case any bugs are found in the rewrite. This option and
> +the shell script version of linkgit:git-stash[1] will be removed in some
> +future release.
> ++
> +If you find some reason to set this option to `false` other than
> +one-off testing you should report the behavior difference as a bug in
> +git (see https://git-scm.com/community for details).
> +
>  stash.showPatch::
>  	If this is set to true, the `git stash show` command without an
>  	option will show the stash entry in patch form.  Defaults to false.

Thanks for following up on this. LGTM.
