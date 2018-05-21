Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57C41F51C
	for <e@80x24.org>; Mon, 21 May 2018 15:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeEUPJR (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 11:09:17 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:43387 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbeEUPJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 11:09:15 -0400
Received: by mail-ua0-f174.google.com with SMTP id d4-v6so10106124ual.10
        for <git@vger.kernel.org>; Mon, 21 May 2018 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E9hyFFrUYfgUuoFTM6eHrXZsSqp6D5B8q8DnkIv1mTE=;
        b=knZZn5ziL5iqcW/s5i9gIAGx2UJ9/69dPXqteUW3/7WQOQ9Akg8Npd9AjdGTI77qex
         +7yBP3gsueiV5mexU5n4vnP05MQe6d9oLOfXrdo/AC/IE8Xew7b3GggE099kvav/ifew
         BdIApRzl5op2ozH+y3NTAjezSU+gr1Q1mAaHOuomNzCTJkDeQZ8Ob3WnEjngwmtWy+NR
         GMHWkHKRi1cfMAWtNG3vYMiTWmaypadmoP65DzyVBYzyHswq1xAVcXOg6movN7quef0+
         zMUy4BTvlxtQJWAhkT1YH0xgL6Kdjxpn+AwfZU4Z/6WNN8qKJ6JPB5i1sq8uYG0QDL7O
         tAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E9hyFFrUYfgUuoFTM6eHrXZsSqp6D5B8q8DnkIv1mTE=;
        b=dyNeaglIu8O+ozPt+45kPy1XKMuHAe0iHYcx23HNftnfxNkrSrpzeKb7JM+WD3h2eR
         /+KtcvJaeI4SWjHk9lskz867LdGFcjriPIa6RRbyU1IZunJONCvY8vdehHtwVDKCUd+0
         BtnAffa7tmQMM5XlJipdpXFw6NO4yFQZBnQUky/89JsMdgRZwd5bG7PihApNcbC0ueFz
         W0XNL2ui1gVKRIa269mt3qHgI3LkLbMNOucFLVRSv6euCrjyQn/vZI65IM6YAVNvy7Pi
         23Hq9xuJQRGMAorhn45N8WLQtsWuWOu1gMx+QLpfv4v+Dkrpa4EyHgZuZNM2Fta6ka66
         6liA==
X-Gm-Message-State: ALKqPwf0xJ0+d13Jh3RmTLLOqQq9XjahzIGUkXLMfk2XmGujZ8UZHrtJ
        PwYy3LsGHK5iPOJV5CAjxrrSIT+r1Y6JgEjbna4wfg==
X-Google-Smtp-Source: AB8JxZpuZ+3sgl8geXbwlqGJ7yyy95TSI6P1CsfJaeiFpfeKYR0cZRPUGBkunNwFWb5g7Zkel2E5BTLOTQAA2GAsIDY=
X-Received: by 2002:ab0:1592:: with SMTP id i18-v6mr3840499uae.199.1526915354806;
 Mon, 21 May 2018 08:09:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 21 May 2018 08:09:14 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 May 2018 08:09:14 -0700
Message-ID: <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com>
Subject: Re: which files are "known to git"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

On Mon, May 21, 2018 at 4:18 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   updating my git courseware and, since some man pages refer to files
> "known to git", i just want to make sure i understand precisely which
> files those are. AIUI, they would include:
>
>   * tracked files
>   * ignored files
>   * new files which have been staged but not yet committed
>
> is that it? are there others?

Doesn't the first category of yours include the third?  I always read
'tracked' as 'in the index'.

I had always assumed prior to your email that 'known to Git' meant
'tracked' or 'recorded in the index'.  However, a quick `git grep -i
known.to.git` shows that we're actually not consistent by what we mean
with this phrase.  A little test setup:

  $ echo ignoreme >>.gitignore
  $ git add .gitignore
  $ git commit -m ignoreme
  $ touch ignoreme
  $ git ls-files -o
  ignoreme
  $ git ls-files -o --exclude-standard
  $

From Documentation/git-clean.txt:

    Normally, only files unknown to Git are removed, but if the `-x`
    option is specified, ignored files are also removed.

  This implies that ignored files are not 'unknown to Git', or fixing the
  double negative, that ignored files are 'known to Git':
  $ git clean -n
  $ git clean -nx
  Would remove ignoreme
  $

From Documentation/git-commit.txt:

    3. by listing files as arguments to the 'commit' command
       (without --interactive or --patch switch), in which
       case the commit will ignore changes staged in the index, and instead
       record the current content of the listed files (which must already
       be known to Git);

  This implies that only recorded-in-the-index files are known to Git:
  $ git commit -m testing ignoreme
  error: pathspec 'ignoreme' did not match any file(s) known to git.
  $

From Documentation/git-rm.txt:

    The <file> list given to the command can be exact pathnames,
    file glob patterns, or leading directory names.  The command
    removes only the paths that are known to Git.  Giving the name of
    a file that you have not told Git about does not remove that file.

  This also implies that only recorded-in-the-index files are known to Git:
  $ git rm ignoreme
  fatal: pathspec 'ignoreme' did not match any files
  $


I can't see any evidence of usage that suggests any more categories
than tracked and ignored, but whether ignored files are included in
the set of 'files known to Git' appears to depend on which man page
you are reading...which is rather unfortunate.

Robert, since you're working on documentation of sorts anyway, would
you like to propose some patches to fix things here?  I'm not entirely
sure what to suggest, and we might need a random suggestion to get the
discussion started before we figure out what we want here, but it'd be
nice to fix this inconsistency.


Elijah
