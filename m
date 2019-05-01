Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E61B01F453
	for <e@80x24.org>; Wed,  1 May 2019 10:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfEAKMF (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 06:12:05 -0400
Received: from mail-it1-f169.google.com ([209.85.166.169]:38713 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfEAKMF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 06:12:05 -0400
Received: by mail-it1-f169.google.com with SMTP id q19so9151202itk.3
        for <git@vger.kernel.org>; Wed, 01 May 2019 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQ/ivQ4cL9RIKgeXnYTUN3vpzR50H7WenYyDnU9GYHA=;
        b=jsdXfRJ3WkkEd3oaghfLky/v4v19wUldgW5+yNeR8j6fZQMgMhw2d0EpBrJBETNSZ7
         DDjnzTHQxKZCO3EfINyP5zC/YTVS5xE8SwG0R5D1XjDRkTOrsDQG21Jqa9ZUqGAn1qHD
         7AAxxbZRd5LvUACjizU5Zte0l9o2EFByZOG5wMWdatkQxZp1f+ZPLhWsr8RAYBDEWeS4
         /8dDXs5iq/d6tIh2e6sBjjXHVrk8XCvPeqqr8Z8lBiOgbV6u3GROZM7JLxl4A3kP0bSp
         tpgvjcGhbd2nv7fHQMbnJ/iS9En7RD9k4dJdTC53MNx7nH9WuGmEk+mND2VA1YkalFlF
         rW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQ/ivQ4cL9RIKgeXnYTUN3vpzR50H7WenYyDnU9GYHA=;
        b=b9PtjKL7iBHZ8GvnJEOkRgaOPbMlvD9zx1glhVr+i/gzQ5SLrfCn0EK4HpLC6MmI5W
         f3QaHmV/Yqw0Xl9FugHBytSYfDpCMzezrnoG4yyZU69QwW9E6jNcgHkewheaxWHPAipk
         I4caydbQA6VqBluAc94ZjfDkJGD04uAKaoRBBJbBPggBB0hCJAh95+znLJMzAZjSeW8V
         LXjBRqzd7wThiHz9yJe9bhdpWSpKgrWAEJwP3cIWKj4M8d7/VS5rvtZMsAHSbXJpccKE
         Rqf2RLahCpYpmvZ2dD+XID0jbc3yN3TCkEOpJ5Ly20jTHR7xIZQ6Q/hApLIEXyf3Dryr
         plAg==
X-Gm-Message-State: APjAAAWcpkfbzccpFW3do+ZwB5Q59oW5i2DIiRVAnPzhJMbltqDKwns6
        isvXEmnBUSRjoDGFAvl5vAAo1TXOxSR+OYr8KSo=
X-Google-Smtp-Source: APXvYqw0zQDNV3FbAm9zF9xK8sxdsEs5wvdGln1Xl/Dj3+S3bIyxRJ+klOy/s7PFQBI3bptrhW8eUu51r4sL26lczkM=
X-Received: by 2002:a24:4d8a:: with SMTP id l132mr7416058itb.70.1556705524625;
 Wed, 01 May 2019 03:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHtYWY4g4BYDr_z7pfS-p=aX_YkVo4HzGR1Dsytn4RkzBo0GjA@mail.gmail.com>
In-Reply-To: <CAHtYWY4g4BYDr_z7pfS-p=aX_YkVo4HzGR1Dsytn4RkzBo0GjA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 1 May 2019 17:11:38 +0700
Message-ID: <CACsJy8DHH_PqZ9DQ5jpA_4AuLmVXmt3F3x6nYVGqZ1pNWnC5+Q@mail.gmail.com>
Subject: Re: Contributing with documentation/translation
To:     Priscila Gutierres <priscila.gutierres@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 1, 2019 at 1:10 AM Priscila Gutierres
<priscila.gutierres@gmail.com> wrote:
>
> Hi
> I want to contribute to git by creating and/or translating
> documentation. Where may I find the info to do this?

For translation, you could start at po/README. That's mostly UI
translation. I think some team actually started document translation
too [1], but I don't know the status.

For creating/updating documents in English, I think our documents can
use some improvements. Just pick one document under Documentation
directory, read it and see if you can understand it (if not we
probably need to rephrase or reorganize a bit, sometimes a lot). I'm
not so sure about creating new documents. That's usually done when a
new feature/command is added.

[1] The ground work for that seems done in 3d5b568f1a
(Documentation/Makefile add optional targets for l10n, 2019-01-07)

--
Duy
