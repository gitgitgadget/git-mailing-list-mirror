Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C904F1F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 16:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbdFLQGI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 12:06:08 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34200 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754756AbdFLQGG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 12:06:06 -0400
Received: by mail-pf0-f173.google.com with SMTP id 15so25488615pfc.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tC9X9e69zVm2Qtx5JMaHqNAm6ufjl8/yPk1aI1DgVos=;
        b=F/3I+jW6NPbrgAGHAIge65c0J+rH1QRTZAEBQyjRYkZY4yGBABcgYz1L6lP4bUWVl/
         FzdivJHUF5WnE6cKMhRgn3g0gDzVnximewEPSarCQDHFsmIe8oDZ5xyvr33C+SbYvWKf
         FhbWGqLo2Z0p2eFWI8FoUwrmbqc/ugUVeINgTzJr29JdtzHeTW2wTmwvnmgRTE/lzLZc
         gFhx6tXwBUCvJZl0r25n4ySLdJK4+I1PL5eDgsI/n7k7uRJa4VGY8JOhTOMhWpDk7vEB
         wTlkLn2TtHTw56DQtXlxXB/Hg5pXytWET9S1iP6EXy0B9OV5Wa7ScV2AxYzHByO3+RYA
         JMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tC9X9e69zVm2Qtx5JMaHqNAm6ufjl8/yPk1aI1DgVos=;
        b=PcPGZr9NzAt7vQxsZl+v0vGuxuKC/xMryawr292EcXRSqj7nK74VyctWN3b47r3gI4
         J8TH+wbmangBS1l77VfNX85Y2A5JjZsW1zniTbnVBda6phGL2P/fufA+d9E4Mmu0mr/W
         YwgPs8b0umgh35ij57kz9U2rDAZlMj94Gypc9psk+K/KN41OlE4I+jm1oelJ/QIQWIQI
         47dafHLTCY3PTnF4oZLmq/hmp/NRowq2tTfe8lDHuRXSAT6ErGa7RM7y06vRJxzPcHLG
         SQstkjEKu9HVUbgpt5q9dA5KK+kS5u1MFcpzyJiSHkjvRciPrRB/LlGIUeQMIsEdDlP/
         XEyg==
X-Gm-Message-State: AODbwcBwEkOvGJKXt4DqeYsuprex4HUPoRX5Ur5yre38vcK1EqFf5qzE
        FKQeZcVZ8MLx9Q==
X-Received: by 10.99.104.195 with SMTP id d186mr58599609pgc.38.1497283565553;
        Mon, 12 Jun 2017 09:06:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id z79sm16183205pfi.43.2017.06.12.09.06.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 09:06:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: fix location of index in worktree scenatio
References: <20170610090719.8429-1-asheiduk@gmail.com>
        <20170610173824.19460-1-asheiduk@gmail.com>
        <b4906d3f-7e4d-f4dc-dc39-7eac5da8292d@web.de>
Date:   Mon, 12 Jun 2017 09:06:03 -0700
In-Reply-To: <b4906d3f-7e4d-f4dc-dc39-7eac5da8292d@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 12 Jun 2017 12:03:11
 +0200")
Message-ID: <xmqqfuf5p4wk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> Thanks for working on this (and keeping me in cc)
>
> The commit head line does not fully match my expactions:
> "doc: fix location of index in worktree scenatio"
> "doc:" is OK, but is the "location of index" fixed ?
> Actually something that includes the important stuff:
>
> "doc"
> "fix"
> "normalize the line endings"
> "worktree scenatio"
>
> could be more helpful.
>
> How about this as a header for the commit:
> "doc: normalize the line endings in a worktree scenatio"

Andreas's patch does not "normalize" anything, though.

    doc: do not encourage `rm .git/index` in an example

    When illustrating how to force normalizing the line endings,
    gitattributes documentation tells the user to `rm .git/index`.

    This is incorrect for two reasons.  We shouldn't be encouraging
    users to futz with the internal implementation of Git using raw
    filesystem tools like "rm" too much.  Also, when ".git" is not a
    directory but a "gitfile" pointing at the real location of the
    real ".git" directory, `rm .git/index` would not work anyway.

    The point of the step in the illustration is to remove all
    entries from the index without touching the working tree, and
    the way to do it with Git is to use `read-tree --empty`.

perhaps?

You _could_ mention "worktree scenario" but that is not the sole
user of the gitfile facility (e.g. a submodule working tree also
uses ".git" that is a gitfile pointing at the real repository
location), and "worktree" is not the real root cause of the problem
("gitfile" is), so I do not think it is essential to do so.  If we
really want to, we can add to the second from the paragraph
something like this:

    ... would not work anyway (the use of ".git" that is "gitfile"
    is often seen in a secondary working tree managed by "git
    worktree" and in a working tree of a submodule).

