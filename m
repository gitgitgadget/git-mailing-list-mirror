Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BCDA1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 19:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeJWDmT (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 23:42:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36808 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeJWDmT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 23:42:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id x2-v6so4159185eds.3
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 12:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BMX2H14oz81YTIuMIjWLy2Op0zqk8HlExu8l+K495yc=;
        b=lp9h48ZX2Zk5EvIbMJfUSpwyzNfA0Ls03yYgc3QZbQW/OoR+9wRL50rKv8jVsLyaN5
         VIdzHTHROC504r05Er2yjXJ1rQLpVYkeEfcKBuzT4NapwXlh/hSKdoyNUzFLpqRVvTz4
         2SkMb66MKpAwSlil+C3XACPGyPgB1Bxhh8WFxDbzmumpZHWimG7X+6zU7/Vq4wg9uMdU
         BUwbfc1yOP1PnRKbh2OuA5aKUlaidNpEbsaLHyzQDMv5po0z2AFbEbMY9Ba5q+2dNJkW
         yUhFUTsxrIUVayfcuToDqL7xyQ8p4oMDF7EZY3PUIyv/+I1j+3DJVOmvn/yJ0GFRlZuX
         +p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BMX2H14oz81YTIuMIjWLy2Op0zqk8HlExu8l+K495yc=;
        b=fXu+BtiJK+mnFM7wSdk6hj5CQ8nvUWD66gsTSLam/vd87OGuzJxxtj+LS+H7XzyqZm
         YDhL8Ghjyhhom0bYasHCMhKizSfojSJ7RXOrtoewsXAKHgBlJuzX6UPlcUtVbm4a9Yen
         b9epOXlSuHU5EeiDCeZoWamZ/oFp8yproPe6WUqLQLnr3uiCcyMH7ho/JtaJVWKZQahP
         n9pKZObowzGLcIyh0zk3aMvDome3h+oG0VQ/bvMpJYExfpOzADVqWk00Z0ydruIPaBWp
         bTGKAuLTJfI6Ec0tO/w2c52IG071Ldr4Cujw0YGq6Xwg1yyCRR1o5oZ75Rk0/dssNXus
         MAlQ==
X-Gm-Message-State: ABuFfoht1KDPmd68HkpuIfoJ0xkY37Hd7UCQmDSL9jUOrQbm5VaWAWpa
        gACP0jwwe9PubxoIta5o4NabVwK+k4OS91Ghr/rrYg==
X-Google-Smtp-Source: ACcGV62c3U/hTfUExDjcy6MpaipP6LUtdfA0VgxB1yWYo4GhIwHy3ddBUgUijqhh8bEbuvA76PTuqmXBRatY+764UQI=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr13759805eds.25.1540236150651;
 Mon, 22 Oct 2018 12:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181020123848.2785-1-pclouds@gmail.com>
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 Oct 2018 12:22:19 -0700
Message-ID: <CAGZ79kZyjjG9oRzC4jJ4ZqD2efkzR5GyFHUkZKf=811emE=tHA@mail.gmail.com>
Subject: Re: [PATCH 00/59] Split config.txt
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 20, 2018 at 5:39 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> I started this a couple months back, moving a couple big config
> sections out of config.txt to make it more manageable. This series
> almost completes that. It moves all configs (except http.* which have
> changes on 'pu') out of config.txt. config.txt is now about the
> syntax, and a list of config sections. http section can be moved out
> later.
>
> I did a doc-diff on this series and the only change is ssh.variant is
> moved down a bit to keep it in order, which is intended.
>
> I thought of grouping all these config files in a separate directory
> Documentation/config to avoid cluttering Documentation/ too much but
> let's wait and see if people really find Documentation growing too
> large first.

Have you considered to use config as a prefix, i.e.
have config-add.txt instead of add-config.txt ?

currently any command is documented in a file
that is prefixed with "git-". There are others such as
gitcli or gitsubmodules, but as they lack the '-' they
surely are not about a command.

With the config- prefix it would be easier to sort and
cope with the individual files, and it would allow
grepping through Documentation/conf* (which may
be easier than Documentation/*conf* or similar)

I have no strong objection to the series as is
(I have not looked at any patch), but I would think
either a config directory or prefix may help further.

Stefan
