Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC61201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 20:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbdBTUTN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 15:19:13 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33193 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbdBTUTM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 15:19:12 -0500
Received: by mail-pg0-f42.google.com with SMTP id a123so21644576pgc.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 12:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ukAcqNXl6d6ydMICsNQ+v3pvPkqdaokGLOP2lTZ3/Qs=;
        b=W3E3GNj3kpsegZdWBbVfGA1/n9G+4SsMzor/Hzikz/PwYyoRQ5OLZRKq1Lacu4ajos
         eBBSY0fL/CBfOVqNIyGAj6ePuAXn4w8+Z9yLy1catoBMwOeRYssBJrQHRmvVK3CIj0ts
         hV9LQGjnLYAiLAyn36eR6V3evWRMmDAmq64cDkiAxlOrlh7XXyPVGT4ELjEWLvOU53kw
         rYuwCltCiW+yBEadENjlvgzwxbBGxPiaj+wi8u/I7jKG9r8lp/H7VLLVEdRqPHYyo34M
         90mH0VLVeKavv3wBNTALuigfUyuqYchOL2354ii5OjsAHUcLJaCKAW/QeQY4Mwh0H27z
         cnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ukAcqNXl6d6ydMICsNQ+v3pvPkqdaokGLOP2lTZ3/Qs=;
        b=H22QIBwi3kjMr0EfNLdehJCq+z163fbTkKE3a+IHnZjNr8/cLkStvkZYxB3i/wv5uE
         g6jbkMN4KnYvEknOmUNAhEkXtnNaLEff49e6wR18pj4BW6reKKcC19aV69CTEk40CWPR
         E+X0445/KQ2b5zaiR6oJ35bx51NSZIcbEBp5MZyN6o/Kv9d7yhJHDM/LRbABBf+zTivh
         s5hcDbgC0CVtlWvyxbRNsqtnsguyRRFKKW0o+NNEpIA5iGLKkIXkuH//ypdDO142jss3
         h3lKFKlLsAovl6KAVOYArX98euC8bt6X0aI0NHmUR7q85IDjhzC+EyqMVuzRy+y4VYtf
         kCtA==
X-Gm-Message-State: AMke39lc4nfnPu5CUxTywg5Zi/Ss7u3bj/DLo/+aLx4yFBjCI2tn4afzqVIT8bWaeE73mA==
X-Received: by 10.84.164.231 with SMTP id l36mr34533815plg.166.1487621951392;
        Mon, 20 Feb 2017 12:19:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id o1sm36942635pgf.63.2017.02.20.12.19.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 12:19:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leon George <leon@georgemail.eu>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: slightly confusing message
References: <7cca3326-d6b5-4669-7256-ab275567b72e@georgemail.eu>
Date:   Mon, 20 Feb 2017 12:19:09 -0800
In-Reply-To: <7cca3326-d6b5-4669-7256-ab275567b72e@georgemail.eu> (Leon
        George's message of "Mon, 20 Feb 2017 13:35:18 +0100")
Message-ID: <xmqq1susk43m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leon George <leon@georgemail.eu> writes:

> Every once in a while this:
>
> £ git add -p .
> warning: empty strings as pathspecs will be made invalid in upcoming
> releases. please use . instead if you meant to match all paths
> No changes.
>
> It seems to happen only when there are no more modified files and git
> still works wonderfully otherwise - just wanted to let you know.

This sounds vaguely familiar and indeed I think it is this one:

https://public-inbox.org/git/CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com/

which was from late last year.  

I suspect that the issue may already be fixed at the tip of 'master'
(aka Git 2.12-rc2).

Thanks.
