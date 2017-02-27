Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 189491F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 16:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdB0QoZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 11:44:25 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:34957 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdB0QoY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 11:44:24 -0500
Received: by mail-io0-f170.google.com with SMTP id j18so35173011ioe.2;
        Mon, 27 Feb 2017 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cmce0wPSDf2GKZdnapg9Do9IivCmlK/HzH3zHKum7Sg=;
        b=Ov+2Vrnd+EgynfiDa+sITfjGd/Qc/mTeFW3Et1VXMR6/raVYkX3M+tq4dT3CRP7k3N
         AN3X+7vPWdr4KFR0OSYsJpV/FPOGeJP8mWFj7XfzRZxofTgmE4yK2xfb8x4VNgBkHqv+
         GGl0TlCh9w6Yh+kTGs5cwducfghfAGme4mwCFxHFFk2T6DZj1dxay+N2+mfy22Uybtpd
         vwkOpcod17dRNsXDffGBBG7aaObB8KanUTKKbFFg1jb7dvSoRFr6dW//oVowz5wGuvm5
         5t8C9Tbzc1Wcl7I2lN+EmE8rFnr6FWK5Q92JUbwf5gednO1VEB3B8GYepod7OsKhF5W3
         +fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cmce0wPSDf2GKZdnapg9Do9IivCmlK/HzH3zHKum7Sg=;
        b=JpJGoxULVsbGXP7zXewu1JBy3kiy3pdCLQe2Cns49Bg3XBxDv0f4fSJhH88Z62+mhj
         2yS3YDCeV4kwmxFB5JxlMV1/4g5tD9sTazomSwBi9ITEnOQ/CtW236HrX5y4yI2LFP/Q
         0NYB0kZtWNPdE50z+Sq6I/rWFHheofvsfOrj9TxtaVrTa+mQ9rzCzD8187cOMPM7IZEj
         yoDwUfC+OOOvhP2CHvX83QFjUQ+/GxwfXvKRyNXs9sT5k4B8ycawXIwjrYKgCFRkjDlm
         7wz1oyHKaefLyrQE83XMMzLDUOmRubx2wjBAWVmlKhyw36KC1VcXMYpBtssIpUQj/LHf
         bDsA==
X-Gm-Message-State: AMke39krF7SeeVq8J9pvgDZVDG6CSVI4UNDSd/6gt+r5uY9UN5YlA3OInPFb/XygzTidvONtIkjOczo5f9Lk/g==
X-Received: by 10.107.150.207 with SMTP id y198mr17458839iod.33.1488211950821;
 Mon, 27 Feb 2017 08:12:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 27 Feb 2017 08:12:10 -0800 (PST)
In-Reply-To: <xmqqd1e72xs5.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1e72xs5.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 27 Feb 2017 17:12:10 +0100
Message-ID: <CACBZZX6j8ifa9WrBmBfDuae4qvD7tQ0wWe3yRdLOfFTCOxyRPw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.12.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 8:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The latest feature release Git v2.12.0 is now available at the
> usual places.  It is comprised of 517 non-merge commits since
> v2.11.0, contributed by 80 people, 24 of which are new faces.

Yay, some explanations / notes / elaborations:

>  * "git diff" learned diff.interHunkContext configuration variable
>    that gives the default value for its --inter-hunk-context option.

This is really cool. Now if you have e.g. lots of changed lines each
10 lines apart --inter-hunk-context=10 will show those all as one big
hunk, instead of needing to specify -U10 as you had to before, which
would give all hunks a context of 10 lines.

>  * An ancient repository conversion tool left in contrib/ has been
>    removed.

I thought "what tool?" so here's what this is. git.git was born on
April 7, 2005. For the first 13 days we'd hash the contents of
*compressed* blobs, not their uncompressed contents. Linus changed
this in: https://github.com/git/git/commit/d98b46f8d9

This tool was the ancient tool to convert these old incompatible
repositories from the old format. If someone hasn't gotten around to
this since 2005 they probably aren't ever going to do it :)

>  * Some people feel the default set of colors used by "git log --graph"
>    rather limiting.  A mechanism to customize the set of colors has
>    been introduced.

This is controlled via the log.graphColors variable. E.g.:

    git -c log.graphColors="red, green, yellow" log --graph HEAD~100..

Does anyone have a prettier invocation?

>  * "git diff" and its family had two experimental heuristics to shift
>    the contents of a hunk to make the patch easier to read.  One of
>    them turns out to be better than the other, so leave only the
>    "--indent-heuristic" option and remove the other one.

... the other one being --compaction-heuristic.
