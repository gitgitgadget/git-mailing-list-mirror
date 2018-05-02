Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B46D221847
	for <e@80x24.org>; Wed,  2 May 2018 14:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeEBOzl (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 10:55:41 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43077 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEBOzk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 10:55:40 -0400
Received: by mail-ot0-f195.google.com with SMTP id y10-v6so16879641otg.10
        for <git@vger.kernel.org>; Wed, 02 May 2018 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mQYETu0551sYpcnqEvHjI6FPSfQDgJixX+x93TSAlWU=;
        b=XLwxcOAY/E0NLgjnvQmrmixHdqTumcGAJjMC7oxUP6EOmmp5gtrRrbon3BQGaPPoVB
         TxOD+QZSaLqwFsB2x+67mQjGLePcxssMfeYVylDi/531NED6GFWOMfMi/P1/4xl+NcDW
         dTvjseazeOhgMJqQwlwB9REthDybjNhNefaXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mQYETu0551sYpcnqEvHjI6FPSfQDgJixX+x93TSAlWU=;
        b=HlgpAF5vy7MlIpYQ6hG1qk/0eMvQgAhlUlvmFHPxBVmFaAS4keja8pmOjj/ilI6mau
         xo4L604/yp8q+V/FqjXn95ouVw+J4iznqXv9pPC+jLgq5q22wVOJWSReE/MV0FCM0Ug6
         fQ0fmvt7/OWCKrd0dRDss45uaENmIqt8IhB1oqUJEh+mLxNI3+pdbIH3UZZjV811DmO2
         vRki6BaG7Lz7PgCXZEdSTEit+oK5Nl/SGBZOhL4mRm2XMlxtbQhs2SU/BUKK2P9iGcAJ
         y6uDVUN+8OMtCr+ej6B5wcaTpwbMfUY0MpcHpDbuoAr46gQd7qZtPIjT99066c+3godE
         uiTQ==
X-Gm-Message-State: ALQs6tBmd+8nzMyaDjdlomHhsx6YmtpwZjUF3ThHxnBD8AeltGHz+0ze
        4Ddwp3ynQuBMsWNDh5Y69MB7WxzqQDl8NnVMUY2rfw==
X-Google-Smtp-Source: AB8JxZqLRrGHiaCBez/rIs1JOI9AMJALWGDjv5qjX5EePwYXk8xk8x1o1hPK0b4uYYp7hiHYpDOYy3LYDYxkNebOT0I=
X-Received: by 2002:a9d:53cd:: with SMTP id i13-v6mr13170788oth.181.1525272939791;
 Wed, 02 May 2018 07:55:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3c5a:0:0:0:0:0 with HTTP; Wed, 2 May 2018 07:55:39 -0700 (PDT)
In-Reply-To: <1943804476.5328267.1525271559834@mail.yahoo.com>
References: <1943804476.5328267.1525271559834.ref@mail.yahoo.com> <1943804476.5328267.1525271559834@mail.yahoo.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 2 May 2018 15:55:39 +0100
Message-ID: <CAE5ih7-71WakVOYLhREchcnOP7HtYfMqPMKvp9r+TMdsTJJmPQ@mail.gmail.com>
Subject: Re: [PATCH] git-p4 - Add option --sha1 to submit in p4
To:     Merland Romain <merlorom@yahoo.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 May 2018 at 15:32, Merland Romain <merlorom@yahoo.fr> wrote:
> From 4867808cad2b759ebf31c275356e602b72c5659f Mon Sep 17 00:00:00 2001
> From: Romain Merland <merlorom@yahoo.fr>
> To: git@vger.kernel.org
> Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Luke
> Diamand <luke@diamand.org>, Vinicius Kursancew <viniciusalexandre@gmail.com>
> Date: Wed, 2 May 2018 15:02:11 +0200
> Subject: [PATCH] git-p4 - Add option --sha1 to submit in p4
>
> Add option --sha1 to command 'git-p4 submit' in order to submit in p4 a
> commit
> that is not necessarily on master.
> In that case, don't rebase the submitted changes.

That could be very useful, I often find the commit I want to submit is
half-way down a long list of other commits.

Currently I end up cherry-picking the one I want into a clean repo,
but that's much more awkward than your --sha1 change.

A few comments inline:

> Signed-off-by: Romain Merland <merlorom@yahoo.fr>
> ---
>  git-p4.py | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 7bb9cadc6..d64ff79dd 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1352,7 +1352,9 @@ class P4Submit(Command, P4UserMap):
>                  optparse.make_option("--update-shelve",
> dest="update_shelve", action="append", type="int",
>                                       metavar="CHANGELIST",
>                                       help="update an existing shelved
> changelist, implies --shelve, "
> -                                           "repeat in-order for multiple
> shelved changelists")
> +                                           "repeat in-order for multiple
> shelved changelists"),
> +                optparse.make_option("--sha1", dest="sha1", metavar="SHA1",
> +                                     help="submit only the specified
> commit, don't rebase afterwards")

Is there a better name than "sha1" ? If git ever changes its hash to
something else will this still make sense?

I wonder why you wouldn't rebase afterwards?

Perhaps an additional option to skip the rebase?

>          ]
>          self.description = "Submit changes from git to the perforce depot."
>          self.usage += " [name of git branch to submit into perforce depot]"
> @@ -1362,6 +1364,7 @@ class P4Submit(Command, P4UserMap):
>          self.dry_run = False
>          self.shelve = False
>          self.update_shelve = list()
> +        self.sha1 = ""
>          self.prepare_p4_only = False
>          self.conflict_behavior = None
>          self.isWindows = (platform.system() == "Windows")
> @@ -2103,9 +2106,12 @@ class P4Submit(Command, P4UserMap):
>          else:
>              commitish = 'HEAD'
>
> -        for line in read_pipe_lines(["git", "rev-list", "--no-merges",
> "%s..%s" % (self.origin, commitish)]):
> -            commits.append(line.strip())
> -        commits.reverse()
> +        if self.sha1 != "":
> +            commits.append(self.sha1)
> +        else:
> +            for line in read_pipe_lines(["git", "rev-list", "--no-merges",
> "%s..%s" % (self.origin, commitish)]):
> +                commits.append(line.strip())
> +            commits.reverse()
>
>          if self.preserveUser or gitConfigBool("git-p4.skipUserNameCheck"):
>              self.checkAuthorship = False
> @@ -2215,8 +2221,11 @@ class P4Submit(Command, P4UserMap):
>                  sync.branch = self.branch
>              sync.run([])
>
> -            rebase = P4Rebase()
> -            rebase.rebase()
> +            if self.sha1 == "":

if not self.skip_rebase:

> +                rebase = P4Rebase()
> +                rebase.rebase()
> +            else:
> +                print "You will have to do 'git p4 sync' and rebase."
>
>          else:
>              if len(applied) == 0:
> --
> 2.17.0
>
>

This would be better with some documentation in git-p4.txt and a test case!

Regards!
Luke
