Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5F61F4DD
	for <e@80x24.org>; Sat, 26 Aug 2017 23:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdHZXxW (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 19:53:22 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:59413 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdHZXxV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2017 19:53:21 -0400
X-Greylist: delayed 1001 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Aug 2017 19:53:21 EDT
Received: from mail-lf0-f53.google.com ([209.85.215.53])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1dlkd4-000MrR-RA
        for git@vger.kernel.org; Sun, 27 Aug 2017 01:36:38 +0200
Received: by mail-lf0-f53.google.com with SMTP id d202so10553588lfd.5
        for <git@vger.kernel.org>; Sat, 26 Aug 2017 16:36:38 -0700 (PDT)
X-Gm-Message-State: AHYfb5gKsHt2jdaODtcNdS7dAUKPElRXmwRDh+ezpZFcRDHURFWanZGh
        f+kAPspLEBJwql+d91XelVJYxxvAtA==
X-Received: by 10.46.14.2 with SMTP id 2mr999741ljo.164.1503790593359; Sat, 26
 Aug 2017 16:36:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.46.87.5 with HTTP; Sat, 26 Aug 2017 16:36:32 -0700 (PDT)
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
From:   Johan Herland <johan@herland.net>
Date:   Sun, 27 Aug 2017 01:36:32 +0200
X-Gmail-Original-Message-ID: <CALKQrgdRwch4d837OwOJUxPPmUc43janx1VROvAoEJG2ef3SJA@mail.gmail.com>
Message-ID: <CALKQrgdRwch4d837OwOJUxPPmUc43janx1VROvAoEJG2ef3SJA@mail.gmail.com>
Subject: Re: [PATCH 00/12] Clean up notes-related code around `load_subtree()`
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 26, 2017 at 10:28 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
[...]
> plenty that could be cleaned up in the area:
>
> * Make macro `GIT_NIBBLE` safer by adding some parentheses
> * Remove some dead code
> * Fix some memory leaks
> * Fix some obsolete and incorrect comments
> * Reject "notes" that are not blobs
>
> I hope the result is also easier to understand.

I looked through the series, and the patches look good to me, although
I do agree with Junio's comments on #2.

Thanks for a long-overdue cleanup in one of the hairier parts of
the notes code. The end result reads a lot better IMHO.

...Johan
