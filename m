Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E120020248
	for <e@80x24.org>; Tue,  5 Mar 2019 14:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfCEOD6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 09:03:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43606 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfCEOD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 09:03:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id d17so9589761wre.10
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 06:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9dl5hVX85ZXelej4afDf9hZ6B2gZ1vI8/U1PcHiWYyo=;
        b=TTPGnED63VdwL75GBoVk7+92QVttqt7pF+LAMYLK5NY/OJm/IfOCwnT8PpjFvbKWtu
         Ffdv6NypBoi8SwAUJNChw8TbsQu3fNFnNGalYHsUBRPuWAzk3CXinNGr+1RCbjADhBu6
         ge5eIg1OsNxGNzPBmS9cRsKwue+YYrB/Dmr+ll/rb2SZf5W1YDw0Jcn6JVKtD1f7A/LN
         PZ7syGzh0zo0+MnT55ObYlBWKlmI0B/d6jIKAFt44wHu7yry+QnxS9zmA5k4p1botBjX
         5GihA2sv4lUcs2259gSQrGDFTdhxpLtAXZZaLGaZKoIer1BhGb+oIoFRkhey6QBOqSpk
         Tg0w==
X-Gm-Message-State: APjAAAWcYowNgdjuNwVRn2gJWm75Kw2/DTyuLvpTZxsJ8BQcQW9GsXUd
        luwclgpb+PtEPYcJcJqA0MOqvK27yPjR1GOlFbs=
X-Google-Smtp-Source: APXvYqwzgRAK92VBk/+Mx9y2P1YGd9BvU1smZleceKt+BIHJkPUXzSF0eNaq0L0vX4lHIiFTGZyX1wy/DLcBVJdTqD0=
X-Received: by 2002:a5d:4149:: with SMTP id c9mr17149446wrq.58.1551794636672;
 Tue, 05 Mar 2019 06:03:56 -0800 (PST)
MIME-Version: 1.0
References: <CAPig+cSKOSC+CckNbjr7HahT5jXkp47WuOxbDov_KQi4XNnbQQ@mail.gmail.com>
 <20190305134259.10962-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190305134259.10962-1-rohit.ashiwal265@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Mar 2019 09:03:45 -0500
Message-ID: <CAPig+cR3b=jk4W=9SF4XJQyqAfFHiG8MduypD75RL1=T_qY0Hg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3 3/3] t3600: use helpers to replace test -d/f/e/s <path>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 5, 2019 at 8:43 AM Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> On 2019-03-05 0:42 Eric Sunshine <sunshine@sunshineco.com> wrote:
> > As with the commit message of 2/3, many of the words in this message
> > are separated by multiple spaced. Please fold out the excess so there
> > is only a single space between words.
> >
> > Also, no need to say "previously" since readers know that the patch is
> > changing something. Rewrite in imperative mood:
>
> Okay, I'll keep that in mind from next time onwards. The spaces were
> provided to make the commit message look aesthetically pleasing.
>
> These changes aside, is there anything you would like to add to the review?
> or is it good to go for a merge?

I don't understand your question.
