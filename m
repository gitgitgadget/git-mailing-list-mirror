Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7221F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfGAO3M (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:29:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38239 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfGAO3L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:29:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so23874555edo.5
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6wp1fEyuEd9HMXqb0nd0c+skAcrIxD4p+Fq2TlKVt5c=;
        b=ZDXZ2xTRumQ3+6S8QehdNH+SS/XO6UdymI42SueODVFrn+hZcRtP5sNETRfqjHMp+w
         t3xSAPuWAawcOsqshyxofwPWIFO1nRBk7Re7jIOss9gSfCqC3BqSjGE9CXVf9BVQ85cc
         29odPNar2AW1bO/2CkhN3UiR8pD4AAKLcJyTRZ3idJlozzGOZXC3OPPTblEJykpWeXLV
         oFNW5eKQqCSFyLKp7W1waiTRHlj37m7UNUSQ0iBZHEEwLbSCowSgHAAMF4LSgWWH4kcK
         BLvh2B2DDDVVzKeNePXo2AGRDSeBt96IPH3waykHhLOoXDJAIpfQ6FRwOGdzwjUEH6iY
         aQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6wp1fEyuEd9HMXqb0nd0c+skAcrIxD4p+Fq2TlKVt5c=;
        b=tq90BRTbbWarJJbtcQS4dBWlCJJQdKJ1xC+wQpmRW6pCG8C2Jxk9RT+DgTFhrAYC0Q
         m3SCdrA8Q5c1ibqGO7vJdqFy5XRdUcaTk77NcXUdJQ73JJH4OWMknh/oFocP3bcJWC5r
         uRke1tPmdRcMvUCD8VJnnKhWejfED2YCApOrKP86jEX/GiccjqIxNmemF5kxEmR0Db46
         ZDRqxsqCqnbQfLzYZwMLHy1ue0g4xX5f/VopahdJdUO4qypaKJiqSjS2dfUkOEkAPYRV
         mEt/AmQZI7qU3SAFXO3y0DzOihptDdH1EwNvU7m3AcumzFQ84TYF6J3wBTIy9AAp3SJY
         a3jQ==
X-Gm-Message-State: APjAAAUF2RYHGE7rIKyWAzFuYqRI4sWdZEbIjT2QEpgO0e4Y8VAGJVXP
        s3HtSO4ERra4he2R57dw9FqxTWqe
X-Google-Smtp-Source: APXvYqxGBeF1bO959BERr03sSZfal05ropdb2cBUrkkusKGY9Z6KV5OlHEGCze+B5LXCGZoBfwAW2g==
X-Received: by 2002:a17:906:6b53:: with SMTP id o19mr23695759ejs.27.1561991349387;
        Mon, 01 Jul 2019 07:29:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s52sm3734585edm.55.2019.07.01.07.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 07:29:08 -0700 (PDT)
Date:   Mon, 01 Jul 2019 07:29:08 -0700 (PDT)
X-Google-Original-Date: Mon, 01 Jul 2019 14:29:04 GMT
Message-Id: <pull.254.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.v2.git.gitgitgadget@gmail.com>
References: <pull.254.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/3] [RFC] Create 'core.featureAdoptionRate' setting to update config defaults
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a second run at this RFC, which aims to create a "meta" config
setting that automatically turns on other settings according to a user's
willingness to trade new Git behavior or new feature risk for performance
benefits. The new name for the setting is "core.featureAdoptionRate" and is
an integer scale from 0 to 10. There will be multiple "categories" of
settings, and the intention is to allow more granular levels as necessary.

The first category is "3 or higher" which means that the user is willing to
adopt features that have been tested in multiple major releases. The
settings to include here are core.commitGraph=true,
gc.writeCommitGraph=true, and index.version=4.

The second category is "5 or higher" which means the user is willing to
adopt features that have not been out for multiple major releases. The
setting included here is pack.useSparse=true.

In the future, I would add a "7 or higher" setting which means the user is
willing to have a change of behavior in exchange for performance benefits.
The two settings to place here are 'status.aheadBehind=false' and
'fetch.showForcedUpdates=false'. Instead of including these settings in the
current series, I've submitted them independently for full review [1, 2].

Hopefully this direction is amenable to allow "early adopters" gain access
to new performance features even if they are not necessary reading every
line of the release notes.

Thanks, -Stolee

[1] https://public-inbox.org/git/pull.272.git.gitgitgadget@gmail.com/

[2] https://public-inbox.org/git/pull.273.git.gitgitgadget@gmail.com/

