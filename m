Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0575C1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 22:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933705AbdBPWgd (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 17:36:33 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34210 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933507AbdBPWgc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 17:36:32 -0500
Received: by mail-lf0-f50.google.com with SMTP id o140so919855lff.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=evwX7TvTPk2pAkZ4NgXNMB6B2U6EL61nwXVuMJZsKqc=;
        b=t5+G8F6tbrx21viYTIfGssGUxcbWB4LSb3HIZELQFJPvwHfLHUyZXfHyroSFUaG4cQ
         zRPFS1QYuCIZxVfOvEZRlvXw7dhmFGzWAm1rciw2qTGXCRz6fIFvtO204EydyrDcIWvn
         7yawpEYOVMQ7U55BP9iGeJhJ2wMguMMo0ZVyjtUUISNjX3EcRvCaqQjdMJebIuBe8NMy
         LBmGPvTutIk7fWjiFMBIV1FkgXFBpzPG+Wl1HrqvSMmloc9Okplucgi9RlrXtsyCO9X5
         QCbqKU7cAUBqnOiqJ5cme8gk2/FJqDIH7NXmE3zx7VsG5QaKgBiEXBaXxsBrYi3wrWnX
         ROzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=evwX7TvTPk2pAkZ4NgXNMB6B2U6EL61nwXVuMJZsKqc=;
        b=toNl0byAaOZ6YEM3AMIAgxWW1roTimuG0VJWzFzSrKJN29hiiQwurT07t7qaG5Q6Du
         72p1G64Kh0Ex2rqserJ77oUW5QjTomfls987PW9HSpOSV3BuIGa+YmAiahbbq4+jKqgG
         jvaxxwGEySvwVx2YWvLv4znF9c+J0TAfx3AlZrpYYsEClyimxxD0qo3JhWaU2UQ19CfH
         h8q0Twtg452p6B38HBIpVHLd5Qdvr9fXhCJXnB1JfEeJOvljdDKxlpKOH0bEBj0D5A5M
         FtDgx208bDGONNl8P0w3L1Cn6NHmMMsmiPHi7oGW8gQjyiAFAsOg8p+wuhz7psxbpmc2
         T4vg==
X-Gm-Message-State: AMke39nH6IytLruiK3/wunk5d01F2EiDpWoJu3wmhRGfXjExxpYmI11NTBjMLloX7sQCqoNEHqdG9zGRDH209g==
X-Received: by 10.46.22.18 with SMTP id w18mr1277788ljd.86.1487284590700; Thu,
 16 Feb 2017 14:36:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 16 Feb 2017 14:36:10 -0800 (PST)
In-Reply-To: <CAE1pOi3bpL0zTS9w2QCOrXcWk5pHj=xthxo2nYi8KEwJ=TgXfA@mail.gmail.com>
References: <CAE1pOi3bpL0zTS9w2QCOrXcWk5pHj=xthxo2nYi8KEwJ=TgXfA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Feb 2017 14:36:10 -0800
Message-ID: <CA+P7+xqWoUBOoFSiOTT5U-9aoqESUMnZeSGfvhGte2LqF18gmw@mail.gmail.com>
Subject: Re: There are too many unreachable loose objects
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 1:58 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> Hi all,
>
> Whenever I run "git push --force(-with-lease)" I get a variation of
>
> Counting objects: 187, done.
> Delta compression using up to 12 threads.
> Compressing objects: 100% (126/126), done.
> Writing objects: 100% (187/187), 21.35 KiB | 0 bytes/s, done.
> Total 187 (delta 78), reused 71 (delta 20)
> warning: There are too many unreachable loose objects; run 'git prune'
> to remove them.
> To git@git.company.com:project.git
>  + 51338ea...b0ebe39 my-branch -> my-branch (forced update)
>
> So I'll run "git prune" and, for good measure, "git gc" (which even
> includes "git prune"?). The first seems to do nothing, the latter does
> its thing.
>

It may be that it's the server side that needs to git-prune, and not
your local side? I'm not really certain but you're doing a push which
talks to a remote server.

Thanks,
Jake

> And then the next time (which could be a few minutes later) I get the
> same warning. My branches aren't that big, the largest ever had 40-ish
> commits. So abandoning a few dozen commits should not lead to this
> warning, I would think.
>
> What am I doing wrong?
>
> Cheers,
> Hilco
