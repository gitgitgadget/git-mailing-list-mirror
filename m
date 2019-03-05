Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0C0F20248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfCEXjB (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:39:01 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42290 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfCEXjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:39:01 -0500
Received: by mail-pg1-f180.google.com with SMTP id b2so6752188pgl.9
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p8Cww9I6kKZT6qDWJzeVfQQ9ZincwBm56lWg7K0z09A=;
        b=lSixBtQ8/aLv4KRODJq/Tooc0vlVXOq7bnr/D6/K7UccWDaOeI4ARLOKyHjFDdnKkl
         hvYcP5pTZs9aip47bhWQBZg5+/USbhsZRS4QXGnrE/ojMKz3DfNT1Xkql9Mbgv4G3jLu
         T7oVSv/BfiHTOnkoG8a7Opl1AZ2jwQxSKzV186nlMGSqShc258HjhXiK+eImbBI2wT2i
         nET0URFQ1LLBE0npLyTOIPc7cAZCyvHXphNC2y25O7jvI/SHkOnWfyBy/U3vG0Q0XyE9
         NW8/gCh+kbp9sPFbCr/cxdVi9NFqkdpby5+bNOsOd39IB4rhtCK/UnxiU1TQpdSZteXN
         iuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p8Cww9I6kKZT6qDWJzeVfQQ9ZincwBm56lWg7K0z09A=;
        b=DFJeXWlgri5G2EXar5pvmXcVKel4/drukBW1carrVybsuq3b4Ohn9wooJg5PgONM2b
         jBbJydyBuhBjurNU6oLCToqFyC40tw8JvsCv9Y48TCfpy1rUJzl9r4bcnHntoQUWbM2/
         LkUl4qHBhvB0/8khwS1p9g9/Wj/vY3ecsvPQX3noPh78Q2M63/MzY3gH0kWjh3KrgeVh
         TKmGwkA5NUsCv85/y6lsgMZaTUkxkn9nlhfXrbyUtFMSDe9pbv5GddsC0lOIwcJD2Myt
         NAtXQu2K/Zzd6pZfzNmPV/VJNCmF/T/WYfyla5EmusbmK/S6YnMTWMt0iG7+s/fIJpxf
         iHEg==
X-Gm-Message-State: APjAAAWkkR6i/8o5BqO0MywvP226iBdNDHjHv6F5Lr9a3BgmZiHwDRhR
        KBAwYyJjgrhYozWtAvz9Qcs=
X-Google-Smtp-Source: APXvYqyDbjHXgwupsvObcc/VEmmUq/72EF6Ua0Ea615nTej+kGWINZBGRpLiF6GHPf28S+2aFt76JA==
X-Received: by 2002:a63:d112:: with SMTP id k18mr3694055pgg.426.1551829140643;
        Tue, 05 Mar 2019 15:39:00 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id a19sm154452pfo.52.2019.03.05.15.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 15:38:59 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     sunshine@sunshineco.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: 
Date:   Wed,  6 Mar 2019 05:08:25 +0530
Message-Id: <20190305233825.5327-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPig+cT_YT-1=ymAYiTpjgRQEe8906Y6yyBU=XuP_wbw+ixxiQ@mail.gmail.com>
References: <CAPig+cT_YT-1=ymAYiTpjgRQEe8906Y6yyBU=XuP_wbw+ixxiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Eric

On Tue, 5 Mar 2019 09:57:40 -0500 Eric Sunshine <sunshine@sunshineco.com> wrote:
> This patch, due to its length and repetitive nature, falls under the
> category of being tedious to review, which makes it all the more
> likely that a reviewer will overlook a problem.

Yes, I clearly understand that this patch has become too big to review.
It will require time to carefully review and reviewers are doing their
best to maintain the utmost quality of code.

> And, it's not always obvious at a glance that a change is correct. For
> instance, taking a look at the final patch band:
>
>     - ! test -d submod &&
>     - ! test -d submod/subsubmod/.git &&
>     + test_path_is_missing submod &&
>     + test_path_is_missing submod/subsubmod/.git &&

Duy actually confirms that this transformation is correct in this[1] email.
(I know that, it was given as an example, but I'll leave the link anyway).

Thanks
Rohit

[1]: https://public-inbox.org/git/CACsJy8BYeLvB7BSM_Jt4vwfGsEBuhaCZfzGPOHe=B=7cvnRwrg@mail.gmail.com/

