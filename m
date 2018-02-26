Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930C81FAE2
	for <e@80x24.org>; Mon, 26 Feb 2018 10:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeBZKSL (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 05:18:11 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:38024 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeBZKSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 05:18:09 -0500
Received: by mail-ot0-f170.google.com with SMTP id 95so12876558ote.5
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 02:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+Bj3+JOMTjRM7s+WtVfXOu+izD5rjsGKnN1oOoPcH2k=;
        b=ABMOjW5J3HEy1mZkfYrZuKpb5p26SwYeX3qyD09fc/eZDtBw/bNZBuVjjrRswHCXC1
         jAUaF/kDDBGahUq2HqsX1PvBgqtz9zU29cucWyRden9dnStn1swokEDNDwSyCfudc7JZ
         o/vMToXVgnwk8nXXAL7GfW7VIUvuHa6CWJzL7Bh/3Mv34C6SELwkqC8LapVG05xFR6hd
         Y38+5w7z79XBU1uOj4PDihT81kTUsiJlRz6JWMgUN17RI6Yo463T/37ALZxmOIr7KBdQ
         kfXJaAaB8mzRZX0JuO2xaMQJsc1hDUQZwsaCTsUL0Tcpen/zr1LYot1ie+ypACNPaN+/
         xBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+Bj3+JOMTjRM7s+WtVfXOu+izD5rjsGKnN1oOoPcH2k=;
        b=L90khD1KwVzHSEc0YF0GOBKV0nwpfHtMSr8Lu0Rp6WKtsFDXitFwHvx6dxFoToMnDC
         c2C6U4CaVVXop5ypgTE6Zb9aVu5dEVisAHhYeE0nlMdcUjFUyGyDkYMRN9FYvKo1YSni
         vWMSa1SBiSzBesUzlRBZX6bLKQXz0VdEeIJOYTIssru2+fTdqunKM3e68LYCUOehBNRn
         QGVu1k0Tpv3Rx/81GmVjdggApe61eU78hmDhM9eBxXdc2zX21vm4KdoyEmnKxRK/QOoD
         9EL2HBKDcy8eYgxtykCMmNZGxtdFV8fI/okJnUPNP+RLziBf7FMIduCDe0ric8Z+rcAX
         8u8g==
X-Gm-Message-State: APf1xPDobEaljriXsBWm6Lln8gU3Ye0kAQq/Q0xwpD+/OWs1NwPmcC1k
        m3nL75hQ9n6bx8sdWj7nlAglobZ2Hd+L1B+6l78=
X-Google-Smtp-Source: AG47ELsHsoQu4KtJvBtFM22rVEgSgLzlD+CJyQcAUCoxNh7XBk2l78bIad9eH+RyIxVf91m/NIlln+UVyyjcW/hqop4=
X-Received: by 10.157.24.42 with SMTP id b39mr7593017ote.356.1519640289381;
 Mon, 26 Feb 2018 02:18:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 02:17:38 -0800 (PST)
In-Reply-To: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
References: <xmqq1shdyidz.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Feb 2018 17:17:38 +0700
Message-ID: <CACsJy8CxvabA5+GF62==w6KSi5Vm+kLjs5+grPbWJsf_bfCT0w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2018, #03; Wed, 21)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 22, 2018 at 7:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/worktree-move (2018-02-12) 7 commits
>  - worktree remove: allow it when $GIT_WORK_TREE is already gone
>  - worktree remove: new command
>  - worktree move: refuse to move worktrees with submodules
>  - worktree move: accept destination as directory
>  - worktree move: new command
>  - worktree.c: add update_worktree_location()
>  - worktree.c: add validate_worktree()
>
>  "git worktree" learned move and remove subcommands.
>
>  Expecting a reroll.
>  cf. <20180124095357.19645-1-pclouds@gmail.com>

I think 'pu' already has the reroll (v2). So far no new comments.
-- 
Duy
