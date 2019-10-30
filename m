Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648151F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 09:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfJ3JGk (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 05:06:40 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35939 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfJ3JGk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 05:06:40 -0400
Received: by mail-vk1-f196.google.com with SMTP id r85so307928vke.3
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gMyOd/F8pChyl3W7U3vLmpd87aUOmLxFUEka0Xq8cc=;
        b=Jegs4sdZSjUj7hBNzdxuGW8q9CCKQ/YEEImCXUpQMMcUiOgjpPPxGUwahmrKlVn0Wq
         z9tHW7c7+oV2pg0Ed1oU6PsAjcJ04SZn2GTVCXhEmi3D4Tm8ydji0KemeD6AVKNap8De
         VAikkUkBgNT075gbkVW170x6nnqLWRCv3B+v/7RJwfkH8qPvgC4QK59VqVW4YdZC3UyQ
         smV9ybC5pgoxfvK/SZNfsq3z8DH909p4R9uSmcySbkDF74Ory9Hbl6epCxCFhh3CVJjX
         MxBiiocPfvNE6AuE5xNLsRKUhVCD313HCXAXryB9LJxVvvTq20zyAi0XjQ72L5IiZhlO
         zMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gMyOd/F8pChyl3W7U3vLmpd87aUOmLxFUEka0Xq8cc=;
        b=ldlIy7htHVvCmJk5IHzW6UhqN1CgVn5bByBl7rFBeTpuvMYsLUHq18CCbKSP+IWtIC
         7RynhsjI1y9wWo4YNcSW49Jh2a1sia0SEwqETxf/UZgwNoHx4zPq0pp3ZgUZ2MSRQJI9
         DX6zo6MBvDGR1NBU9oTXgCGPshFQikl0C/Oyc3QpMjneCTGZQ7JfYA6rbF8RrB+fQ9no
         9kxVA1qqTHFuwFSCaEcJTWTVhn3zGCTqCHViaFPQV2t6WEYlLN7y2UnBJIs7duTNN7qY
         IQ9Y9G16FltEezFupzfDWkZhGBc6BZOP28kU1cbhs1Ppd0GH7lQ/Ik3E9YnycuIqenk6
         wm3w==
X-Gm-Message-State: APjAAAUhxlgE4Ar4rW8Iq1wHDoRxMcjpnEdQxUhf+CuYOQ+VuhgsHkAU
        l+uzYQVXsHPU0BpsIB4bCOK9Iz8ClTobZq8ycHNzWw==
X-Google-Smtp-Source: APXvYqynvjKLy6aWWp+0b6jxhmt9tbMKoCn7bQwO0h7e5TJWgR2tJttJGDh4V2THTL07z/XVTmcppyz58jxwyw20lfQ=
X-Received: by 2002:a05:6122:11aa:: with SMTP id y10mr10668930vkn.64.1572426399038;
 Wed, 30 Oct 2019 02:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.git.1572418123.gitgitgadget@gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 30 Oct 2019 10:06:26 +0100
Message-ID: <CAKPyHN1p+xRAF3Mjg_XqRiEUviGjj8ifP5FM=1hVb5LZUshzLw@mail.gmail.com>
Subject: Re: [PATCH 0/2] git-gui: revert untracked files by deleting them
To:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 7:48 AM Jonathan Gilbert via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> My development environment sometimes makes automatic changes that I don't
> want to keep. In some cases, this involves new files being added that I
> don't want to commit or keep (but I also don't want to outright .gitignore
> forever). I have typically had to explicitly delete those files externally
> to Git Gui, which is a context switch to a manual operation, and I want to
> be able to just select those newly-created untracked files in the UI and
> "revert" them into oblivion.

in Git speak, that operation is called 'clean' (see 'git clean') why
should we overload the 'revert' operation here?

Bert

>
> This change updates the revert_helper proc to check for untracked files as
> well as changes, and then changes to be reverted and untracked files are
> handled by independent blocks of code. The user is prompted independently
> for untracked files, since the underlying action is fundamentally different
> (rm -f). If after deleting untracked files, the directory containing them
> becomes empty, then the directory is removed as well. A new proc
> delete_files takes care of actually deleting the files, using the Tcler's
> Wiki recommended approach for keeping the UI responsive.
>
> This is the second revision of this change, which differs from the first
> version in the following ways:
>
>  * The change is now based on git-gui/master.
>  * With one exception, all lines are at most 80 characters long. The
>    exception has a string literal in it that pushes it to 82 characters. I
>    think it would be messy to try to split it, and I got advice on
>    #git-devel to just let it go to 82 characters.
>  * camelCase is eliminated. I eliminated it from existing code in a separate
>    commit.
>  * try is no longer used anywhere. The code that cares about the result (had
>    code in a catch after a try) uses [catch].
>  * Deletion of files and removal of empty directories is now handled by
>    separate procs.
>  * The deletion of a large number of files does not block the UI during its
>    execution any more.
>  * The revert_helper code no longer uses an epilogue of generic statements
>    to be evaluated on exit.
>  * When deleting files, the UI is notified about the deletion directly
>    instead of doing a full rescan.
>
> Jonathan Gilbert (2):
>   git-gui: consolidate naming conventions
>   git-gui: revert untracked files by deleting them
>
>  lib/index.tcl | 343 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 266 insertions(+), 77 deletions(-)
>
>
> base-commit: b524f6b399c77b40c8bf2b6217585fde4731472a
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-436%2Flogiclrd%2Fgit-gui-revert-untracked-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-436/logiclrd/git-gui-revert-untracked-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/436
> --
> gitgitgadget
