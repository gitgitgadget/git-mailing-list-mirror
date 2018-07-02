Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D836E1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 21:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932126AbeGBVU5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 17:20:57 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:41415 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbeGBVU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 17:20:56 -0400
Received: by mail-yw0-f194.google.com with SMTP id j5-v6so7163021ywe.8
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 14:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTb17z0hCi4AOo2Fn/fxcIDEwdOjJqiokRR4KxzIl+I=;
        b=gK0E2YzYmU8JWQH81xb1/UJeQJQbi190/w2pfwJ+m7tt1Rdk/vVGnwgdjxDcy6t7Ql
         P5RwZ5C17j07gnN8OS2sTGPhijo+5DjhEXICLR3TNoHegWe5djjDJtXOD1B7xldFAA+e
         V9L3nTU6xiEmxuUrWrZc6cge31pcm4upqT88B/GsWtS1KcOy/EHZem/14VCLq8NI19P+
         YU0bVXGEGDejuUoHQC4sHMHlYtr2LW0PG/j/wb7bLOKvuyDviS8wTo4mLDcXF19IHLJ1
         j1zOMhHAv1hbtlh2hdSepKPvesEYMtkse+q0i3yRJJaMbftAPFo3m0FC1s9kdfIwmfOd
         deHQ==
X-Gm-Message-State: APt69E3sQr3+9LiYmK1OEj6j5uuiu8EYDCquFmOhQ6mZYruJpZnriJLi
        yX737Nr8acnhl5MfTz7jbdzPWTYbC/HS+qpeK/c=
X-Google-Smtp-Source: AAOMgpdn5jvGdcuVg4QqsFBMJUGiUbcCfmfJSJi5o9QD/P9Zoz3byzSfgqie37AEkYcSzDghIouplhXxHT9d68NBTu8=
X-Received: by 2002:a81:4153:: with SMTP id f19-v6mr5952010ywk.418.1530566454806;
 Mon, 02 Jul 2018 14:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com> <CAGZ79kZXhZyhDL_+cFK6BzL-RL7Ac0zKeKux97v9shc+qm+nOA@mail.gmail.com>
In-Reply-To: <CAGZ79kZXhZyhDL_+cFK6BzL-RL7Ac0zKeKux97v9shc+qm+nOA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 2 Jul 2018 17:20:42 -0400
Message-ID: <CAPig+cTUZ__JgvW4WZZPY0BG+jDgXS8FTU5pSghr0XUeObKDCQ@mail.gmail.com>
Subject: Re: [PATCH 00/25] fix buggy tests, modernize tests, fix broken &&-chains
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 2:27 PM Stefan Beller <sbeller@google.com> wrote:
> On Sun, Jul 1, 2018 at 5:24 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > This series fixes several buggy tests which went undetected due to
> > broken &&-chains in subshells, modernizes some tests to take advantage
> > of test functions (test_might_fail(), test_write_lines(), etc.), and
> > fixes a lot of broken &&-chains in subshells. [...]
>
> I think it is good to include it as is and build on top if needed. I had some
> comments on the earlier part of the series, but that is really just the cherry
> on top of the cake.

Thanks for the review comments.
