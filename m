Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D6E20372
	for <e@80x24.org>; Thu, 12 Oct 2017 15:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbdJLPpN (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 11:45:13 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:45284 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbdJLPpM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 11:45:12 -0400
Received: by mail-it0-f42.google.com with SMTP id n195so7832180itg.0
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xlGgg1uXA7+PsXTXOolt6ssRPu7ZC0Ug9LacB+vQT84=;
        b=QLjPZFkBwU5DpDx1AKgkuiYtu5IZTUQm69H3Ce7d2DoYJKXkQEDnlPyTnsBIoLCyDj
         gsG6n/P+xAsW1R3a5f3aHwQwgTG66gcQDZY6Qq16fTS1mD10jUTvQoXVGtDMOgHpeeSh
         XUAQDioiFcZBHwi8UD99NmXobBeycw/cjIAazDGTy5tIbp7kYf/BRN0jzlljWoCWfUzA
         2e/QRVOtXb1xjG775DGFnec9h/yKoyCf6v1ZxCJqFSI20ArXVXQx2iok4aC1YnENtmLk
         Qc4f9ByZFKWgLPa9fYfCatBcexse7ldGkvHBqnxzGHhJP0x3rat2bKfTqIXwL0l9jNn7
         d5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xlGgg1uXA7+PsXTXOolt6ssRPu7ZC0Ug9LacB+vQT84=;
        b=QLJ1Tma0qgxNQYiHveOmMdxwn8NMl2lwquu+BGQGaAhwL8m7EnU/krHlPIsxK6alR4
         4vqtuYquJERSiYbaru7oxQ1Nd+4+cnjYe2cGX0O3/VWMV/kJXoEuXMBBMsEchUj8ggaR
         ZaNdnXCmaWx7DmCqy3UUY8Rz8SXFtlBolWA8znbaRLBpvaMwj8zEvsXFSX7oo3/OjnJp
         MGvi94tQnbyjZB0ijjdZ591SooafbB2C2mu6jgzgk1Q+xFS4A3KwxUfszJ4tNOJF3LNL
         +NCU2nnZw4YLmyrhBP3+jJsHrNWHJJLVbppR8AyR9uAsoTQUL+yP544OchT7R3WqEI7Y
         4sHQ==
X-Gm-Message-State: AMCzsaVk+vXR81wvn3hnrHBawc+955GJUWy9AbkCkHhh8ybAkIcoyugw
        cty5UlqjgZSm5X54VaKCinvEiwkz6EY21DRZWVk=
X-Google-Smtp-Source: AOwi7QBqXlamXpc8rkiXd40OeBlgD02cgkQLkUqtI5xrMAfz/s3X8ZOW3qPvR/DpZMdTVXkXqPpVuVYp6+H9xtNbP/c=
X-Received: by 10.36.111.4 with SMTP id x4mr3498229itb.144.1507823111882; Thu,
 12 Oct 2017 08:45:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Thu, 12 Oct 2017 08:45:11 -0700 (PDT)
In-Reply-To: <CAP8UFD2THRj7+RXmismUtUOpXQv4wM7aZsejpd_FHEOycP+ZJA@mail.gmail.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
 <5a9242024013345d7a3b0f63580360cdc8cc1c43.1506714999.git.jonathantanmy@google.com>
 <CAP8UFD2THRj7+RXmismUtUOpXQv4wM7aZsejpd_FHEOycP+ZJA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 Oct 2017 17:45:11 +0200
Message-ID: <CAP8UFD1hivP2sRK74z-cq9+HDzD4hWcjDeQe5tHbr_LcygtQUQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] sha1_file: support lazily fetching missing objects
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 4:42 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> Instead of adding labels and gotos, I would suggest adding a new
> function like the following does on top of your changes:

Sorry for the usual Gmail related problems. You can find the patch and
a further refactoring that adds an object_info_from_pack_entry()
function there:

https://github.com/chriscool/git/commits/pu-partial-clone-lazy-fetch-improved
