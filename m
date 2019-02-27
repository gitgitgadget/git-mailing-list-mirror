Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21F0A20248
	for <e@80x24.org>; Wed, 27 Feb 2019 10:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfB0KC1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 05:02:27 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:52049 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfB0KC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 05:02:26 -0500
Received: by mail-it1-f178.google.com with SMTP id e24so8416842itl.1
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 02:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8MA0e4nZjD3zfFrotdZoH2s6q1k+DUssQHOKu7RqUEQ=;
        b=pGv44k6UTdSHsUq0OuqT7kbfOKIgYV4jIOVwN+VnavkQIvdZr/aJYpAqXnsxmzpjaL
         F9ubkJVDHXykqiL+kwS9jfzYpSf/eyarJxJtDOPw2g4+CbK5gO9L1RSDmZjxFUENVilX
         VuR00qdEKrjXD/JNisRzk0XQXYcBvqWVV8XEehGvRrEBXwyUgCl1VkdX8cE+OPNAC125
         qI6gkFfHGmWnRF4e6B4yrwq8VTLOwaGp1Zlq/PvGrA6AtfOpcpPWHRZ/nFThDZy89td5
         m03lnnrXJS8jM3B6SnTAcbmoVUlpGUYTyp9L28vwLTjaySypgGqi5r/NzjZyGtyLmRJg
         Tqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8MA0e4nZjD3zfFrotdZoH2s6q1k+DUssQHOKu7RqUEQ=;
        b=IlYe+4rqG0Lk2lLvHKHPz+V2UbxR/sStOXEL4xXuqlHDwZsfkyGJv8IBYakT3jk7HG
         9JRHDNIIjhvcMKx2nbxVRGVnEdSKD/3Iu9M+B0xIqnzuV6ZR5ZEifqlw1w2wVfpZfbIu
         xVwi2C2jEYMfRKQaoRbAQbxRb2c8GzOgi/yuMqTc1amFtL12jg57zAtnMZ9tZluw6OlO
         Vh/VB97MfxMwvxS07fL4BtpDTkrJwQlMJiL5blWLEsOTHcjkSymhZqgOCxfj/JSS3jzP
         XzHKwglkxJNNLe2FdrbNHl8Kh0ReSYbI62OxTcY0c0V3fEemI5r+nDfXNvt9/pfrS7rV
         Imjg==
X-Gm-Message-State: AHQUAuZtQ++4FlTyuB7dIRT+2URbI8RifkUB4pZm8Qiopip9fWTw9mev
        ObDCrH3nQje/zEzwS65/cFsQeGWboDi38i5QlDE=
X-Google-Smtp-Source: APXvYqx99YcV94TM1CwvktYROsaAUPYHyZuyPlDwknmXGS7QT1REzX7Wp5OCUHOP2t4eNt16iUHwwaLU6NwVxj8N5+g=
X-Received: by 2002:a24:3b0a:: with SMTP id c10mr791579ita.10.1551261744576;
 Wed, 27 Feb 2019 02:02:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com> <87sgwav8cp.fsf@evledraar.gmail.com>
In-Reply-To: <87sgwav8cp.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 27 Feb 2019 17:01:58 +0700
Message-ID: <CACsJy8DjYUn+45E04gPjXhN0xqqjeyf8XoQsR8PyLefFrO4RGQ@mail.gmail.com>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 11:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Feb 26 2019, Duy Nguyen wrote:
>
> > On Tue, Feb 26, 2019 at 8:42 PM Rohit Ashiwal via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> >>
> >> t3600-rm.sh: Previously we were using `test -(d|f)`
> >> to verify the presencee of a directory/file, but we
> >> already have helper functions, viz, test_path_is_dir
> >> and test_path_is_file with same functionality. This
> >
> > It's not just the same (no point replacing then). It's better. When
> > test_path_is_xxx fails, you get an error message. If "test -xxx"
> > fails, you get a failed test with no clue what caused it.
>
> I swear I'm not just on a mission to ruin everyone's GSOC projects. This
> patch definitely looks good, and given that we have this / document it
> makes sense.
>
> However. I wonder in general if we've re-visited the utility of these
> wrappers and maybe other similar wrappers after -x was added.

It's personal, but every time I have to use -x I curse a little. It's
just often too much to read.

Besides what people have already said, there's another good potential
for test_path_is_file and friends. You can make it support multiple
arguments, so that you can check if many paths are file with just one
line. Used properly, this could reduce repetition and shorten some
test cases a bit without sacrificing readability.
--=20
Duy
