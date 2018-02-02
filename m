Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA371F404
	for <e@80x24.org>; Fri,  2 Feb 2018 00:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeBBAqC (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 19:46:02 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33571 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbeBBAp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 19:45:57 -0500
Received: by mail-ua0-f193.google.com with SMTP id p12so13160219uad.0
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 16:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Dy91tGBf4rSyPyaDMoEL1/qmWBjp/ISqX1nzB2JlTc=;
        b=RJNupE2tEn+XLiBjF6dhlBK1B2z/EDnKGEmki9+B0hhV+feeJDsU5uIfoGVC3Hs7Sr
         UTIX934oI5jIdsgy1Hdr2/dctiOyBjxtnUW8pzUYSO7TJrvqzX6Us/3jgQWTSe2Mwbda
         DZjsFMoG8bFI8Iju/6ty6m46Q0phOvTWqfRdB/hb9PcYfWTXxMpHzMlGhKP57F6Zk1vM
         OH9hpOawaamZMvI6Whb5FxxqlRHXamZ2o52efWwOX/W6D7MZQgK4RMWIWrZAR5i+eQj0
         pcDOdvgkYfBkWf6xVPu5Xs+qoTiMGGIdwAT8ElblieUl21nK88RgnvA5EX7ve3SFCL73
         Ck9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Dy91tGBf4rSyPyaDMoEL1/qmWBjp/ISqX1nzB2JlTc=;
        b=AiKj+RP34o9l94PyLt5xiAPoHzDuYJ9rhXTKURhRUh28P+pNSEZY3fAcMaDyghRR5V
         o47G2ZqIa0n2OphIGi59cNE2+s9cxkNyS93Enazr3iV4Nh+NeJpHIxJE0sMmtZutPCcq
         vfECYYHfg0J5sP9sWlL8U8UclzpoJniHf+4D9j0NgFY9MC2eBWmnO8NoZaBtBW7JOFbX
         1j2rajtLjCSx9DY28t4V8RhRDsJYZn76pra2aNXMKK7Izm0waUMjw6PBDFRtHtqvCKY1
         e82Lk+H9DEhLjAwwA6mZpPN6HM4c8muf0U59tNusQxwIa2+TUlPnOhA51U1TVjJbdSKf
         Q+xw==
X-Gm-Message-State: AKwxytdiujNcj9xJD6/eDHNo1SdZCVWr8gJVNOKdJnX8IQns65EpuQM4
        7+69+BZLy3cbQSuFjZsLC8r/3iggRX2S3o4fje42wQ==
X-Google-Smtp-Source: AH8x224AbR4SgIC+e6bNX5BbnTJ4EzuNOl9pTN0SOM0BZ/hxmdAweCKxlgmU1GjAOMUTwql2yQM5hfYD4cvQD4SinRY=
X-Received: by 10.176.5.70 with SMTP id 64mr30638807uax.87.1517532356340; Thu,
 01 Feb 2018 16:45:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.8.83 with HTTP; Thu, 1 Feb 2018 16:45:55 -0800 (PST)
In-Reply-To: <CAGyf7-He4in8JWUh9dpAwvoPkQz9hr8nCBpxOxhZEd8+jtqTpg@mail.gmail.com>
References: <CAGyf7-He4in8JWUh9dpAwvoPkQz9hr8nCBpxOxhZEd8+jtqTpg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 1 Feb 2018 16:45:55 -0800
Message-ID: <CABPp-BGJiS96_wXTp4dpVG4CpTEt--KGELykofimP-Wh4nFhdg@mail.gmail.com>
Subject: Re: 2 conflicts referencing the same path?
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Feb 1, 2018 at 3:00 PM, Bryan Turner <bturner@atlassian.com> wrote:
> While investigating an issue with rendering conflicts on a pull
> request, I noticed that the merge was producing this output (sanitized
> for paths)
>
> $ git merge --no-ff --log -m "Test" 190a25b6e0f32c7b8ccddf8c31e054149dece8b7
> CONFLICT (rename/add): Rename A->B in HEAD. B added in
> 190a25b6e0f32c7b8ccddf8c31e054149dece8b7
> Adding as B~190a25b6e0f32c7b8ccddf8c31e054149dece8b7 instead
> ...
> Auto-merging B
> CONFLICT (content): Merge conflicts in B
>
> (There are several other conflicts listed "between" the two I'm
> showing here, various rename/add, add/add and content conflicts, but
> I'm trimming those out to focus on the lines that I think are relevant
> to my question.)
>
> This merge produces 2 (or is it 3?) conflicts for the same B path:
> - Rename A to B in HEAD, add B in 190a25b
> - Content conflicts in B

Right, so the merge-base has just one (relevant) file, A.  For sake of
argument, let's say it's contents is "hello\nworld".

One side of history, leading to HEAD, also has one (relevant) file,
which was a rename of A->B which also changed its contents to say
"hello\nbeautiful\nworld"

The other side of history, leading to commit 190a25 has two files.
The original A, whose contents has changed to say
"hello\namazing\nworld", and a new file called B.

When you merge the two, the "hello world" file has been modified
differently on the two sides as well as having been renamed from A->B,
AND there was a separate file also placed at B on the other side of
history which gets in the way.  Git resolves the
two-files-getting-in-the-way-of-each-other (the rename/add) by moving
one of the two out of the way (though it really ought to move both out
of the way, but that's a tangent).  And it resolves the conflicting
content changes in the other B by doing a content merge with conflict
markers, giving a file with contents of the form:

"""
hello
<<<<<<
beautiful
======
amazing
>>>>>>
world
"""

and it treats that B (from the "rename") as more important than other
(the "add") which it shows by recording it at B.

> I'm still trying to produce a set of steps that will allow a minimal
> reproduction, but I thought I'd post to the list just to see if anyone
> had any thoughts on how it could happen. Is it a "normal" (albeit
> rare) case? Or could it represent some sort of issue in Git's 3-way
> merge algorithm (in its behavior or perhaps in how the merge conflicts
> are logged)?

It is "normal" to get this, and functioning as intended, albeit fairly
rare.  rename/rename(1to2) and rename/rename(2to1) conflicts could
provide very similar situations.

rename/add conflicts have three issues I know about[1], but that
didn't include the output messages being suboptimal.  That might just
mean my mind has been warped by reading merge-recursive.c or that I'm
too familiar with it, so I don't notice how much it could be improved.
If you can think of how to improve the messages, I'm happy to listen,
especially since I'm trying to find time to continue my rewrite of
merge-recursive.  It'd have to apply to other rename cases, as noted
above (and, in particular, each side of a rename/rename(1to2) can
further be involved in other collisions, such as rename/add or
rename/rename(2to1), so it could get hairy quick if the solution isn't
simple enough.)

[1] https://public-inbox.org/git/20171120221944.15431-6-newren@gmail.com/;
that patch and the others in the series are waiting for the directory
rename detection series to progress before I resubmit.

Elijah