Derrick Stolee (3):
  repo-settings: create core.featureAdoptionRate setting
  repo-settings: use index.version=4 by default
  repo-settings: pack.useSparse=true

 Documentation/config/core.txt  | 34 +++++++++++++++++++-
 Documentation/config/gc.txt    |  4 +--
 Documentation/config/index.txt |  2 ++
 Documentation/config/pack.txt  |  3 +-
 Makefile                       |  1 +
 builtin/gc.c                   |  6 ++--
 builtin/pack-objects.c         |  9 +++---
 commit-graph.c                 |  7 ++--
 read-cache.c                   | 12 ++++---
 repo-settings.c                | 58 ++++++++++++++++++++++++++++++++++
 repo-settings.h                | 15 +++++++++
 repository.h                   |  3 ++
 t/t1600-index.sh               | 34 +++++++++++++++++---
 13 files changed, 164 insertions(+), 24 deletions(-)
 create mode 100644 repo-settings.c
 create mode 100644 repo-settings.h


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-254%2Fderrickstolee%2Fconfig-large%2Fupstream-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-254/derrickstolee/config-large/upstream-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/254

Range-diff vs v2:

 1:  bdaee3ea9d ! 1:  13b9e71b38 repo-settings: create core.featureAdoptionRate setting
     @@ -71,8 +71,9 @@
      ++
      +If the value is at least 3, then the following defaults are modified.
      +These represent relatively new features that have existed for multiple
     -+major releases, and present significant performance benefits. They do
     -+not modify the user-facing output of porcelain commands.
     ++major releases, and may present performance benefits. These benefits
     ++depend on the amount and kind of data in your repo and how you use it.
     ++The settings do not modify the user-facing output of porcelain commands.
      ++
      +* `core.commitGraph=true` enables reading commit-graph files.
      ++
     @@ -236,8 +237,8 @@
      +#define REPO_SETTINGS_H
      +
      +struct repo_settings {
     -+	char core_commit_graph;
     -+	char gc_write_commit_graph;
     ++	int core_commit_graph;
     ++	int gc_write_commit_graph;
      +};
      +
      +struct repository;
 2:  02c89415fe ! 2:  4fe896e423 repo-settings: use index.version=4 by default
     @@ -6,6 +6,12 @@
          This means the index could be compressed using version 4. Set this as
          a default when core.featureAdoptionRate is at least three.
      
     +    Since the index version is written to a file, this is an excellent
     +    opportunity to test that the config settings are working correctly
     +    with the different precedence rules. Adapt a test from t1600-index.sh
     +    to verify the version is set properly with different values of
     +    index.version config, core.featureAdoptionRate, and GIT_INDEX_VERSION.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
     @@ -108,9 +114,60 @@
       +++ b/repo-settings.h
      @@
       struct repo_settings {
     - 	char core_commit_graph;
     - 	char gc_write_commit_graph;
     + 	int core_commit_graph;
     + 	int gc_write_commit_graph;
      +	int index_version;
       };
       
       struct repository;
     +
     + diff --git a/t/t1600-index.sh b/t/t1600-index.sh
     + --- a/t/t1600-index.sh
     + +++ b/t/t1600-index.sh
     +@@
     + 	)
     + '
     + 
     +-test_expect_success 'GIT_INDEX_VERSION takes precedence over config' '
     ++test_index_version () {
     ++	INDEX_VERSION_CONFIG=$1 &&
     ++	REPO_ADOPTION_RATE=$2 &&
     ++	ENV_VAR_VERSION=$3
     ++	EXPECTED_OUTPUT_VERSION=$4 &&
     + 	(
     + 		rm -f .git/index &&
     +-		GIT_INDEX_VERSION=4 &&
     +-		export GIT_INDEX_VERSION &&
     +-		git config --add index.version 2 &&
     ++		rm -f .git/config &&
     ++		if test "$INDEX_VERSION_CONFIG" -ne 0
     ++		then
     ++			git config --add index.version $INDEX_VERSION_CONFIG
     ++		fi &&
     ++		if test "$REPO_ADOPTION_RATE" -ne 0
     ++		then
     ++			git config --add core.featureAdoptionRate $REPO_ADOPTION_RATE
     ++		fi &&
     ++		if test "$ENV_VAR_VERSION" -ne 0
     ++		then
     ++			GIT_INDEX_VERSION=$ENV_VAR_VERSION &&
     ++			export GIT_INDEX_VERSION
     ++		else
     ++			unset GIT_INDEX_VERSION
     ++		fi &&
     + 		git add a 2>&1 &&
     +-		echo 4 >expect &&
     ++		echo $EXPECTED_OUTPUT_VERSION >expect &&
     + 		test-tool index-version <.git/index >actual &&
     + 		test_cmp expect actual
     + 	)
     ++}
     ++
     ++test_expect_success 'index version config precedence' '
     ++	test_index_version 2 0 4 4 &&
     ++	test_index_version 2 3 0 2 &&
     ++	test_index_version 0 3 0 4 &&
     ++	test_index_version 0 3 2 2
     + '
     + 
     + test_done
 3:  5bba9062f4 ! 3:  d080065a92 repo-settings: pack.useSparse=true
     @@ -117,9 +117,9 @@
       +++ b/repo-settings.h
      @@
       struct repo_settings {
     - 	char core_commit_graph;
     - 	char gc_write_commit_graph;
     -+	char pack_use_sparse;
     + 	int core_commit_graph;
     + 	int gc_write_commit_graph;
     ++	int pack_use_sparse;
       	int index_version;
       };
       

-- 
gitgitgadget
