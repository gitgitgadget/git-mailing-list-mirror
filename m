Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0751208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 23:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbdHOXEX (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 19:04:23 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:36236 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbdHOXEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 19:04:22 -0400
Received: by mail-it0-f46.google.com with SMTP id 77so10817253itj.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 16:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Payzl/lKegCFYRsvIMU1v/dIQPuFxQbiVRyz3ZZOLbI=;
        b=pdklKRSpgvI7dKtFmVGSTKsmB6R8aTDgVsABPk7+SX7hYZja+fjHLufUNDjHffFysc
         Y76vvOP73MkUE6DoYJrvlzjgFZ1ZOAwbbEJX3WSzZvtWAcgS1SKS+L7BFOlVhM5z8e19
         POq45bDfeUw2FNU9E7lqN2SW+Bhuqdi5RaJvVY1UzTC9fGZ1Vn7IMH5VcWpy1Vviu5nw
         8Eaa1nLCnQQPH7wrFi9+j9yxEpbtvWanXp39csHvWr3x13IAuSYVX7v4dK60ID1y5nhx
         5u6BlGHYErczMOHdiA5x+qsYSVFRl2Q4GZKThUGfis8oyO3oWMmjsSVoPXpHg6aKQqKC
         0+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Payzl/lKegCFYRsvIMU1v/dIQPuFxQbiVRyz3ZZOLbI=;
        b=anMsEtCGxNMiYHqGpHGyzsdToLtHLOx0uxQwYV/ByzZaHeHiUMvsNEU09PwDELWVha
         rapi9WR1AUS73+e9DMWgmr6Je9jlyBG2qrmUFxHdmZTUx13YRLRn4GEMittLUkxx9xg6
         zVrxbTHg/n0+F4TvZwY9Izcv4zl+R2IJTrG6VmmaI/rMhs6dmTyx8XMU76ckCLE2Al2j
         1eQDqVa6GFeK7YiLxWCToaffuQPJEKnHvO9k1JVPyf5Gek8wyW9/ivBq4piC43ewTfN6
         KNZIyW/xC5ikk7+IDXxb6bTFSDZb4W2zpjnmo0Qj/K3fazkWrY27+39lUmQuaInhxulf
         tcZw==
X-Gm-Message-State: AHYfb5hAFy+GvbXFoqYz2yY5mq0Gn5EeRfpo9id868SnS6EYOjpbbxty
        mgMmWPw/6U2Iaq5OTbL0GSBUfre+BxxO
X-Received: by 10.36.26.200 with SMTP id 191mr177238iti.7.1502838261827; Tue,
 15 Aug 2017 16:04:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.149.134 with HTTP; Tue, 15 Aug 2017 16:04:21 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Wed, 16 Aug 2017 04:34:21 +0530
Message-ID: <CAME+mvUCrMwqXTzCZM42ns6fffOJ+CkskRj=fBDUbjCrUn4dJA@mail.gmail.com>
Subject: [GSoC] Update: Week-13
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Stefan Beller <sbeller@google.com>
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

* add: most of the time of the week was spent in debugging the
  ported submodule subcommand functions. But, even after so,
  currently the ported functions fail in total 15 tests from
  the test suit. The WIP patches have been updated regularly,
  and currently the patch is under discussion with the mentors
  as well. The current status of the patch is pushed on github as
  well, and can be viewed at:[2]

Since the rest of the patches were almost the same as that in the
previous update(except for the 'summary' patch, which was last
updated after Christian's review), the haven't been uploaded
again to avoid unnecessary floating patches.
The previous updated series is available at: [3]
But given that, next week I plan to float a separate patch
series, containing the initial patches from the subcommand porting
series (till deinit), which IMO, are ready for maintainer's
review.

Also, this week's update was one-day late, since I was traveling
on the previous day. But a prior idea about this was given to the
mentors.

PLAN FOR WEEK-14 (15 August 2017 to 21 August 2017):

* patches: Float a separate series, till deinit, and ask the maintainer
  for its review.

* add: The main aim of the next week is to resolve the issues with
  the current patch, and get all the tests pass.

* update: it is the last remaining subcommand to be ported. I aim to
  atleast start with this in the following week.

The work till week-13 is pushed on Github and is available at: [4].

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/
[2]: https://github.com/pratham-pc/git/commits/sub-add
[3]: https://public-inbox.org/git/20170807211900.15001-1-pc44800@gmail.com/
[4]: https://github.com/pratham-pc/git/commits/week-13
