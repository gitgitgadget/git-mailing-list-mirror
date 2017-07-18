Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6603920387
	for <e@80x24.org>; Tue, 18 Jul 2017 20:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbdGRUtZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 16:49:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35231 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbdGRUtX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 16:49:23 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so4185849pgc.2
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iguHezqXQScZG7ifmVI4gj7DmF/oWRp92JqAIg1tW4M=;
        b=d4oJeI/LtHDmmEfFEvEzqQR2nopUzp9GX8FQgUkLpM8B0jLa6Olyw49iO4dtPu09MB
         JMQMxu5sxl/6Q7pAmDgmIXiu/4L5no8V/x+cryAIcmg0UDReSg0GiA+CVBMWWlftlF5i
         8aDHqWhHOKMKOqBMke+ht5ktaqpXkZOcSRGrpt1ecY3TV3z7Vp9euy65LuvCdTHK6KX3
         GaspEsHxB8W2KK3CUkRAahVi/wLXJBBY4ieektXQHUow7Nu48J2r72cTnM2ZWfIP4iRL
         vIGWDeklSLPTi2jsz24/Pbi3G+OgGGVcs+NXeowJXU2hmhUP2pUH8ZuNbvTNQmtTaui+
         Qm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iguHezqXQScZG7ifmVI4gj7DmF/oWRp92JqAIg1tW4M=;
        b=Gx1/y0nOTMPiMWaKeIw+sljVmScVNIoVK79Q77xshKskSq1U/nm4tKUIqdBe2lVRpf
         CKV91SR4L0iO69LtXWz95YKD9+lL4ui6itHIGxf0jhQG91RUl8mSZ3R4r4SGUNHiIkG5
         0slmen++DkO/Py4fn3t3/7zX1KodOTBLLcfzTG2G6E3wBfPY+3rB5LedXMdLcf+Wdxwg
         kCafTKg9EW8Lt3zp3A8TrwNEgkFrk3ooLDpmPE5GquE5Pj2D7GtaFmX8dvXxNlRc+/gG
         OH9UXaASKky75RGn1dIsBlJUNpqWnabCNxqx/lJx5UhXF+CtrzNoQhcqGslDsBUCCHUn
         xgNQ==
X-Gm-Message-State: AIVw110dKgucK9syTX5nxTB+9RyA1aD4VnAGLIYYndc9+/bgco4bEZp1
        vmuOTLs+ocbBkegZgUM=
X-Received: by 10.99.105.201 with SMTP id e192mr3710100pgc.158.1500410962989;
        Tue, 18 Jul 2017 13:49:22 -0700 (PDT)
Received: from localhost.localdomain ([47.11.2.197])
        by smtp.gmail.com with ESMTPSA id e5sm402742pfd.41.2017.07.18.13.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 13:49:22 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 0/8] Update: Week 9
Date:   Wed, 19 Jul 2017 02:18:56 +0530
Message-Id: <20170718204904.3768-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
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

* status: Certain optimization were implemented as they were suggested.
  Also, the new version was posted for review[2]. This update also
  contains the above-stated version of this patch. 

* sync: The lasted version was posted on the mailing list[3].
  This update also contains the above-stated version of this patch.

* summary: This patch is updated after its last review.
  and the updated one is attached with this update.

* add: porting of this submodule subcommand has started.

* foreach: The former patch[4] posted on the mailing list has been split
  into smaller patches, along with certain additional changes which
  were suggested in the reviews. The patch is currently being posted
  discussion with the mentors and I aim to post it on the mailing
  list soon.

PLAN FOR WEEK-10 (18 July 2017 to 24 July 2017):

* foreach: After having a discussion with the mentors about the prepared
  patch, I'll post the patches.

* add: the porting of this subcommand has begun and will aim to finish
  it by the end of this week.

* Apart from that, I also aim to work on getting the rest of the patches
  ('status', 'sync', 'deinit', and other functions) merged.

Apart from this, sorry for posting the update late for this week. I arrived
at my college late yesterday and hence wasn't able to prepare this with
the ongoing classes. Also, I would do my best so that this doesn't occur
again.

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/
[2]: https://public-inbox.org/git/20170713200538.25806-4-pc44800@gmail.com/
[3]: https://public-inbox.org/git/20170713200538.25806-5-pc44800@gmail.com/
[4]: https://public-inbox.org/git/20170603003710.5558-1-sbeller@google.com/

Prathamesh Chavan (8):
  submodule--helper: introduce get_submodule_displaypath()
  submodule--helper: introduce for_each_submodule_list()
  submodule: port set_name_rev() from shell to C
  submodule: port submodule subcommand 'status' from shell to C
  submodule: port submodule subcommand 'sync' from shell to C
  submodule: port submodule subcommand 'deinit' from shell to C
  diff: change scope of the function count_lines()
  submodule: port submodule subcommand 'summary' from shell to C

 builtin/submodule--helper.c | 1070 ++++++++++++++++++++++++++++++++++++++++++-
 diff.c                      |    2 +-
 diff.h                      |    1 +
 git-submodule.sh            |  354 +-------------
 4 files changed, 1056 insertions(+), 371 deletions(-)

-- 
2.13.0

