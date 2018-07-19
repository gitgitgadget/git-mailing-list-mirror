Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B088F1F597
	for <e@80x24.org>; Thu, 19 Jul 2018 19:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeGSUPE (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 16:15:04 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:32989 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731442AbeGSUPE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 16:15:04 -0400
Received: by mail-wr1-f43.google.com with SMTP id g6-v6so9150395wrp.0
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rFnLVn7t6XDmtYrbY6imsuKPbEe3kQfz//k96yjHdkU=;
        b=UKwsb1JSKpbAwKZNd+YjFT+OEvySOs7ekEi00nNSbFErD12I6qKj6/M74cjZvusEqT
         Jcbz/eLn52Xz2a3nErgmMiXlxOlB/kh/lpZZWzZ5kmyxh0ACthJUNlblsg+jKxfF3egC
         G+xIkecXVWMk+ljfvBywGIIT6IQO5d0QT7vGBA2MyKnpoaa3O7A15Mkm22kqdbMsQgKy
         2gxbpsNyldwEqvWdy5bbVNq1InQsNUEVkJZ9YxqXeGLEQoAE6ePvH8G09DrRBgJEeTKu
         z6U46xl6kXp1cXT7BIDWOKqx6pvR587rzRX1MJzObf9V+N01R6WZWXxYPEMhSm69Lt+S
         RQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rFnLVn7t6XDmtYrbY6imsuKPbEe3kQfz//k96yjHdkU=;
        b=WCqKZYl+8kDl/us3SbIx3GbydwzJknxUK2i8vTW1d0vpafdwA5A//RqDsuOlCIo4MZ
         xJiEMP+o7/aNHH0LHgvl7k76FIpAOgVPJWGGhmyDFxvec5/X8ANMjLLpzGi2e6D/rGC+
         HbXIdUWqlAwiC/pWJ1tE8GHnWu64blzTZpbMJJuQEfaU+cyn/mWrPgn+Z/mRpvx7xwzO
         nSY8om3ZR2tnCawb6GKAT91ArmInv08rOjCHFAbdwA9WVJ+fYpO9fyMUKUEFICISsU1b
         kcTw0PoR9l43GyIhqPd71HPCmPuZkY396vfHIG5eEkAp1ECfa+DyT2KSmSNazOvVhxKu
         I9cQ==
X-Gm-Message-State: AOUpUlFArkW/R3y6dg1jMV70cVtbD5YdAV3qW9UD1e9sDPZAj8c3ETAv
        BsQjQQEEvtiBpJ3LPNC8LF4=
X-Google-Smtp-Source: AAOMgpchCJlycgQJ8ZgDl1XfDDkoN116iOLJxjQdLzdiCbd+/WInRrzGiJgstP59pKgtM2EVu0TKYw==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr8503715wra.120.1532028629233;
        Thu, 19 Jul 2018 12:30:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q5-v6sm4649972wrs.87.2018.07.19.12.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 12:30:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 03/23] archive-zip.c: mark more strings for translation
References: <20180718161101.19765-1-pclouds@gmail.com>
        <20180718161101.19765-4-pclouds@gmail.com>
        <xmqqin5bf5fp.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BBwy_WBg5fduQvWdWRxSP__T8DofVZzKcPcYwPg2n3LA@mail.gmail.com>
Date:   Thu, 19 Jul 2018 12:30:28 -0700
In-Reply-To: <CACsJy8BBwy_WBg5fduQvWdWRxSP__T8DofVZzKcPcYwPg2n3LA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 19 Jul 2018 20:48:55 +0200")
Message-ID: <xmqqd0vjdnvv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> It turns out gettext is smart! I got this in git.pot
>
> msgid "timestamp too large for this system: %<PRIuMAX>"

OK.
