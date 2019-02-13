Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6D11F453
	for <e@80x24.org>; Wed, 13 Feb 2019 12:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404083AbfBMMbt (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 07:31:49 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54041 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbfBMMbs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 07:31:48 -0500
Received: by mail-it1-f193.google.com with SMTP id x131so4254104itc.3
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 04:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y3RiaXaom5h+RR5wj6I1wafG3E8qS1P39MPCuxU0+js=;
        b=kmkQeub//7OCTeI8Vvqgfl4x8lvzIZkUt9kL+Nn96mwXcJXcn7CGaz9CzTudZSSUEr
         PbfFk9jSr/3yvkEd1CZ7J8iADT+sHCECnbNWy4uUsVRH+a3h5BOfvIqNBkIbEJcsfie7
         nkw146vJPvdw4BuzLZ1aBkfRxnBhGGKmQw+QxGoMTi7+knQ2uNAa6dTjKlRopwXoSfrZ
         OrwH3XDQKPCr3vSZ6dtX9DdfzXpbliNzkUIHMouL15S9BmEzf3flL1DlCtskx1+1LVcI
         +qxIFvTba4lIQzy3xMCuN0Oe/ISEYkD6TPZ6pBgQ8bGOu4dzSYI4GKlqIEZwqoLmU3vt
         XnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y3RiaXaom5h+RR5wj6I1wafG3E8qS1P39MPCuxU0+js=;
        b=o+Bl39ZbZW+H69zXff0/MbXSLjxMiTVnLbG5Xli7CCWRe3BvnGGq/X8LrnbTtavFOp
         C+9B3J+DP2KtS3s6HLIQJmxR8tqZdDA2447CCbt0BTUnckWNFBLris0kq0BGaglWsHvX
         d6H0bDGhvhg8gGa1J7ZYpnSA3BPoTsdsTPxqY+s1OMAliVEBQCj+5bmeJem4y6sYxCQz
         BfVGlfisPcAaCSseKdax+sblE1uVaMxWRqVjU2i5QBlLw/Bs5CIJkYsxUwcwwZLu81Q+
         7UReNP6Dz8Nj6s2YJuE4E2K5KCiR2cKUPzwNv7ZpyWxuyIhdcmFifIJHhMzvFf7Lqxt3
         t9Jg==
X-Gm-Message-State: AHQUAuYJRFHhV7ZzZssiVN1pKIx9HaAd1qucso+0EO1aIGdXVh8vWzoB
        Yl9gLApkf/MVSrAi+JaKAKWQddKD0PZ8ye/tGN0=
X-Google-Smtp-Source: AHgI3IZgxjHVQPD6/2N9WYgrVFA/iycRu2Sm5q2Ddmh+ntWb0VhrDJ1oYEM0ZHshP3PO+l2vHeb5XEA6/WQXuAkI77I=
X-Received: by 2002:a02:9c21:: with SMTP id q30mr152519jak.30.1550061108005;
 Wed, 13 Feb 2019 04:31:48 -0800 (PST)
MIME-Version: 1.0
References: <CAGXr9JHb1hjtMamdWt=oDg_eeBEuiDcbzAx+1XpV+HvvX1xsaA@mail.gmail.com>
In-Reply-To: <CAGXr9JHb1hjtMamdWt=oDg_eeBEuiDcbzAx+1XpV+HvvX1xsaA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 13 Feb 2019 19:31:21 +0700
Message-ID: <CACsJy8D2B_6yvBAQSeh3gvYHLOdfLmgiZ5Z=f4ZGeJ891X4Zjw@mail.gmail.com>
Subject: Re: Feature request on git log --oneline <revision range> -- <path>...
To:     Petri Gynther <pgynther@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 13, 2019 at 4:27 PM Petri Gynther <pgynther@google.com> wrote:
>
> git developers:
>
> Small feature request on:
> git log --oneline <revision range> -- <path>...
>
> Could we add an option to:
> 1) display all commits in <revision range> unconditionally
> 2) use a special marker (e.g. star) for commits that touch <path>...
> and list the files from <path>... that this commit modified
>
> Sample output:
> git log --oneline (--annotated?) HEAD~5..HEAD -- Makefile kernel/printk/printk.c
>
>   aaaabbbbccc1 uninteresting commit 1
> * aaaabbbbccc2 fix Makefile
>     Makefile
>   aaaabbbbccc3 uninteresting commit 2
> * aaaabbbbccc4 fix Makefile and printk()
>     Makefile
>     kernel/printk/printk.c
>   aaaabbbbccc5 uninteresting commit 3
>
> In other words:
> - commits that don't touch <path>... are still listed (without special markers)
> - commits that touch <path>... are listed with * prefix, and the files
> from <path>... that the commit modified are listed below the commit
>
> This is very useful for kernel LTS merges, when we want to know which
> LTS patches in the merge chain actually touched the files that matter
> for a specific build target.
>
> Is this an easy add-on to git log?

Adding the "*" is not that hard, I think. The hard part is UI. Soon
somebody may want to "list commits touching sub/ then add "*" on ones
that touch sub/dir/". Meanwhile I think you can still achieve that
with a bit of scripting and processing "git log --raw --oneline
<revisions>" output.
-- 
Duy
