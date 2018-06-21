Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BBC1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 19:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeFUT6S (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 15:58:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39707 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932899AbeFUT6S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 15:58:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so8236547wmc.4
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E+JFGq+iLZZunGtCjl1oAkPB4nyYd2qcy7ffFBt9J2Y=;
        b=JZdwfGQMZ6DoxiMd9bS4QpozJho8eW47OICBKuoqXA2iyqrUfyILIeLCz1KlZaWvOz
         0IyGcG/G2JFvTdGCe1ax71jZSg8rMJ9cpjEV+A+xtoonHJ3uwCi9OfIETGmWIX70nQQ6
         52Mi7UZrQt/8rNehiXSS8YnMrqed0HpU7qA4hqCT8VxdwL+KWSn19tfyf4wCWH/ZXQrq
         dQcQqa80nS8KEoLMWgGGJsxGsUl56DX9ECUDSG8mkW2qOlzX97HLyfgnny0a5mAFtjjV
         7nI8IoYcqWgroqx4+N6m9MSwmAcdCTW3RIosuQDxUm3K8eWZGgZStbqvEL5dDeSRg8vZ
         zY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E+JFGq+iLZZunGtCjl1oAkPB4nyYd2qcy7ffFBt9J2Y=;
        b=T6W3gN+Z5RBWaXa38p3x1fHdKGU8T15C1nCFqeaLKVvOxR51PR7K6LmAXuvq+VFItc
         yWFa5+0/d7delCjXknbu0wmFPibZUEnDu/vpPWpgROBs2SNNhKGj0K9970FCjUZzWN0A
         SLJ7bWTTeKf3811uuOKF5Hm7Bi4w9xV/uH4i2eXoZWSTzF2D+3lMmb3PHX5xYGVKTpzR
         L7rClfYGpo08J/2ljIe1R4sTxfh/4EyUnEzeFAbcnP5vGq1p188Kc71ukNMp3IzKYscL
         CEAVgiSWhxJ6j/nbmd//ar20PA4bfHqXTkZSGURBiHRmuDFDnse6b29lvIKJ9lLUVSOG
         vvDw==
X-Gm-Message-State: APt69E2MEXu2tSLMueP39RnxUnXBtkGHv+2NPYBbqyqI0rv4qLlGBH04
        Wt9IZIGZz5TstyJ8m4D3m9c=
X-Google-Smtp-Source: ADUXVKIEPIp73U+ANPrnQ3nDnrqYDx6abCtgjsFIgRquk/9UVnPfFFyL2E4tDGnb02ahjBAG3mIvDw==
X-Received: by 2002:a1c:3a91:: with SMTP id h139-v6mr6529303wma.94.1529611096733;
        Thu, 21 Jun 2018 12:58:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t13-v6sm9465759wro.62.2018.06.21.12.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 12:58:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3 2/7] git-rebase.sh: update help messages a bit
References: <20180617055856.22838-1-newren@gmail.com>
        <20180621150023.23533-1-newren@gmail.com>
        <20180621150023.23533-3-newren@gmail.com>
Date:   Thu, 21 Jun 2018 12:58:13 -0700
In-Reply-To: <20180621150023.23533-3-newren@gmail.com> (Elijah Newren's
        message of "Thu, 21 Jun 2018 08:00:18 -0700")
Message-ID: <xmqqzhznsyi2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> signoff is not specific to the am-backend.  Also, re-order a few options
> to make like things (e.g. strategy and strategy-option) be near each
> other.
> ---
>  git-rebase.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Missing sign-off, but otherwise looks good.

>
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 40be59ecc4..bf71b7fa20 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -20,23 +20,23 @@ onto=!             rebase onto given branch instead of upstream
>  r,rebase-merges?   try to rebase merges instead of skipping them
>  p,preserve-merges! try to recreate merges instead of ignoring them
>  s,strategy=!       use the given merge strategy
> +X,strategy-option=! pass the argument through to the merge strategy
>  no-ff!             cherry-pick all commits, even if unchanged
> +f,force-rebase!    cherry-pick all commits, even if unchanged
>  m,merge!           use merging strategies to rebase
>  i,interactive!     let the user edit the list of commits to rebase
>  x,exec=!           add exec lines after each commit of the editable list
>  k,keep-empty	   preserve empty commits during rebase
>  allow-empty-message allow rebasing commits with empty messages
> -f,force-rebase!    force rebase even if branch is up to date
> -X,strategy-option=! pass the argument through to the merge strategy
>  stat!              display a diffstat of what changed upstream
>  n,no-stat!         do not show diffstat of what changed upstream
>  verify             allow pre-rebase hook to run
>  rerere-autoupdate  allow rerere to update index with resolved conflicts
>  root!              rebase all reachable commits up to the root(s)
>  autosquash         move commits that begin with squash!/fixup! under -i
> +signoff            add a Signed-off-by: line to each commit
>  committer-date-is-author-date! passed to 'git am'
>  ignore-date!       passed to 'git am'
> -signoff            passed to 'git am'
>  whitespace=!       passed to 'git apply'
>  ignore-whitespace! passed to 'git apply'
>  C=!                passed to 'git apply'
