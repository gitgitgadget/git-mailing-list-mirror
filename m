Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D25EA20248
	for <e@80x24.org>; Tue, 26 Feb 2019 20:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfBZUCf (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 15:02:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41627 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfBZUCf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 15:02:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id z25so11895280ljk.8
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 12:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3bRSDrs+VmaiHGzTuKFgFzUDkZQAx3PfsJSgoB7pDo=;
        b=D0SokHqvFm+Bv2h2C1XNd1hYy2LjsoZav1B33AdLKgH0/imN+dY59t6z1dDcuG4/q6
         YvOreQVhny8TZOUE9RHWpYDKPK8nUxAGwes0CZKCZPy+FRGqFhTFZd0Cmxhe3atzAQj4
         W4/zvidv9dzBGIrcYD4rLGoitpQQDkHJSU6ZecIs93wCzvsOgk7NCg6HXeQ6eYPcL37c
         Qpe1jLpne9ZK2QcW1zvTvlV/XZyLKZOhx1EmDloIiWsXrDjexeeH2T99EzW0VX+8qPFQ
         CoKrdi3NRzlEyndtanw45uETIvaMjyqFHzr3YHR+unCA+fUT+iZULv/vVuDuB3EAkX7K
         sgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3bRSDrs+VmaiHGzTuKFgFzUDkZQAx3PfsJSgoB7pDo=;
        b=FASpNb1DWDa6UxZpTxOtyqEhRpQXUP1G35l7Uwe3GwFryZRxwid5K4/GBBKEXFEmwE
         J8cTGInj+9Xz9AKTrzlFnP/MY/fKSxptAZIR6cIrb3f3yzw6ntzd7V4BxDSmrGubtNuD
         BvYWonjsNyif76YZh5casa9E7s/Tz7/LNXZkyuEHSkXewq8vHoVW33JF8qcMjgVBLNFs
         fzHj5/vR/0rKp9Z9peQrs1CtEghWXsx3BAx1QiIS8kq6O3qOhTmWBk3WbmrXRwGco2jp
         c2ORpbGJhXElSkXuD0PO4ZqxGeu8D4x95G4IrVGTJAnzR+COhn/yZCHpQKT5r0qqOLdm
         FR/A==
X-Gm-Message-State: AHQUAubrE6Lgd41/0evJjtBtrG7O36zdTq3RThdrwrzO8/HfOk4a8X46
        YxhOIVlv6olE4oVowuPplKBphrPGtNTqllYryzY=
X-Google-Smtp-Source: AHgI3Ib7vI5LmSZYqBXutZdeIdysCgnor9FbycxdPJTD3AmyXcE3e4UoLD0DWL4SS2k+pMOAXLFQYTUWYoqPxR7n/5I=
X-Received: by 2002:a2e:2c11:: with SMTP id s17mr14337955ljs.147.1551211353069;
 Tue, 26 Feb 2019 12:02:33 -0800 (PST)
MIME-Version: 1.0
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CAN0heSqSp-a0zUKT5EaGLBYnRtESTnu9GKWtGARz2kaOAhc1HQ@mail.gmail.com>
 <CAL7ArXoau1ZfBsV9JaUDprwjSijyo6K5d9JyC1mdfc=KEvgJxw@mail.gmail.com> <nycvar.QRO.7.76.6.1902262051080.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902262051080.41@tvgsbejvaqbjf.bet>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Wed, 27 Feb 2019 01:31:34 +0530
Message-ID: <CAL7ArXq37k2qmjLSB6DROq3K_wd0YaD9a-thNXgVwcxX7BEUMg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests: replace `test -(d|f)` with test_path_is_(dir|file)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey!

On Wed, Feb 27, 2019 at 1:22 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> We already have `test_path_is_missing`. Why not use that instead of `!
> test -d` or `! test -f`?
>

Yes, I think this is better. It will satisfy all the requirements I guess.

Ciao
Rohit
