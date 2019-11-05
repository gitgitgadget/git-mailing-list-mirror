Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856B31F454
	for <e@80x24.org>; Tue,  5 Nov 2019 18:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390682AbfKESY1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 13:24:27 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42171 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388711AbfKESY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 13:24:27 -0500
Received: by mail-ot1-f52.google.com with SMTP id b16so18478214otk.9
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 10:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJDoGX30qI54UzKeKZvN8hRZcOdo+RuisFAVp5ww+4A=;
        b=GwrW8K8iZS5L2t6Pq/Ihedssoh21PraX8MM35b2BEeqMAU102V38AretbfyUN3rNLw
         XkcF8736l3va+kwCdYRx9sg5O0KFDCX21Iro21TEKuPj8gAJQf8wnr7AueI8XS7vL0H2
         QXsEfa9i6wWWY8rvAvnbWZ563/azuDlev9FsuE83dTOmi6NYecxHzWr1CJyINMKuhYrw
         t49Cjbo9eUjNhkGXFGfjVxFalq7kPMOG1dzzDZSHhBB5jY44G2LmmPb+KoVdQWuwpBli
         w7qdXFUfkuEwE+8SkYcrrOsz4xexbpEKdkt+P6iw+cCbLqulJ+ZqmUp1jJKGUKpPsUoe
         zhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJDoGX30qI54UzKeKZvN8hRZcOdo+RuisFAVp5ww+4A=;
        b=VjfvGHTwzp/VOpoqqFzh/AgT/XdjPL8mp236jYm3PGqOy/YsqZi/VfbO2wYC5AwJc8
         +xQvptGGVzEyYUSkaC0fJKAoxj3nLEqvBW7ZSaHQUe4ePz3RZzIs+tKCBtsvd10xeDUN
         TM9br93IC4YWjVyhD+DdAV3JdOE2P/tzq3Z788XzVLu4ex307iaH4Fmb5RTMgjawMyji
         Ktq27Asq9L4KXPVdbBOv7s7BDM715i0MzWk1P0IsQsqhPCibMjah8h4IDnBJLT0Vrk++
         gNr/EXiSatiQhPgfRXZ5EHr6uGnpta/lLoTufo6To5YTzVtv+8atzO08p4Njl9Xefq6P
         dVrw==
X-Gm-Message-State: APjAAAWaf+qBhm2NX8EfuXj7MoMuxeBLvBY/Sp9d+9W/HOWt46KA5hnr
        tdAZNgO2MKH9BnRPMrp3WIlk9mkqlvL4ErZlxVM2xgJk
X-Google-Smtp-Source: APXvYqw0q7KmKL59kqrCbaoEeMS0L1GMcpecjWCFOBeFy1sOfb0MCacO+OFMNxs+xIOe4Y7+/iB1NGwjmU6A3NOIujg=
X-Received: by 2002:a05:6830:15c8:: with SMTP id j8mr10767096otr.112.1572978266019;
 Tue, 05 Nov 2019 10:24:26 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.21.1911041704520.3956@fossies.org> <20191105171107.27379-1-newren@gmail.com>
In-Reply-To: <20191105171107.27379-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Nov 2019 10:24:11 -0800
Message-ID: <CABPp-BEzSaf2W+rfUOjEAETK0YFa5-2ZFD0WLV6j-D4LjACjJg@mail.gmail.com>
Subject: Re: Some misspelling errors in the git release 2.24.0
To:     Fossies Administrator <Jens.Schleusener@fossies.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 5, 2019 at 9:11 AM Elijah Newren <newren@gmail.com> wrote:
> On Mon, Nov 4, 2019 at 8:14 AM Fossies Administrator <Jens.Schleusener@fossies.org> wrote:
> > > On Mon, Nov 4, 2019 at 7:07 AM Fossies Administrator
> > > <Jens.Schleusener@fossies.org> wrote:

> But I thought it might also be worthwhile to you to report what the
> false positives found by that program were; I've included them at the
> end of this email in the form of a patch.  The places where the program
> seemed to struggle were:
>
>   * In dealing with translation files.  It didn't recognize them as
>     such and often tried to translate foreign words to a nearby English
>     one.
>   * In handling variable names: acronyms might be similar to english
>     words (cas, for compare and swap, looks like case), abbreviations
>     might look like alternate words (ans, short for answer, looks like
>     and).
>   * Testcases with intentional spelling errors
>   * Proper names that were similar to English words (Ned -> Need,
>     Claus -> Clause)
>   * miscellaneous tech jargon or package names (e.g. 'filetest' module
>     being replaced with 'file test', 'ith' as in not first or second
>     but the item at position i being replaced with 'with', 'mmaped'
>     being replaced with 'mapped', 'CREAT' changing to 'CREATE',
>     'UserA' (out of a sequence of UserB, UserC, etc.) changing to
>     'users', 'spawnve' function name being replaced with "spawn",
>     'CAs' (certificate authorities) being replaced with 'case', etc.)

Ooh, one more I remembered that I wanted to point out.  It found the
spelling error 'achiving', but it wanted to replace it with
'achieving' rather than the correct 'archiving'.  Given that the
correct is the same edit distance from the spelling error, it made me
wonder whether the dictionary in use just needed to be expanded a
little.
