Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632F31F404
	for <e@80x24.org>; Wed, 15 Aug 2018 21:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeHPAAx (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 20:00:53 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:56109 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeHPAAx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 20:00:53 -0400
Received: by mail-it0-f50.google.com with SMTP id d10-v6so3548657itj.5
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUkUoPN5Du3fM2IylYbYP73C8NZvuz8jaSZfDmobeIo=;
        b=QokVMRFmD7g2rtylIlLbbcU7T0ruWVGk5oedYYEBHgw2dOr6wg6OudaVALF5+X+vO8
         AN22/U17Kmfv8Pp7x2sKzQOPkp20tEoIJ1qshZw2ckWaNsTCTB0qeD+OsPHmm4Svu4D1
         xQdEvuMED0K8hXoOs7/t8OXXFwC2oh+Ny1/UgRSTBp7L3ea9RvdKWpM6KyUoVO6J9M6A
         puKQ9TTobqmgjZrx0b3mWeIslASIkq4CHBVVpO1JofsLX+maz2yM6xhV9gatMH/ByiDC
         4dpq/KtbMmDN/XJtsjgV6OyqKnNVVdEIyOW2ntkQ7NoEXTaglkt36tKX8k4CRAX8SuW8
         WpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUkUoPN5Du3fM2IylYbYP73C8NZvuz8jaSZfDmobeIo=;
        b=OB6u7UoK2ntw7qzGdOZSG+r6RXcufpgrwk7N6sVe7Nr4WRaI+tRIs5hNnwFcdG44jn
         uLLo9hTkGwVsz1/r/AUOOTucZkyRRYIPz8dEO3VVlav2IbCgBBL5crHi7PRrrZYosWCX
         kR5tC2gWRKgmbpp+/GXkWwILA5Qbh/9PFp1JDbIhZl4hOvzxBeJn0TyKJKSHCPuUyuln
         RM0/t71y69rspFrS5WIGJJjpBZnsdobTzCkYgrszzUvzhrh/+U+p1z4mLM2jrhJNO0mT
         8aN7ggXk/7x7PUavcBPDoQlzNI7b6PNy3KHSxUXE6EATREXOLhMSlY0mlX4k9XBJbOr5
         tnsw==
X-Gm-Message-State: AOUpUlEnX8CQbP4U1wKo8NAqbeEZkVZuWN1EllaQ5pmqUHYCLOGhxy/S
        yHOrC55F0UzZT4rcP9+T5ez9Xpb5tj0v2k1Jusw6GEfw+wpUow==
X-Google-Smtp-Source: AA+uWPwqs7VdMXPLXqJj2DwAJWzp3DxBxapWdUIZx+horkdr2Qqmm+++Od3cAYY5v3iyiLeDXudOPglnOZqLUUj6fk0=
X-Received: by 2002:a02:b468:: with SMTP id w37-v6mr23362353jaj.18.1534367222226;
 Wed, 15 Aug 2018 14:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <6022fbe8-0e07-f561-5e66-eeb4bc92704d@hadisafari.ir>
In-Reply-To: <6022fbe8-0e07-f561-5e66-eeb4bc92704d@hadisafari.ir>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 15 Aug 2018 14:06:51 -0700
Message-ID: <CAGyf7-EKCznDksZ6jovmtoA94Tj2V95zkMkS3PJrYfEYsO9U3w@mail.gmail.com>
Subject: Re: "Changes not staged for commit" after cloning a repo on macOS
To:     hadi@hadisafari.ir
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 15, 2018 at 1:50 PM Hadi Safari <hadi@hadisafari.ir> wrote:
>
> Hi everyone!
>
> I encountered a strange situation on OS X recently. I cloned a
> repository (https://github.com/kevinxucs/Sublime-Gitignore.git), went to
> folder, and saw "Changes not staged for commit" message for four
> specific files. It happened every time I repeated the procedure. I even
> was able to commit those to the repo.
> At first I thought there's something wrong with repo, but I cloned it on
> Ubuntu 16.04 and everything was OK; no "Changes not staged for commit"
> message.
>
> Does anyone have any idea?
>
>      modified:   boilerplates/Nanoc.gitignore
>      modified:   boilerplates/OpenCart.gitignore
>      modified:   boilerplates/SASS.gitignore
>      modified:   boilerplates/WordPress.gitignore

Taking a look at the repository's file list on GitHub[1], it shows
that this is because HFS and APFS by default are case-insensitive.

The file listing shows that there is a "nanoc.gitignore" and
"Nanoc.gitignore". On APFS and HFS, those are the same file. As a
result, one overwrites the other. This is discussed pretty regularly
on the list[2], so you can find more details there.

[1]: https://github.com/kevinxucs/Sublime-Gitignore/tree/master/boilerplates
[2]: https://public-inbox.org/git/24A09B73-B4D4-4C22-BC1B-41B22CB59FE6@gmail.com/
is a fairly recent (fairly long) thread about this behavior.

Hope this helps!
Bryan
