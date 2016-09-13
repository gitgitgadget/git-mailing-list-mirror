Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E6C207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 00:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbcIMAfu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:35:50 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:32771 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbcIMAft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:35:49 -0400
Received: by mail-qk0-f169.google.com with SMTP id w204so160512635qka.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qjhyM3xd/5IxPHzFOjyrsGFJbu4Uqjlto/QWcs5rkV4=;
        b=m+vsZNcP3GUo+tRNVLPHOIwtTq3wBLUkKOjtbBrKdzUm2TfsP/jFetahNYfqVbFOhb
         jHnSGurVqJiKqvkoLG6XvHU8uOownd/1jvduyw4Bt5/bz9ymYQfV/2lZZ/GIP6AhMlbJ
         oL4pING+hCWvSEsv95k5AbCaUmVoccGrbTIlUSbb5NCG0re6aGVHYiKpkyVo8FBxZtXY
         WDjAsFpA0TfsXmurihb1wX94rVG4aC5sMf3qTUK0j0sbN6BGIDK5wSJwBNRJ8/jm03Sl
         s+ru7y226K+zcj9rMjz/nA3XVFSwef/O118y8qOD6xTwLbNY53EFsUhoPr4tNQNOcuoG
         AFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qjhyM3xd/5IxPHzFOjyrsGFJbu4Uqjlto/QWcs5rkV4=;
        b=Xn1oEuNgzVaw6SP7/HQd/G3MD77XiqPbciYgWyTTiF/iuOoIJ228G9HnBPXCuvLe47
         7AGjM+f2QFhWeKKGk0vuAHqyGsiCVyQ1l4wvGu5V2NQIWYpbvul9JpJTuhn3KOES2BbZ
         y1IV1Q0ngd5rbt9P0W/Z+BqRxer1BTj15RE6hfIfw05qjjqXj4dlQLM4bM/FqCy16cWs
         eUUtd3fvbT+/mBeOZR5e95lhwug7k72CsYZ9K548ConBoOVthakjKhBu8vj7wQ2jwB53
         V3KaYvOXmQhvaFtbuL0ac7xBR1u2i/VAXGTqxG30CPOMEyI9kz87+7M2nlMyC0CLkNCO
         eTYw==
X-Gm-Message-State: AE9vXwM+OFI+g6UVZUSk4KJiJs1dBb2XNE2/JeKX8UtBvKjXaZPQyF/NAAv/y5xsiBodYYS2q/jSReeUVObTQw==
X-Received: by 10.55.108.194 with SMTP id h185mr9034288qkc.37.1473726948847;
 Mon, 12 Sep 2016 17:35:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.58.6 with HTTP; Mon, 12 Sep 2016 17:35:08 -0700 (PDT)
In-Reply-To: <CAOY7EmCYjajQPPAVhAhzt7g0yA=QH2R9HZEAhztUo2JbfSiCwQ@mail.gmail.com>
References: <CAOY7EmCYjajQPPAVhAhzt7g0yA=QH2R9HZEAhztUo2JbfSiCwQ@mail.gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Tue, 13 Sep 2016 10:35:08 +1000
Message-ID: <CAH5451nEq77uiSaY7mYCKXx4Ybp1nY8FHcAPwUkFQkf6a4xJpg@mail.gmail.com>
Subject: Re: Potential Same Name Bug
To:     Kevin Smith <noiz77@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

On 13 September 2016 at 09:29, Kevin Smith <noiz77@gmail.com> wrote:
> So when I move from master to develop that status would come up.  If I
> ran "git reset --hard" I would no longer have that message.  I also
> saw that when I do a git clone and specify to clone the develop branch
> that I would not see the git status above.  Is this an issue where if
> one branch has two files of the same name where one gets removed that
> it will remove both instances of that file in another branch when you
> switch to it?  I fixed this issue in our repo by removing the
> "file_NAME.png" file in the master branch, but it seems like this
> should be handled better in the case I described.

Just to clarify, is the machine you are cloning to on a
case-insensitive file system, or have you set core.ignorecase=true?

If so, I would imagine the behaviour would have been _interesting_ in
that repository before you removed one of the versions - that may be
why you removed it in the first place.

For future reference, the typical way I have seen this situation dealt
with is to git mv one file to a different filename, or using git rm.
There may be better ways to do it, and it's possible git should deal
with the specific situation you mentioned better, but I'm not able to
comment on that.

This situation commonly arises when you set core.ignorecase=false on a
case insensitive file system and then rename a file. When you commit
that change, git doesn't notice that the old filename has been
'deleted' (git sees a rename as a delete+create with the same file
contents) and so now thinks that you have two files with very similar
names in your working directory. To avoid this, make sure
core.ignorecase is set correctly, and use git mv -f to rename files on
case insensitive file systems.

Details at https://stackoverflow.com/questions/17683458/how-do-i-commit-case-sensitive-only-filename-changes-in-git

Regards,

Andrew Ardill
