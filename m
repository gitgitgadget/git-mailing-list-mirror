Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B0F20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 03:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeLJDbQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 22:31:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40723 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeLJDbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 22:31:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so8942344wrt.7
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 19:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CpMq1wHayacAghu/v0HgKQahDnVGmfOfpqq0f7E5H70=;
        b=aiQSGRXWXuug7MJ2Zrr5xCDG/pz2EfybkB+/cVWrx0HX+iEA+xvMpOYhlFgtc1DRh9
         hcbtxbOPYz3E+T1waOMKUbKelJPmxP1QIpFBpMVqbDjlrAk/kXLA4OIYH5o/FhX7eZ9q
         69i73P8IzoO6WzV8bEIOkb4ojL38c+AXIVDdte0bh8wi6Zxe6+/OA/TLNZW6a+XPqIVL
         eGfp3j/xHhF3xRgf0WvzxT4i83WNZbw6jr8zE+6qtAmhSaosfxIlBOjOtGRTyHbCCAwS
         h4JBvodCAkJxVPnT2XppS2rMwM6IVHYusII8ppz/yV5j+O535XiJpP4rAs1+xyRRzQcH
         hNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CpMq1wHayacAghu/v0HgKQahDnVGmfOfpqq0f7E5H70=;
        b=pn17ojW7DZol872kVrInEv6Zp3iuu//QC2FQ650HZDk5lpBBzMvltoihqUTQb9ZuQw
         8cqDOEVDfDLEtKvB4HFZf4uQtTPnd3N3eLh7ibNAn/I8kAh/xrgpXNyBvhSjHqoLBiCT
         M86IC4xRfBg36bt+5Qb4J0F8Nd3s0auuj2MBupeCil2NtA1Qz3L8a6SrHGR4au+LjU+j
         I65cFol4m6FYxyg12E1JKsenzOacZr/is/uImJfhJs8SEyDzNZdI7ktWpZaTLK/b42qZ
         rY0N1OHDb3DvgaTEAXanih61Yh+Xhl0ustbX4fg76UVJzpN/0K/4FzCkyMdXgKYksCTA
         OaiA==
X-Gm-Message-State: AA+aEWZPQTduZCUtOfJrKX5UcuBBvYLoTbqXJz5BKw8RMl5F/cfqw4E3
        7H3+ySJKMM+o7JPjZ3Ip37Q=
X-Google-Smtp-Source: AFSGD/XQJjFP2kMdsjJiDLrTJHdVOfxfdD9BaTND2V3tnpIY9e556p1b8AdOp5UlXPLqFUdkOKdsgw==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr8641419wrc.191.1544412674110;
        Sun, 09 Dec 2018 19:31:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g188sm8700782wmf.32.2018.12.09.19.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 19:31:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH] rebase docs: drop stray word in merge command description
References: <20181208231541.1341999-1-kyle@kyleam.com>
        <nycvar.QRO.7.76.6.1812092040320.43@tvgsbejvaqbjf.bet>
Date:   Mon, 10 Dec 2018 12:31:13 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1812092040320.43@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 9 Dec 2018 20:41:15 +0100 (STD)")
Message-ID: <xmqqk1ki2h32.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Kyle,
>
> On Sat, 8 Dec 2018, Kyle Meyer wrote:
>
>> Delete a misplaced word introduced by caafecfcf1 (rebase
>> --rebase-merges: adjust man page for octopus support, 2018-03-09).
>> 
>> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
>
> ACK.

Thanks.

> Too bad this did not make it into v2.20.0, but at least it can make it
> into a future version.

The right way to fix it is to prepare a topic that can be merged
down to the 2.19.x track, and proceed normally to percolate it down
via 'next', 'master' and 'maint' as any other fixes.  That is
already happening.

The original documentation bug is older than where the 2.20 track
forked; the bug is in 2.19.  Any such old bugs, users have survived
without it being fixed for a cycle already, and the fix is not that
urgent to interrupt the release engineering that is already underway
and redo it.

A regression that appears only in -rc and a known bug in a new
feature that appears only in -rc are different matters.  It is
prudent to always first access how serious they are and we must be
prepared to even delay the final as necessary.  But I do not think
this one is.
