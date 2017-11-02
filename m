Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87B87202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 00:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933001AbdKBAHa (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 20:07:30 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:56968 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932433AbdKBAH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 20:07:29 -0400
Received: by mail-wr0-f196.google.com with SMTP id r79so3403894wrb.13
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 17:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=k/Bs2H3pXS0ZpecMHT4JYyIUi/99G0bYpz7oARm6pdc=;
        b=GJ/Z6eQoai2Rcmi0+vWiwLxBKEkMM/AnFn3d2ABCerAYR7vF/RgNCKMmfc8MdLmV4G
         ekwq4c53/38nBnfDrAZVP8t7263OTIf5lDebMcfCN8T7EO55bm7wh4GSgPeKEAknRMHQ
         ke2A+u/nd2k4cmZvLvHwQHr0bsCeUfbeNmXtlnA1CgjdHTD4e8g+ZSJERDgvjZerpTcR
         pSpoSzwEE50//t1Jtl1bHBfcYsloUwEWbvjllb43VsXhGJ1G4eFp4fBLxrCKG7hJI5ES
         PTbLMkC6DGo6B1hTuj8ao3OfjJfnuWdD8iU25HG8O4863XDC/AHiT/ZQ0J7K3Acdoohm
         XcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=k/Bs2H3pXS0ZpecMHT4JYyIUi/99G0bYpz7oARm6pdc=;
        b=DZWS+8LUiAydZgSrD6s5lueMlDNcOsseqFEMbsgWwsNJoV671DIMEAqNL0o1rWjH3K
         fWCCOWTQAKMwya3PEz7m5s46YY6RIzCTfb8jVbinKZj3iVlUpbd3blsbDXQpomPCIfNp
         oZDg7Oi35iWnX6c0ZMLm/KR4JyT8yktLvsHIN7JBMxlaHnB6OmTrL0cJpTE21m7HGsnP
         qXKxXmzQ97cEnjMHWs8tHjWwYE9mdIZ5cz3YGZpjhDMZ323RdVxgsN2AMzh0YkuNiWqS
         y4sashi8qeKXTJ/2EXd2VwCeb3+leNYVqECeJ4q+rQCSPqf2IH3ssNWY6H/qwNpaXJ5S
         IRyg==
X-Gm-Message-State: AMCzsaWkPx+of83IT0ACOSOgIbkHdSbG2FAjicJAGJHvaogBu0Go1mtg
        Je65Hm7XAyu7cvtlWnVxlZc=
X-Google-Smtp-Source: ABhQp+TWA1SVsM4cxn+qyxluiJv/6TZq76iz+MYLnN6eCzPjLqupISLy5ntPWU9zBldKQ9HSrozt3w==
X-Received: by 10.223.197.69 with SMTP id s5mr1272509wrf.120.1509581248156;
        Wed, 01 Nov 2017 17:07:28 -0700 (PDT)
Received: from localhost.localdomain (x590d9c13.dyn.telefonica.de. [89.13.156.19])
        by smtp.gmail.com with ESMTPSA id q4sm1367377wmd.19.2017.11.01.17.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 17:07:27 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] config: document blame configuration
Date:   Thu,  2 Nov 2017 01:07:22 +0100
Message-Id: <20171102000722.1503-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.67.gb67a46776
In-Reply-To: <20171101223234.14527-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The options are currently only referenced by the git-blame man page,
> also explain them in git-config, which is the canonical page to
> contain all config options.

Good idea.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/config.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1ac0ae6adb..b18cead6aa 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -949,6 +949,23 @@ apply.whitespace::
>  	Tells 'git apply' how to handle whitespaces, in the same way
>  	as the `--whitespace` option. See linkgit:git-apply[1].
>  
> +blame.root::

This is blame.showRoot, isn't it?

> +	Do not treat root commits as boundaries in `git-blame`.

You consistently write `git-blame`, i.e. with dash and between
backticks.  The patch context mentions five git commands: two of them
are linkgit macros, but the other three are all written without dash
and between single quotes.  I think it should be written without dash,
but I'm not sure about single quotes vs. backticks.  grep tells me
they are both widespread for enclosing git commands.

> +	This option defaults to false.
> +
> +blame.blankboundary::

Config variables are usually written in camelCase in the
documentation, see e.g. branch.autoSetupMerge in the patch context
below.

> +	Show blank SHA-1 for boundary commits in `git-blame`.

Perhaps "Show blank object ID", since we're moving away from SHA-1?

> +	This option defaults to false.
> +
> +blame.showemail::

Again camelCase.

> +	Show the author email instead of author name in `git-blame`.
> +	This option defaults to false.
> +
> +blame.date::
> +	Specifies the format used to output dates in `git-blame`.
> +	If unset the iso format is used. For supported values,
> +	see the discussion of the --date option at linkgit:git-log[1].

Should '--date' be enclosed in... single quotes or backticks?  I don't
know.

> +
>  branch.autoSetupMerge::
>  	Tells 'git branch' and 'git checkout' to set up new branches
>  	so that linkgit:git-pull[1] will appropriately merge from the
> -- 
> 2.15.0.7.g980e40477f
> 
> 
