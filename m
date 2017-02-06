Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7EF1FC46
	for <e@80x24.org>; Mon,  6 Feb 2017 10:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdBFKSf (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 05:18:35 -0500
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36457 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdBFKSe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 05:18:34 -0500
Received: by mail-oi0-f51.google.com with SMTP id u143so44437624oif.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 02:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vedI94g/QBP9YoR3RDqEEcPbg9iJQg35v34BII6mXbI=;
        b=br9DLsgUajf8kw7Rl2cB3RgsKW+9QOokSPov/3aWt0xdi8GnalQfeJUHv/uvpgAuQI
         G1gNZKnJj3ZlyIBTT4gmenIYeXJ7igzTDlWDuJSwlK2NL09FbwRyOmBMh8fdxgI0aJKJ
         HzAAiFCNGOXg1Szv7ztwH3obeQeduPz85rfcFLzhS17tBZV7MlNeggorq4SGpT90+9JZ
         EiZxaRNjf0cs7yjftAeFHR4qbwt1YJqJcX6L2mJxRLXBE0UbWFEw5Mxj7Psf7dTjQAWX
         ndC2IS27lO6xbodiBMY/7g/vlENJZBhUu9bXaFYK/3wnxrzKJGGntRm5SHYuazHYxN05
         ON9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vedI94g/QBP9YoR3RDqEEcPbg9iJQg35v34BII6mXbI=;
        b=YMkZRSyW6fyi073/G84X+wCjsgGbA+36YKXrQDabrELQI1VVtB34KONgaUNd9Mii04
         LxARN/T96tEdnYbo17dBYw1GEmSh7J3HJJRMXf8/Ormlfdurno8mN0jbGD0/MqjJ+5VE
         IZIcOn7ekHOrK1Kznq+oHvUrjFSy9QFXPG75H21965fDw6X9FKUZnFsgbLNQyKZTF9qC
         AJU0Dgazzebt/HD0rUcwifyRvuYCAHRTOgKSWPArnd8phPIJSjAg7J7pOesBKdU6GvLI
         xWmBMN14WhEzcu9gSw26PJfOvXhgdx+RhCfyq5ZcLysvcSOocyGuxFRuSpWaAJYoJ5Qt
         bvQQ==
X-Gm-Message-State: AMke39lQv80Ozqp98lqlgGdt+j6h9h0oiBEFS0+LqzDPZWfW0tdNTqremNP3Cyi4N3573bl+YQ3/xjFGYj+d7Q==
X-Received: by 10.202.78.214 with SMTP id c205mr4722196oib.65.1486376313995;
 Mon, 06 Feb 2017 02:18:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Mon, 6 Feb 2017 02:18:03 -0800 (PST)
In-Reply-To: <CAJZjrdX_8tjMhRac9QQOW8m_S2DprFPV=uZp8mFT+g6bASVd-w@mail.gmail.com>
References: <CAJZjrdX_8tjMhRac9QQOW8m_S2DprFPV=uZp8mFT+g6bASVd-w@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 6 Feb 2017 17:18:03 +0700
Message-ID: <CACsJy8BCTY=T9f2ac7HUuHA-_RzjaxPHZNPQs9ecBhmsnDuRVQ@mail.gmail.com>
Subject: Re: git/git-scm.com GH Issue Tracker
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 1:15 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> # Irrelevant but someone should take a look
>
> 693

To save people some time (and since i looked at it anyway), this is
about whether "warning in tree xxx: contains zero-padded file modes:
from fsck should be a warning or error. It is a warning now even
though "git -c transfer.fsckobjects=true clone" treats it as an error.
There are some discussions in the past [1] [2] about this.

There's also a question "And I failed to find in the documentation if
transfer.fsckobjects could be disabled per repository, can you confirm
it's not possible for now ?"

(sorry no answer from me)

[1] http://public-inbox.org/git/%3CCAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com%3E/
[2] http://public-inbox.org/git/%3C20100326215600.GA10910@spearce.org%3E/
-- 
Duy
