Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1F81F404
	for <e@80x24.org>; Thu,  4 Jan 2018 21:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeADVCh (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 16:02:37 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:45783 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbeADVCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 16:02:36 -0500
Received: by mail-qt0-f175.google.com with SMTP id g10so3469842qtj.12
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 13:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YZwPg74WzHrRFvhBRa9SAOmSkjbAffYNXVb51UkgfQs=;
        b=GyzVtFBiqsf7l5yPe8e43IrNNVUf0xRf5eTaCiJzezlBpPzGJMyBQPcdUruxgT0nLq
         FGAmSwWp/VsLDAamPRaX8C+a07K7E15qb9BaR8e1tV+ETysTtkZtfB8PnEv3HvOCPso1
         rhgrtevoAoB/xnuYlAXGE9SiuPh+eA4pqMa0ojs3YjIdb7t2Lwk+IzfoXWRBrm2lmJuw
         gzRsJZLZoE9E1r96agd3VqlFCLjBIETmXjhk2jx/bCtqBrWwE5jmnnbSVzTPt6NovV+p
         wuJL+TnCF32Iqf1p+qpb4nqprN0UuVKJMTmCS/QrTBrQyPnH9Pjm017We6nd3xij0pqm
         7oxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YZwPg74WzHrRFvhBRa9SAOmSkjbAffYNXVb51UkgfQs=;
        b=H5F3WeEv7Wc/owXI8WwjSXnWvPJqJ7i1KicK4brjfk6GfyJmMjAP/s0HwWDJ4hqej+
         ZSJmm3ys7KqYAaef719Va3JSiQw08lbojbEUau2rPwi07HWN4gvyLDCV/L+3cMS0sQE9
         W613WFDAnWJx1APhCbhLUcYZbvR2U+SnDIePF7n/wB9N+iZ0EjX6LylnHRjO9nS4bSFA
         rc8mUAUAQ8+69e1BHsiT6ZbrPf76OaQmCKmWpXVXj6PxjMc4s6yw49CqV2LevfI4ftp2
         4ma/hoxu1sJEegKTcj9C91osNqLyatgE5rIc5ZvJU83GspmtHgAf0iqW6yQYHYYzf2uS
         05Nw==
X-Gm-Message-State: AKwxytfs/AR+XcVn7HOtW10J/EuR7WAnpda0rBbVA6etBD31XSkRrplc
        4t3ad8iS9fRxIVWGaXbzAp4HhGSQ3mpbwNGVA6g=
X-Google-Smtp-Source: ACJfBovFs6aL4ER4FkugfX3URVzuvHvEvS8p6tFILMaGuGO2JDtDUKqsJguDr7jy4Zt8hdZlB60ErDrqpCX4NfKSTQs=
X-Received: by 10.237.38.71 with SMTP id z65mr1252466qtc.114.1515099755585;
 Thu, 04 Jan 2018 13:02:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Thu, 4 Jan 2018 13:02:35 -0800 (PST)
In-Reply-To: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
References: <1515092151-14423-1-git-send-email-git@matthieu-moy.fr>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 4 Jan 2018 16:02:35 -0500
X-Google-Sender-Auth: Gu1GWr92gIP4Yglw-4c77XROZbg
Message-ID: <CAPig+cTrevRN64Mv2HS25_Z6ZJAf_wyHN8jqOSx5s3dfAf_0ow@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] add a local copy of Mail::Address from CPAN
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Thomas Adam <thomas@xteddy.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 4, 2018 at 1:55 PM, Matthieu Moy <git@matthieu-moy.fr> wrote:
> We used to have two versions of the email parsing code. Our
> parse_mailboxes (in Git.pm), and Mail::Address which we used if
> installed. Unfortunately, both versions have different sets of bugs, and
> changing the behavior of git depending on whether Mail::Address is
> installed was a bad idea.
>
> A first attempt to solve this was cc90750 (send-email: don't use
> Mail::Address, even if available, 2017-08-23), but it turns out our
> parse_mailboxes is too buggy for some uses. For example the lack of
> about nested comments support breaks get_maintainer.pl in the Linux

s/about//

> kernel tree:
>
>   https://public-inbox.org/git/20171116154814.23785-1-alex.bennee@linaro.org/
>
> This patch goes the other way: use Mail::Address anyway, but have a
> local copy as a fallback, when the system one is not available.
>
> The duplicated script is small (276 lines of code) and stable in time.
> Maintaining the local copy should not be an issue, and will certainly be
> less burden than maintaining our own parse_mailboxes.
>
> Another option would be to consider Mail::Address as a hard dependency,
> but it's easy enough to save the trouble of extra-dependency to the end
> user or packager.
>
> Signed-off-by: Matthieu Moy <git@matthieu-moy.fr>
