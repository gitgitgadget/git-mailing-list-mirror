Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9EEC1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 13:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeI1T74 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 15:59:56 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:43911 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeI1T74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 15:59:56 -0400
Received: by mail-io1-f48.google.com with SMTP id y10-v6so4157192ioa.10
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=qZT7+YIKQ9AdW+GgtO642BjPmGSvnn2MJRBuTbr8oeg=;
        b=r3KGkvFtOYZuPjODZrI0eJrtpFj6bemlFqRwaoO7e6UlLv1NYSbIfAmnA6ttVeYE9E
         eUaLUMmD4CpJK+ZJlVoVRrZg7vgdCbMx/fdwgzkOG1RqrclursfLQLdbE1g0jJ0kd/r2
         ShUFu1sGf8hSrLjUDeidQ4s1hdGkwv+WB9jUWXVsbrrNUmxwWxTof1h7njpZLS5RMeTD
         1immSsM0ky6YGNlIbjlBHqNW00hcG2UpknpHmglMWrRArLgNzRcCFSNbaLUZ1gnhif28
         4mIMAZG3Auci75kMATFLWM8pZcIIJ1DQnV5gC41h9goqlmcxHbROEmGOrLieIQq0kpEu
         q6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=qZT7+YIKQ9AdW+GgtO642BjPmGSvnn2MJRBuTbr8oeg=;
        b=pQXMNcJ7aYqwophlp1d+8Xmpi/nqo2274J95AcLrkSUYkKnPfA2f3tk1nhVbvoKrHW
         0adY28RTnv85sZmHW6f4izV8Cv8uDa4tDhjv1q8Gg4cx/2JY3MpL0+u/15Ok+neYDtUg
         BYZ3tJhAJph/HBOyD+p5uYgGUeNvOY+Z8qIYBp43BtAda+YIall9kYmx2189ylsyspZP
         1P7oB12M/Rm5zaEqk7LvEG9PZg+imYHg/3N2d8x5TDxmYjJ+Y+U+sAGU4E5LWjLtl5e9
         2ZN7xeJpRvqdQwYkSqhQFDWRrqjgM69idn1gQ1GfNPq9mBIYON53mQLyGR4cSuvjBvQa
         Mhig==
X-Gm-Message-State: ABuFfoiELkhdmvTfn6usV0So7NkolaO/YP9R6rFqgNNubvwS8xrx9GY3
        CboG/gKX2wJ9qgO2agQKHwTHD8NM575jh8M5Wn4Tl7Bq
X-Google-Smtp-Source: ACcGV63/GVKHtzoGUuHAzrkrvZ1/67KSjZMtSXNjWSIrhV/AIR7lcx3WXPCEmZMFX9NmA+RPUHZbUx33M1t2hqIJUkE=
X-Received: by 2002:a6b:3902:: with SMTP id g2-v6mr11980555ioa.168.1538141766618;
 Fri, 28 Sep 2018 06:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <CADF5XCygzArjd9rgY_x_BqnhL5QpFL1CO1JjOHnBQc3HFn_JdQ@mail.gmail.com>
In-Reply-To: <CADF5XCygzArjd9rgY_x_BqnhL5QpFL1CO1JjOHnBQc3HFn_JdQ@mail.gmail.com>
From:   Raman Gupta <rocketraman@gmail.com>
Date:   Fri, 28 Sep 2018 09:35:55 -0400
Message-ID: <CADF5XCxfmuqXau4YGrGgfU6JgxbHthZn5o5_t6J=x9JEaS_K4Q@mail.gmail.com>
Subject: Re: --skip-worktree and operations like checkout / stash /etc.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the meantime I've created this simple script, but what a hack...

#!/bin/bash
git ls-files -v | grep "^S " | cut -c3- | readarray ignored
for x in "${ignored[@]}"; do
  git update-index --no-skip-worktree -- "$x"
done
git checkout -m $@
for x in "${ignored[@]}"; do
  git update-index --skip-worktree -- "$x"
done

Regards,
Raman
On Thu, Sep 27, 2018 at 6:29 PM Raman Gupta <rocketraman@gmail.com> wrote:
>
> The comand `update-index --skip-worktree` seems to be an ideal way to
> tell git to locally ignore some modified files. However, this seems
> not to play well with very common commands like `checkout` and
> `stash`.
>
> $ git checkout other-branch
> error: Your local changes to the following files would be overwritten
> by checkout:
>         path/to/ignored/file
> Please commit your changes or stash them before you switch branches.
> Aborting
>
> Ok, well lets try stashing:
>
> $ git stash save
> No local changes to save
>
> Ok, lets try a checkout with a merge:
>
> $ git checkout -m other-branch
> error: Entry 'path/to/ignored/file' not uptodate. Cannot merge.
>
> Ok, lets force this sucker:
>
> $ git checkout -f other-branch
> error: Entry 'path/to/ignored/file' not uptodate. Cannot merge.
>
> Ok, at this point I'm wondering, do I really need to
> --no-skip-worktree all the ignored files, do my `checkout -m`, and
> then ignore them again? Umm, no, that ain't gonna work.
>
> I'd love for git to just check if my worktree-skipped changes will
> merge cleanly into the target branch, and if they do so, go ahead and
> do that merge (with perhaps a notification printed to the console) and
> keep the skip worktree status. If the merge ends up with a conflict,
> then feel free to no-worktree-skip it and show me merge conflicts.
>
> Regards,
> Raman
