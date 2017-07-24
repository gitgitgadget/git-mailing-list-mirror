Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6885E203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754221AbdGXUfS (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:35:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36831 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbdGXUfP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:35:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id 1so3210648pfi.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oqKV/zziGJt6A+O2/LYLlffKq/IBkuLOZ8HtRn35v8g=;
        b=mTawlkD92nA3Y2ES3YOSQ+kP8jPu09t+jr0b45AH4zdCjxBoJcXuB9P4ECDN400Sqj
         lL+v8cj7V41alXEbe12acwU2FEI1JsgOr0bHd3qaQCgJuMKACPKaEvxY409bFYyxQvgx
         1NomDAz//Jn9FhS/nfaFfgof0gUxVWUw0Aa43XpKgKvXTyebHSVFxQdFXRSJFya4uD6+
         T1wiw/PcGxRDXtXvi2Q1sM2SMkTUieg+cy+PDhO5Nu437aO+o4w59PLCC0WzP+MY51nY
         bhzKatSpOSZnHfRCyw3hxSual4+OExkF3sBCB8adjMdlWDUUy54urEPkrYqgAP9seckQ
         uwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oqKV/zziGJt6A+O2/LYLlffKq/IBkuLOZ8HtRn35v8g=;
        b=CwJABqQaVAc+c9lS1CGuaic8GKJcUWTGuKIZVS6AchnzgwVEMmZdJU3ChDw9OTTsQk
         YadBfYjjdrFkynwQMmwxlma9w4Nat3qb5SWBlw3md/4iUlKn0bjdhNgnw5H/aG0ahID8
         pSQ6KGagz3J9h78zpcuH8pRmXlKl5R3flC4Drt51mlON9WNDNecV1mWH1tOOwLe6Gu3d
         v3X6m8SRn3GlqPcV6m8Iy6drjbhduKL/pkYt4u4EXrpOVI0bpJvilDQmCloiOUHJGH3S
         ZpJijPF3UCimROhEZ4Kro1q7ju3UqE3nCckN74rYPVDHjGOxfDzl3PeXwRH99pENvQB3
         3Y/w==
X-Gm-Message-State: AIVw113VQ32Y5Rspnb9uKGrmwr0Abrh+Kxce9vP06DilRvWBwQdbiiYp
        akZKVwlvl4g9qmwlrCU=
X-Received: by 10.84.214.143 with SMTP id j15mr18761686pli.40.1500928514544;
        Mon, 24 Jul 2017 13:35:14 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:35:13 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 00/13] Update: Week 10
Date:   Tue, 25 Jul 2017 02:04:41 +0530
Message-Id: <20170724203454.13947-1-pc44800@gmail.com>
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

* status: some of the optimization changes which were suggested
  earlier were reverted, as I wasn't sure it fulfilled the
  purpose.

* sync & summary: some changes to the code were suggested after the
  previous review. Those changes were implemented successfully.

* add: the porting of this subcommand is underway. In the function
  cmd_add(), the value of sm_path undergoes quite a few changes
  which are taken care by the sed command. I'm currently working
  on porting them.

* foreach: as said in the previous update, the former patch [2] was
  spilt up into 4 patches, to get a clear picture of different changes
  made to submodule foreach. All of these patches are attached with
  this update. Also, the subcommand foreach is ported in accordance
  with this new changes as well.

PLAN FOR WEEK-11 (25 July 2017 to 31 July 2017):

* As all the patches prepared so far are posted on the mailing list, I'll
  focus on getting these patches merged and do the needful improvisions.

* Apart from this, as stated before, the porting of submodule subcommand
  is underway and will try my best to finish its porting and discuss it
  with the mentors as well in this following week. 

Also, a complete build report of this work is available at [3].
Branch: week-10
Build #140

And the work has also been pushed on github. It is available at [4].

[1]: https://docs.google.com/document/d/1krxVLooWl--75Pot3dazhfygR3wCUUWZWzTXtK1L-xU/
[2]: https://public-inbox.org/git/20170603003710.5558-1-sbeller@google.com/
[3]: https://travis-ci.org/pratham-pc/git/builds/
[4]: https://github.com/pratham-pc/git/commits/week-10

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
 builtin/submodule--helper.c     | 1165 ++++++++++++++++++++++++++++++++++++++-
 diff.c                          |    2 +-
 diff.h                          |    1 +
 git-submodule.sh                |  394 +------------
 t/t7407-submodule-foreach.sh    |   38 +-
 6 files changed, 1197 insertions(+), 418 deletions(-)

-- 
2.13.0

