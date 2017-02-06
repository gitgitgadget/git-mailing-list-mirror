Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C5E1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 12:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdBFMkf (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 07:40:35 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32840 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdBFMke (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 07:40:34 -0500
Received: by mail-qk0-f181.google.com with SMTP id s140so53176353qke.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 04:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=bOIR+IeR6BEkBgUE+OS9wlxbMbSvWe1Jra+B7QJ4oj4=;
        b=BeazU1LYjb0hSzp5BhnbeWOwgAYxzXRyUisdJWja/iDb6DmGXMAmtZq29ix7Dt+PgM
         0i6xdftZuBUPMAYLeFEN17bi8yTxjNRucPOdv01lmvha8o3HtMWGv7Wm4vN5exuV+KLL
         odj/xbQBfw4UuiVaG+AxSW22KT6b+A0efR7UnGcwU5zdSbtlsQM6x+RwW+iLI4uOW+8T
         CF6g7i0KSHhNy3QTv8FLe77uCVD4yUsoGxOGaUAAUocFllosaYYfWYWgCpPh4XXhSdLq
         Z2Xz3A7MK/xuwAOtQJcBTc2QGDOR4T72TdHkaVTDxvV6scza81RDSY67imAojJ8J8G5H
         0F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=bOIR+IeR6BEkBgUE+OS9wlxbMbSvWe1Jra+B7QJ4oj4=;
        b=QlDFCHuQy2fIzpjTET+F/GiFKHwgAEzp7FubdO0iELpzrE+u0g8Wn44rIWqikX5JgS
         SaQhSa3nuIYHjwNN/zdieJ8zJtmXDZr+Xx980qUytSYUkQKjbi6EicfhmrI5Or4xfjky
         D2biCk7duub11BjlTGD+vLZ2TcpqkaW1SCj3bvpkaKE/5jYKsz4tE0xmKy2EnYvzwyvV
         msNZDHR98zAj3scPihv7h7USTdrsYYv2/zGDEP85pd/J8fQIoQb7xTRuM7rCwnMdN8QV
         exJpfGMsywoPxBiEjB9IaC8ft+m1WSm4jDOqBO8Dk1/PECSXWgUrorCjQmdt0EJ5+QHs
         lZ+g==
X-Gm-Message-State: AMke39mKEXCo/efkEccJFParpcX+uPai2RtVMXO82pNq7rvW7eHh1XjoZx6oWIQ3eq0yJb15cQeJD/RiFXBMPg==
X-Received: by 10.55.54.143 with SMTP id d137mr9096758qka.258.1486384833821;
 Mon, 06 Feb 2017 04:40:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.226 with HTTP; Mon, 6 Feb 2017 04:40:33 -0800 (PST)
In-Reply-To: <CAOc6etZ7iuPKRQkYSZDrDRW0hxbu1aYMRuzB1iXAPv+EEnXJEg@mail.gmail.com>
References: <CAOc6etZ7iuPKRQkYSZDrDRW0hxbu1aYMRuzB1iXAPv+EEnXJEg@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 6 Feb 2017 06:40:33 -0600
Message-ID: <CAOc6etbtEBUkSXHKzNuobJ9CGgb4yrLcJSTvH3vy=XBt-qcdaQ@mail.gmail.com>
Subject: Re: A little help understanding output from git blame --reverse
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 6:38 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> I'm "difflaming" HEAD~100 (02db2d0421b97fcb6211) and HEAD
> (066fb0494e6398eb). Specifically file abspath.c.

I just noticed that I'm standing on a private branch. Replace HEAD for
"4e59582ff" when doing your analysis. You should get the same results.
