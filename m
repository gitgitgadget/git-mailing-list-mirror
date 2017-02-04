Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED631F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 21:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbdBDVP7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 16:15:59 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:35993 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdBDVP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 16:15:59 -0500
Received: by mail-io0-f173.google.com with SMTP id j13so41839418iod.3
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 13:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fy+YEruTxI/Gqwhr6qqZbf9a3Nu7A8DMeTrbkxxNa/M=;
        b=SF4YPvr6vFLaEiCFGGTBmsxNChre03W0CgKnM9lhnbCrB+60gw65rVVzgZL23ZDOBI
         SsSd9ozH2gwIBh4be5TdGvbL+/TGFh3HGlxb3snl4sleriO0JAMcenpWlShf4Wd42vss
         /lnuXY9wonapm7gRExQnq/k9oMsn1VHTIhBrCWu/WQ9XsmC0T4iE7xiEnpatQW55Nz2B
         OIHWT3XDBdX4mjx82eUsYPRGSXnjX6iaceJ/Oi6OA/ik+mKxgGBR0Ao6OyodwTWs4IfH
         zfGYP08OC6CgEAou/4iiTpekyX2MP3WGcdyTPV2EWVd4s/HPK+lE/+1DQztPNyuP/LYJ
         wEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fy+YEruTxI/Gqwhr6qqZbf9a3Nu7A8DMeTrbkxxNa/M=;
        b=Ln/CBpQWobUQmtfJrAlQaQQGWr3yM6nAe/zztgk7/b4AtAqUUj4xkULyb3n046zPth
         U4b0TU56uSAJAVbk5aQ1L9ykkgoWr8XF2E8YYbtSjO7SUluGNufC33onWzOF+glybCA2
         hZytQ2wQboLYlLWbRfAG7BUL/wXdQRZq1rBZykQf3GBNG2tWC33A9KPEScfRXbW86sRh
         /nROJRn88stvnqywV9TpmObElzHvdaxEYI1SBVPaVcjjQR/3WGrp7dlz8oNxlf1fNdGK
         qHL7PgpLtjlOINSO9gNVWa2YXighXiVvLatXZ6+7rWTb0yUQdsLCrkH4R1nOtLI04biQ
         BcyA==
X-Gm-Message-State: AMke39m3yfC/stSR++OOGFfAJqlJsbDnvfqN7PDqoOjdzl75eTd0uc8UA06aLzz1VjWVO+ZQYIPDy8Zw9VG8Rw==
X-Received: by 10.107.161.83 with SMTP id k80mr2161052ioe.47.1486242946789;
 Sat, 04 Feb 2017 13:15:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Sat, 4 Feb 2017 13:15:46 -0800 (PST)
In-Reply-To: <1486218663-31820-1-git-send-email-kannan.siddharth12@gmail.com>
References: <1486218663-31820-1-git-send-email-kannan.siddharth12@gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 5 Feb 2017 02:45:46 +0530
Message-ID: <CAFZEwPOdL4mOAnmTUqs5LmfdG2GQCieVGVQ7T3ZWR0n+d6tCQQ@mail.gmail.com>
Subject: Re: [PATCH v3] parse-remote: remove reference to unused op_prep
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Siddharth,

On Sat, Feb 4, 2017 at 8:01 PM, Siddharth Kannan
<kannan.siddharth12@gmail.com> wrote:
> The error_on_missing_default_upstream helper function learned to
> take op_prep argument with 15a147e618 ("rebase: use @{upstream}
> if no upstream specified", 2011-02-09), but as of 045fac5845
> ("i18n: git-parse-remote.sh: mark strings for translation",
>  2016-04-19), the argument is no longer used.  Remove it.
>
> Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>

This looks good to me! Thanks :)

Regards,
Pranit Bauva
