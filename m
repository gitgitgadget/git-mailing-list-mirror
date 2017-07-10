Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D7120357
	for <e@80x24.org>; Mon, 10 Jul 2017 22:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754656AbdGJWpV (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 18:45:21 -0400
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34911 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754106AbdGJWpU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 18:45:20 -0400
Received: by mail-ua0-f175.google.com with SMTP id j53so63638245uaa.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 15:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ouUMyUcBCta6wstS08NoX2CJ4Oklg6wVCUsJjgqleiM=;
        b=RKl7oUgWx1DCkNC61gt1/nAfydviEKpveVZvgzsxlpbfAjCFdYZZ+kZHIm//z9h4Sv
         XBmNVj8ZRVXo4uj13oImEtvDLkJDUPx18mBjtMePNroW+oLCVYJEWlmwl/oDzzdzmdwh
         ufbM8u4J6WPXa7sExIIu22h6b863Ohqn4wuHAU29FEDnT1o+hJnipk7lsH6tAJhNHt27
         ejlexWqji22EWc3+DQKDL8kffkqqqQhCJ80Eo8AMEzj2WNCOTB48VpzBrfew1d0AKL3b
         cHf3GZPJcVbEZRk1r7aTiVZsflCpH6+OU6LvwIIyjRgLygU2s6gPc2jxgisq8lbCh6wg
         7vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ouUMyUcBCta6wstS08NoX2CJ4Oklg6wVCUsJjgqleiM=;
        b=rD3y+L08ogov5HtezSkKIDZjkIo7QYfC++fBDZrVc29ndWUx8H/NEKN01Yatawzk2E
         HKkMAqZpTIqBZo/2q5odtMfgVOJ8eUE5fcSNGU3Nr83UtBHYw0nF4bj5YhG9x0M6++/W
         49vWHvG2bY3LRZt27bywvP0Tb4HJzcwolE4OkJ44hOIKwx1m0OYMw59zMor/DEk7IgFh
         MsoU1W7n78zL8l7m42zOXNjvc8Y2WYAG7AHEwIRsIxv5v7KQa48tiWtKY6NwzmUMPAc/
         vUHvZMQf61ewXT6fwlIjMuLi7PMRML+OEsB/iSYFASkIv/nEqlWbe0Z5hhGlyO+xhQQS
         Fong==
X-Gm-Message-State: AIVw110CpsVvOJnhKl1KXoTufx7J0/+NOXvdBW5U5TIShq3bkM3txkYB
        tEgW9S9TNFtGLa+DtWfbf7OUmwXo4uhr
X-Received: by 10.159.62.158 with SMTP id x30mr10526457uai.78.1499726719742;
 Mon, 10 Jul 2017 15:45:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.77.139 with HTTP; Mon, 10 Jul 2017 15:45:19 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Tue, 11 Jul 2017 04:15:19 +0530
Message-ID: <CAME+mvU_8-S4AhTtMYm1L6PK81v23wu4EuB+EnOgkDhi=jo9Rg@mail.gmail.com>
Subject: [GSoC] Update: Week 8
To:     git <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SUMMARY OF MY PROJECT:

Git submodule subcommands are currently implemented by using shell script
'git-submodule.sh'. There are several reasons why we'll prefer not to
use the shell script. My project intends to convert the subcommands into
C code, thus making them builtins. This will increase Git's portability
and hence the efficiency of working with the git-submodule commands.
Link to the complete proposal: [1]

Mentors:
Stefan Beller <sbeller@google.com>
Christian Couder <christian.couder@gmail.com>

UPDATES:

Following are the updates about my ongoing project:

1. deinit: This patch is updated after its last review.
   and the updated one is attached with this update.

2. summary: Most of the time of the week was utilized for debugging
   this patch. Its debugging is completed and the patch also went
   under some review off the mailing list. Hence, this patch is also
   attached for review in the latest update.

PLAN FOR WEEK-9 (11 July 2017 to 17 July 2017):

1. In this week a new version of 'deinit' patch is included, and well
   as the first version of 'summary' is also included. In the following
   week, I aim to work on improvising these patches.

2. Apart from that, I also aim to work on getting the rest of the patches
   ('status', 'sync', and other functions) merged.

3. There is still work left with the foreach patch, and I wasn't able
   to work on this week. Hence, I will work on finding a way of generating
   the path variable without any hacks.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/

Thanks,
Prathamesh Chavan
