Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC762047F
	for <e@80x24.org>; Sat, 29 Jul 2017 22:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbdG2WYZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 18:24:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33441 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbdG2WYY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 18:24:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id k72so19916363pfj.0
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uor+06tVtV1c8DZd4M3T39dkh9yhIp4XvWH6ajRZj2E=;
        b=vWbucUqTwp8aKkOVK4p3/elRWDd3jqmkuPbJr0Var8QfUZvh9/FFBtk+g/Ut8OmB71
         D5GxpX1Yy0KjpflDIb0nL0JoXNyYqPlv7m4Y5RIExZbnCt/OEnUOo83l3KGGVEqsJ68Y
         U59NgsKqdHhAgBRn3IyeiCeqdp4x/m8oj41RysVRQI0MMZi5Mr3sEub9t5ciMaUkVxil
         MjElbMZeWmjBxEJLoXgEo+1KS8ZRr43yRFXbJBFPt8g75gPU7rbRUE0Jo7+jSqqELEqK
         ISiwbIAWPGgBA4/eYY+YkxmHVkH5XOYwi2dBiruo3AUfY+ByqR50oRhMtGy9muIxVFnX
         aG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uor+06tVtV1c8DZd4M3T39dkh9yhIp4XvWH6ajRZj2E=;
        b=gIpF1bBFIF2+9OZNvcYbrd5aO9+qp8m+tEzRcw2VKtAXQgtuREi2VRcdggX5GBkK7L
         FJzNqRC5Hewp0hd63A+hcjWmwfPa/poYImBNB224PZS/a33TF7Mb80pecSdqEUX6Ffl9
         uUiga+kl2otsS2iMqu3apZL1PKNDtUyelRuJZJPOFugTZoZDnLMtdHH8+3N2/8sWZ7vB
         W/vdL9lzLelCDp0DW/OhQ4deqrX/R0ddWhxnPo0nRFXVWeiHKtLhS+cSeIVMdgOrAGjM
         aaISMhKLLraGi8ydFGY7HEUqFZguTuaquvigIRL2s8bSdsS253Ui9YTwAK8xC9dpgdfx
         LqiQ==
X-Gm-Message-State: AIVw111X0u5ZP7+5vxqguPzbvy2SghPnIS1UJe4HW+xHiqHzjP+KJWXI
        qOE6eORKsW997W1l5Nc=
X-Received: by 10.84.210.203 with SMTP id a69mr12118934pli.395.1501367063999;
        Sat, 29 Jul 2017 15:24:23 -0700 (PDT)
Received: from localhost.localdomain ([47.11.7.4])
        by smtp.gmail.com with ESMTPSA id w125sm43476409pfb.117.2017.07.29.15.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 15:24:23 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, bmwill@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 00/13] Update: Week 10
Date:   Sun, 30 Jul 2017 03:53:48 +0530
Message-Id: <20170729222401.12381-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Brandon Williams <bmwill@google.com> for reviewing the previous
patch series.
Also, I'm sorry for repling late to your reviews. The main reason was
to give sufficient time to prepare the next version of each patch as
suggested.
The changes made in each patch are enlisted in the patch itself.

Complete build report of this work is available at: [1]
Branch: week-10
Build #142

Also, I have push the work on github as well and can be checked out at: [2]

[1]: https://travis-ci.org/pratham-pc/git/builds
[2]: https://github.com/pratham-pc/git/commits/week-10

Prathamesh Chavan (13):
  submodule--helper: introduce get_submodule_displaypath()
  submodule--helper: introduce for_each_submodule_list()
  submodule: port set_name_rev() from shell to C
  submodule: port submodule subcommand 'status' from shell to C
  submodule: port submodule subcommand 'sync' from shell to C
  submodule: port submodule subcommand 'deinit' from shell to C
  diff: change scope of the function count_lines()
  submodule: port submodule subcommand 'summary' from shell to C
  submodule foreach: correct '$path' in nested submodules from a
    subdirectory
  submodule foreach: document '$sm_path' instead of '$path'
  submodule foreach: clarify the '$toplevel' variable documentation
  submodule foreach: document variable '$displaypath'
  submodule: port submodule subcommand 'foreach' from shell to C

 Documentation/git-submodule.txt |   15 +-
 builtin/submodule--helper.c     | 1186 ++++++++++++++++++++++++++++++++++++++-
 diff.c                          |    2 +-
 diff.h                          |    1 +
 git-submodule.sh                |  394 +------------
 t/t7407-submodule-foreach.sh    |   38 +-
 6 files changed, 1218 insertions(+), 418 deletions(-)

-- 
2.13.0

