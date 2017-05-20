Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8375201A7
	for <e@80x24.org>; Sat, 20 May 2017 12:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750814AbdETMKu (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 08:10:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36503 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdETMKt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 08:10:49 -0400
Received: by mail-it0-f68.google.com with SMTP id i206so7485208ita.3
        for <git@vger.kernel.org>; Sat, 20 May 2017 05:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j3rjNBB32jP682I83LeagL9pypwEW4nJHuvk97/21LU=;
        b=ewRZ1HTrO6m+1US6b6uW+8u6+I/l4U3iHV0YNMRMv53bhjU6RSnHmNdE9vBvazb/DU
         vL7Ctca+fafZhzpayxvr6T8ir40akWEm1jiJL1xSozKVzGXSd2vASfB2+LykO6zrmbC8
         5qPczyuNfQUdjp/jtR9VOJ7aEh/qILDyFeQWZNS4b1/yywYMO+5c9xZ7B+D8TPRZK5ut
         qgEBFrsjvUipI8RsFB5F7ySu7OiAjADOnD8+Q2hbIYE2x0+YHUbVZL2qYDI6MYRK/eU1
         fo35D4XMlJueDPAk6AGOv+WKilCNqtO9LxqXm5rCrUhAY3D13FBNsYDpLf/Ay5i+fBgV
         49Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j3rjNBB32jP682I83LeagL9pypwEW4nJHuvk97/21LU=;
        b=AiGbEjGClIcDKB0bhA8C6izU09zxtyMi388Y6PkO2J+L7RSvhfdSmkiF+slfvqSjCl
         K9kzEVVQl9Q4CpSal/g2T7WoSSk8OVLizd5oyA4ub6dAD7LpBLR/v51kaTx2GI2ZhTQH
         QVZkvKEz4WN9Nq1zGSgnYaAtzoQR54I6cqXl8rc+yb2uUvX0DkcYY4b08371BxpZnHxk
         n1Z6oqnkGjZjw6hfzEz1Ib5IJPGPLrsW2wK83xSfTWyo18+TAmC3XBwvQeJJcgR2zh6O
         2zBScnZGL25jm0uFpPkYKjXz9zy5PCuyRk7izjfxd2mUfcH5Uu6fdmhDTPQAoVrLisWN
         RSrA==
X-Gm-Message-State: AODbwcDcuyDUoUGt6+bVpMFrn5aBW1bd8Y4PM+Xgt6RDS+cUx6aLf07H
        QnXaJOOJ4FphNuIy4fH/vNgoUqUlHg==
X-Received: by 10.36.89.207 with SMTP id p198mr31646116itb.71.1495282248533;
 Sat, 20 May 2017 05:10:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 20 May 2017 05:10:27 -0700 (PDT)
In-Reply-To: <20170518201333.13088-6-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com> <20170518201333.13088-6-benpeart@microsoft.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 20 May 2017 14:10:27 +0200
Message-ID: <CACBZZX5URAeA+=12ezW-oDGnkdAqvQqV7it=HBaYCKUdx0p_XA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] fsmonitor: add documentation for the fsmonitor extension.
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, benpeart@microsoft.com,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David.Turner@twosigma.com, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 10:13 PM, Ben Peart <peartben@gmail.com> wrote:
> This includes the core.fsmonitor setting, the query-fsmonitor hook,
> and the fsmonitor index extension.
>
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  Documentation/config.txt                 |  7 +++++++
>  Documentation/githooks.txt               | 23 +++++++++++++++++++++++
>  Documentation/technical/index-format.txt | 18 ++++++++++++++++++
>  3 files changed, 48 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 96e9cf8b73..4ffbf0d4c2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -389,6 +389,13 @@ core.protectNTFS::
>         8.3 "short" names.
>         Defaults to `true` on Windows, and `false` elsewhere.
>
> +core.fsmonitor::
> +       If set to true, call the query-fsmonitor hook proc which will
> +       identify all files that may have had changes since the last
> +       request. This information is used to speed up operations like
> +       'git commit' and 'git status' by limiting what git must scan to
> +       detect changes.
> +
>  core.trustctime::
>         If false, the ctime differences between the index and the
>         working tree are ignored; useful when the inode change time
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 706091a569..f7b4b4a844 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -448,6 +448,29 @@ The commits are guaranteed to be listed in the order that they were
>  processed by rebase.
>
>
> +[[query-fsmonitor]]
> +query-fsmonitor
> +~~~~~~~~~~~~
> +
> +This hook is invoked when the configuration option core.fsmonitor is
> +set and git needs to identify changed or untracked files.  It takes
> +a single argument which is the time in elapsed seconds since midnight,
> +January 1, 1970.
> +
> +The hook should output to stdout the list of all files in the working
> +directory that may have changed since the requested time.  The logic
> +should be inclusive so that it does not miss any potential changes.
> +The paths should be relative to the root of the working directory
> +and be separated by a single NUL.
> +
> +Git will limit what files it checks for changes as well as which
> +directories are checked for untracked files based on the path names
> +given.
> +
> +The exit status determines whether git will use the data from the
> +hook to limit its search.  On error, it will fall back to verifying
> +all files and folders.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
> index ade0b0c445..b002d23c05 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -295,3 +295,21 @@ The remaining data of each directory block is grouped by type:
>      in the previous ewah bitmap.
>
>    - One NUL.
> +
> +== File System Monitor cache
> +
> +  The file system monitor cache tracks files for which the query-fsmonitor
> +  hook has told us about changes.  The signature for this extension is
> +  { 'F', 'S', 'M', 'N' }.
> +
> +  The extension starts with
> +
> +  - 32-bit version number: the current supported version is 1.
> +
> +  - 64-bit time: the extension data reflects all changes through the given
> +       time which is stored as the seconds elapsed since midnight, January 1, 1970.
> +
> +  - 32-bit bitmap size: the size of the CE_FSMONITOR_DIRTY bitmap.
> +
> +  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
> +    is CE_FSMONITOR_DIRTY.

We already have a uint64_t in one place in the codebase (getnanotime)
which uses a 64 bit time for nanosecond accuracy, and numerous
filesystems already support nanosecond timestamps (ext4, that new
Apple thingy...).

I don't know if any of the inotify/fsmonitor APIs support that yet,
but it seems inevitable that that'll be added if not, in some
pathological cases we can have a lot of files modified in 1 second, so
using nanosecond accuracy means there'll be a lot less data to
consider in some cases.

It does mean this'll only work until the year ~2500, but that seems
like an acceptable trade-off.
