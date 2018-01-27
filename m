Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB931F576
	for <e@80x24.org>; Sat, 27 Jan 2018 11:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752490AbeA0L0f (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 06:26:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56016 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbeA0L0e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 06:26:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id 143so5766047wma.5
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 03:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=tP4o5WP87FDTGrGipXjileFIzPh/xkbkslCiWXJZihg=;
        b=rUTaBF05hynUrZMueQef76N6KXeG340IsiiVcMQdXlupmVEkmm7oXzdfqUcctUIwje
         Rlsa7IQcBS9J3tCMFDrjaJgXAvB0OyBdwOjNIzVEnlruaGcRDAktMTWYfr8+TStiiTjj
         K9a0lft4tm3sQd/48fo/nvQqaJMpQkeqQSvc0adSKID0KDgMoay+F2qjTMmlSXzr1u+r
         cJeHlxbR+S/x93GmHTBE0Sp9gog+trRUSi+DzlVd8FGJgfojre3bnZTghCxcdFArNyUX
         b1gU1A7QLydUP0MLCG2MVNibPjwQaHUwKsOR7FOKWKGLOcJ2UwGj/kMl9DTjhkYWVEM/
         XsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=tP4o5WP87FDTGrGipXjileFIzPh/xkbkslCiWXJZihg=;
        b=XMQrOeaTU6YNQrQ+nHyyDOY9o7v0Z/zHmmTevIOyjXh+Q7183mmiBuyyMy7Jm3yRgg
         DGqluGZMqNe3fxswEP9MAUAOJetlrpxWa9lQWH3CZlYLcKQ47aWHNj38cB4XeC9QEJSM
         oTT2bJyoKEkY4Y+WsqQu3ec9lh/LPPJwV37a3+ShECwlhwMCs+S4OMOpPd/o6o4Cc5NS
         gHJ+XIfUtAQvN+8LzjClTKBZL+ETGeuHOfVgCxVuW3QDdtyTH2SDOOIJ24MfaSB7O9Ko
         uSypKYiCjBeUyd3bnRtomS8fak/w361nEU+Ml0lWdHuGJDs1hZOODrjTyLWfZgpl+A3Q
         s1vA==
X-Gm-Message-State: AKwxytcRcEELfNBKT+i3bAy1MoiwknU0HICbKZnmygkne53rQpccmzZN
        KmBFG12z9DLOzlu5ECQix9A=
X-Google-Smtp-Source: AH8x2265jDZxI1S1kIqmU/t2uh8irMosuYDpebe6xGHOB7X7fGA+I30b4OHU+wIP3EqAD0AkNOx4KQ==
X-Received: by 10.28.107.134 with SMTP id a6mr13378615wmi.136.1517052393194;
        Sat, 27 Jan 2018 03:26:33 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id w83sm4381625wma.47.2018.01.27.03.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 03:26:32 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Add "git rebase --show-patch"
References: <20180126095520.919-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180126095520.919-1-pclouds@gmail.com>
Date:   Sat, 27 Jan 2018 12:26:31 +0100
Message-ID: <87d11vwniw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 26 2018, Nguyễn Thái Ngọc Duy jotted:

> When a conflict happens during a rebase, you often need to look at the
> original patch to see what the changes are. This requires opening your
> favourite pager with some random path inside $GIT_DIR.
>
> This series makes that experience a bit better, by providing a command
> to read the patch. This is along the line of --edit-todo and --quit
> where you can just tell git what to do and not bother with details.
>
> My main focus is "git rebase", but because rebase uses "git am" behind
> the scene, "git am" gains --show-patch option too.
>
> There was something more I wanted to do, like coloring to the patch.
> But that probably will come later. I'll try to merge these two
> 21-months-old patches first.

This is only tangentially related to what you're doing, but I've long
wanted to add a commit.verbose config option to emulate `git commit
--verbose`, and furthermore to show the patch in rebase under "reword",
"squash" etc.

There's been so many times when I start editing the todo list, and
reword this or that, only to forget (because I don't have good commit
messages yet) what the patch is even about, and then switch to a
terminal, "git show" etc.

I'm just mentioning that here because if and when we have such a
feature, I think the --show-patch option is going to be very confusing,
people might want to enable this thing I'm talking about, but find that
--show-patch is something else entirely.

I don't know a good solution to that, just putting that out there.
