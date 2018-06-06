Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5076A1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 19:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752142AbeFFTyf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 15:54:35 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:41030 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeFFTye (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 15:54:34 -0400
Received: by mail-oi0-f49.google.com with SMTP id a141-v6so6396334oii.8
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Nqx0u8xl57oN6ubWs4wV/a/qSXIOJrRe2G52g6shYY=;
        b=H+ndVI30R2wdUGNKjcS9xmO0s83TG3UdPe0v9/OzWnLpsG3aHABCLh4FtScEmi4Igv
         erW9azdN+Mk+CDklooebuFNNf1gz+Q0FntePEfzR41yYsP9CzjjmtIw7+VSSoVCsSjIL
         bRwsALNUjAXGkASFLFuXxMyV8bU5/+VnXDyuoX2dMTukCQ8e0BRv6Wy7BO0WbOD2memh
         AeIGh1JIDzsy09GLn+CQcm1J9PFfIZEg9jNtRsVXoSuUtYcxdfqtcgfhOb494EM+TYqV
         Af3CTtIz2qh0FmQB7hxINQsg2rMfCqrungK/RmhdTRYnLklaSzv3utJ8AjF90l/919Fr
         +X/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Nqx0u8xl57oN6ubWs4wV/a/qSXIOJrRe2G52g6shYY=;
        b=UKdNROFnY0nE7nVtQBAhfI2YSPq2JcgDPAEXwhS2SRe8C4q99mse7TWbnbQdm8PsEb
         PyJY/J8yHRblOYmTMHbyRadezwYFimJjYVw6rK6YutNyNbZqHTHSItncSWznWb5sY0Ty
         W03+iqty4fmpKwbujYGdi+YafLr8OpiIdXeiot5x/k4QRiiCpRzoR+EfsPw3GNKFlLo8
         1j3HFl0X6lgnbFgA3JF2Sbh80LoxaNVQNCmT2daNwKpgp2AqRu/r4uCB3jvrpCLhAnBj
         uYD15YU2AxMbUkI10xeaHkY0SJrI3SJN6VJ2LkpEjEklVkLQdlL6pN1hJRD01racWKO4
         G+5w==
X-Gm-Message-State: APt69E1Mt/4b0PsSyk4ujVCGE9m15Ki9NeYWggH5nSgmnNss098Jy1JK
        pmm6JNRtWW+SAJgQdL+z8mh6aumqDudmpAiI/SrhxQ==
X-Google-Smtp-Source: ADUXVKICng8Jm0KZhdem8ZzR9tlaHXViVkhy47D0TL+VjMzIsdyXTgjPQXDFVqOOgUUnfqdIVr3XHbc8hN3YQ+UpOwY=
X-Received: by 2002:aca:fcc8:: with SMTP id a191-v6mr2674954oii.34.1528314873991;
 Wed, 06 Jun 2018 12:54:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 12:54:03 -0700 (PDT)
In-Reply-To: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
References: <1528313557.2662346.1398855328.3E0F8023@webmail.messagingengine.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Jun 2018 21:54:03 +0200
Message-ID: <CACsJy8CpsF8rtiJVtLK4d=7RdtPBy5QRy7XURFvpaWtQCynJkA@mail.gmail.com>
Subject: Re: git rm bug
To:     Thomas Fischer <thomasfischer@fastmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 9:32 PM, Thomas Fischer
<thomasfischer@fastmail.com> wrote:
> OVERVIEW
>
> "git rm" will remove more files than specified. This is either a bug or undocumented behavior (not in the man pages).

The behavior is intended, with a question mark. This change is
introduced in d9b814cc97 (Add builtin "git rm" command - 2006-05-19).
I quote the relevant paragraph from that commit

    The other question is what to do with leading directories. The old "git
    rm" script didn't do anything, which is somewhat inconsistent. This one
    will actually clean up directories that have become empty as a result of
    removing the last file, but maybe we want to have a flag to decide the
    behaviour?

To me we definitely should document this (patches welcome!) then maybe
revisit this "have a flag to decide the behavior" question from 12
years ago.

> SETUP
>
> 1. In a git repository, create an empty directory OR a chain of empty directories
>
> $ mkdir -p path/to/some/
>
> 2. Create a file in the deepest directory and add it to tracking
>
> $ touch path/to/some/file
> $ git add path/to/some/file
> $ git commit -m 'add path/to/some/file'
>
> THE BUG
>
> Run 'git rm' on the tracked file.
>
> EXPECTED BEHAVIOR
>
> $ git rm path/to/some/file
> rm 'path/to/some/file'
> $ ls path
> to/
> $ ls path/to
> some/
>
> Note that path/, path/to/, and path/to/some/ still exist.
>
> ACTUAL BEHAVIOR
>
> $ git rm path/to/some/file
> rm 'path/to/some/file'
> $ ls path
> ls: cannot access 'path': No such file or directory
>
> The entire chain of empty directories is removed, despite the fact the git outputs only "rm 'path/to/some/file'".
>
> This ONLY occurs when all the directories in the chain are empty after the tracked file has been removed.
>
> This behavior is NOT documented in the man pages.
>
> I propose that 'rmdir' statements are added to 'git rm' output, or that the man pages be updated to reflect this behavior.
>
> Best,
> Thomas Fischer



-- 
Duy
