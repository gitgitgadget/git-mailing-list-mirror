Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0F320A2A
	for <e@80x24.org>; Wed, 20 Sep 2017 10:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbdITKAG (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 06:00:06 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:56962 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdITKAF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 06:00:05 -0400
Received: by mail-pf0-f181.google.com with SMTP id g65so1285368pfe.13
        for <git@vger.kernel.org>; Wed, 20 Sep 2017 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IeZIbtJHSN+3wtj7IdxdGnQf6QURrbHMRTfHLKPuLto=;
        b=TxNX4hPNnJpVXdALW4sh+PiBkUWIzzIJX64Ffc9oiUgXxZTdXtnDGc5yHuO7AqjPH2
         etK0pzAkzm3PiwgSmoIQ0oollG9LVKq88vSXmLbsu9gMnpQBPBV1Bbs8exKM4uhtEp4A
         zo3UKXe0ew3K+5vh3Vtx3Yid+qPpGHIzRCkSjPcHrVKg5M19KjYxCInjX72bPvQSn6E+
         fpLBk+VoqYYfO/CfHyVQsa3sHDt4W0Ad1I+VZ72lSEIpux1USif6mzcFpxYKbdOj8FLo
         ko0pDYaqnw/v3SOAw7QNDS+JqGJKATUdEANdQZzzClL8OCrVnl0j9sn8oHo8GYTTioaD
         q3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IeZIbtJHSN+3wtj7IdxdGnQf6QURrbHMRTfHLKPuLto=;
        b=I47qWi+vlrOUgcQM4lOfCLE1ktjMtE6EqMZxxo+if04er7Ql6T1jR7AzlnyLr0zf8g
         ac95CyVifPmFVVYpLljEI13KT8WgscPEZlBzMMbB8Nq1JgrkHvp/2PvH9S0cI8evG4cy
         tRUbmF6K0Uu1oHupDXphAKe9/5WtVoSl2xt7BFjLvr8Z1ySWGQLoueIGs8YUMo1PM8oe
         ZldcYX93lBBrdooNLkHDAcxmbZfAwN3BYthrDkC+AjxcoQS0qzppfFY6cnmEIBOPqi1b
         F1AgNNrpA/PupoqI4LE4TT4ma8MAZoYv/ktnAjMe53dxF5yFZ/ypR3/Lw3k92a2NYPv7
         cwcg==
X-Gm-Message-State: AHPjjUjmlei/LuA1dmGHYnEs+wkWYoSM5iAI3ieoTgGmnDaZtV/8EHNw
        VuPa1zXT9mKXAmNYF3s7CuRcVrxungeq1y92p28=
X-Google-Smtp-Source: AOwi7QDFlmhxuCir4/qTW6uaGTfNZDoEETjfZsBYiIpLTNA7ElKBeDIzVnXnbqPujjntjx5JAgo++M2X7Rf9zgu9/7Y=
X-Received: by 10.99.185.86 with SMTP id v22mr1701448pgo.236.1505901605009;
 Wed, 20 Sep 2017 03:00:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Wed, 20 Sep 2017 03:00:04 -0700 (PDT)
In-Reply-To: <20170919192744.19224-6-benpeart@microsoft.com>
References: <20170915192043.4516-1-benpeart@microsoft.com> <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-6-benpeart@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 20 Sep 2017 12:00:04 +0200
Message-ID: <CAN0heSqFsm0BSUzufXjCKNv=JpRpUQzFA9GkKfA6nd_hPhW_qg@mail.gmail.com>
Subject: Re: [PATCH v7 05/12] fsmonitor: add documentation for the fsmonitor extension.
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 September 2017 at 21:27, Ben Peart <benpeart@microsoft.com> wrote:
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index e19eba62cd..95231dbfcb 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -16,9 +16,11 @@ SYNOPSIS
>              [--chmod=(+|-)x]
>              [--[no-]assume-unchanged]
>              [--[no-]skip-worktree]
> +            [--[no-]fsmonitor-valid]
>              [--ignore-submodules]
>              [--[no-]split-index]
>              [--[no-|test-|force-]untracked-cache]
> +            [--[no-]fsmonitor]
>              [--really-refresh] [--unresolve] [--again | -g]
>              [--info-only] [--index-info]
>              [-z] [--stdin] [--index-version <n>]
> @@ -111,6 +113,12 @@ you will need to handle the situation manually.
>         set and unset the "skip-worktree" bit for the paths. See
>         section "Skip-worktree bit" below for more information.
>
> +--[no-]fsmonitor-valid::
> +       When one of these flags is specified, the object name recorded
> +       for the paths are not updated. Instead, these options
> +       set and unset the "fsmonitor valid" bit for the paths. See
> +       section "File System Monitor" below for more information.
> +

So --no-foo does not undo --foo, but there are three values: --foo,
--no-foo and <nothing/default>. I find that unintuitive, but maybe it's
just me. Maybe there are other such options in the codebase already. How
about --fsmonitor-valid=set, --fsmonitor-valid=unset, and
--no-fsmonitor-valid (which would be the default, and which would forget
any earlier --fsmonitor-valid=...)?

>  -g::
>  --again::
>         Runs 'git update-index' itself on the paths whose index
> @@ -201,6 +209,15 @@ will remove the intended effect of the option.
>         `--untracked-cache` used to imply `--test-untracked-cache` but
>         this option would enable the extension unconditionally.
>
> +--fsmonitor::
> +--no-fsmonitor::

Maybe "--[no-]fsmonitor" for symmetry with how you've done it above and
later.

> +When used in conjunction with the untracked cache, it can further improve
> +performance by avoiding the cost of scaning the entire working directory
> +looking for new files.

s/scaning/scanning/

> +If you want to enable (or disable) this feature, it is easier to use
> +the `core.fsmonitor` configuration variable (see
> +linkgit:git-config[1]) than using the `--fsmonitor` option to
> +`git update-index` in each repository, especially if you want to do so
> +across all repositories you use, because you can set the configuration
> +variable to `true` (or `false`) in your `$HOME/.gitconfig` just once
> +and have it affect all repositories you touch.

This is a mouthful. Maybe you could split it a little, perhaps like so:

  If you want to enable (or disable) this feature, you will probably
  want to use the `core.fsmonitor` configuration variable (see
  linkgit:git-config[1]). By setting it to `true` (or `false`) in your
  `$HOME/.gitconfig`, it will affect all repositories you touch. For a
  more fine-grained control, you can set it per repository, or use the
  `--fsmonitor` option with `git update-index` in each repository.

The part about $HOME/.gitconfig vs per-repo config is perhaps generic
enough that it doesn't belong here. So it'd only be about config vs.
option. Where to place the config item and what implications that has is
arguably orthogonal to knowing that the option exists and what it does.

Martin
