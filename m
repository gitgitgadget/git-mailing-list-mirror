Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7D501F42D
	for <e@80x24.org>; Wed, 30 May 2018 18:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753674AbeE3SvY (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 14:51:24 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:42491 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeE3SvX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 14:51:23 -0400
Received: by mail-oi0-f44.google.com with SMTP id t27-v6so17285272oij.9
        for <git@vger.kernel.org>; Wed, 30 May 2018 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VU1CqMX1m+cZ+x/f6XuI5dHfza5hPRhP65IyymMvGMo=;
        b=vMZCsb2zuOKj6ffZlt13+SS4OHRW0pD56Pr0YWch2FniSo0sw8x+78LtsPnRxnhr01
         jmCqnkr+YtubnrqqTiCiSZmJS/lk4NkN2W8beeRSb5q7ttonrCnzakbHWDXzAKLKC5MQ
         D7bN39WahkIuzTQLigDeZaEXfXP22+Lm9gzqgXACulsKSn6YicH57xr73JTbHw9babCJ
         9DUc+SC2NVwtdTOUTD7Dv8ijqKkFG6BkY74IAczvfksflQGkmKZj71hf8MNrw7PJ0OL7
         4lAuMRRz8DB7qInndFTAC+XsOtQ6FVQJt+VdXGKmMyOLcBZLuPf3cOe6XvqnTWrvw0Y0
         Qklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VU1CqMX1m+cZ+x/f6XuI5dHfza5hPRhP65IyymMvGMo=;
        b=kfhY1iloTBU3n9sPggfgdbOHqJoRSTlVID66LlPj/NPQNmqOOCJcgDupYnaoBmA9jP
         KSbqIMZHcleSDHpB2PJJoUZwEXYbOxCwXsn4O+wVzvwu2h8RAl4X5srhpIR3TfI/DaXt
         Nfm0aU633I3Au9p1pP7mpmY0kHB0a5f3KqnhcATvMg5uDkBxOythPQupS1bvE7nRYWns
         kGjzAjkRweLTRx5tdgNqytU2ygEl2gA4J55kasFmg1STyLlTxu5O2x0Wp6gBpjOLGyCO
         stEnZyz1MyemF2Vx9Fn15N94+WCUufpQGlCw8r4Q30Xnpm+YMwsyLOj53SUqtiExJCDW
         8kWA==
X-Gm-Message-State: APt69E0o0pKDmDXWhusK5H2+pDbW2Yz7cvIAw/UT9TanQ8ndtTPyWTK0
        PbX1QT7cihAcTP9LOSVJaE6pzq0gcNVyZc8mTMM=
X-Google-Smtp-Source: ADUXVKLjAmDZ6bFkrKPd+YWoroHoSVYz2QLIimk6wPucX+tE4ciIUSTzeQVcixBvmT2ayKOdCbW84mygEZ/8zdkgi8A=
X-Received: by 2002:aca:5144:: with SMTP id f65-v6mr1974921oib.32.1527706283072;
 Wed, 30 May 2018 11:51:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Wed, 30 May 2018 11:50:52
 -0700 (PDT)
In-Reply-To: <CAGZ79kaT2KM0cZOSEXMpnr53TxUdH=gSbyQaGdBw1wEGnkK2Kw@mail.gmail.com>
References: <1527700562.4289.87.camel@novalis.org> <CAGZ79kaT2KM0cZOSEXMpnr53TxUdH=gSbyQaGdBw1wEGnkK2Kw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 30 May 2018 20:50:52 +0200
Message-ID: <CACsJy8Dy6Ft7jnj2SFz_0uLSxv9muujY_0nTvFbi3XGMEGFKgA@mail.gmail.com>
Subject: Re: git push requires a worktree?
To:     Stefan Beller <sbeller@google.com>
Cc:     David Turner <novalis@novalis.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 7:32 PM, Stefan Beller <sbeller@google.com> wrote:
> * the setup code for commands that do not have the
>   NEED_WORK_TREE flag in git.c

Unless it's very urgent, I can fix it later (and hopefully soon-ish).
The problem is definitely not with setting core.worktree but with too
eagerly chdir() when you don't need it. We also have another problem
(chdir'ing too late) in the same area that led to the introduction of
chdir-notify. If I'm successful in killing chdir-notify by chdir at
the right time and with the right condition, then it should fix this
as well. I'm pretty close to it, I think.
-- 
Duy
