Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B204F1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfFSPMC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:12:02 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45159 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSPMC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:12:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so27683917edv.12
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=38GHJp5q0MMgNukojSaoVt++AQbSBdOO8nxd7+jl4i8=;
        b=Gl1HMHU9T3wzp1iABjJLhf4A5AplD4wgEvS5U8k+EojIalxU5QQOzy6owSQn4Vqf1g
         lzYiL0okCmMIrPcaQcnBGZI40brFCFRJM24K+SdMaVhkH0++QOLNyw9fMYfwTnWLGJHh
         Oat/acdXjrYgMhBngS+OD6r9X1GKs9BuvDy93ObIx4bN55PTZE/HI1YHfEHSWJssmnxE
         w+PZt5cnZDO+Amk0pzTl7uNPjhg7qTLC2DuWhOsY+y/EhJtlwq+mGiBjj5ZNB45OSx7j
         x78PIyc0dRGDJNJ5/w7MlmPTHJhpHAbd5qEz9r0sH0eNBFwPUkwWfbvh22A65sSIsMFn
         o0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=38GHJp5q0MMgNukojSaoVt++AQbSBdOO8nxd7+jl4i8=;
        b=Edjs8hb/WUbqDgEPZfMwTUd2FdtpM3LT6VtuSZZH/oZ3BAwnOrOVL7ce0DBxqA3lGq
         8WqKRwNoibwZvU+Atc0fG+rB2lnm7fJKbu5anKqMO1G/ygJ7IwZIaI8jV9R3wpQB3lzC
         nhvyvbVeCndLZ7rM48rOOItqWbr6lkI5USu2Z52ieDca78IP/81SN8Fpw2ofOqmgUyH4
         teBKM3nCijfaGhf+2QfBYCPGiYlvyY2ZOayacSB4LK7vn98vmby7MV1zW4GGOlGH9xFI
         euLqYbin18Ajh2ssjB69YJpQ3uCxasv1MJK1uI1xURuX+2M7xXzXlz/2LpLTUSieWizk
         qjbg==
X-Gm-Message-State: APjAAAWmJ6bjg/Rk4dAXOlckSRBI/DzMkuL4kaDCcZNlaBo26p8Wxxxh
        rOb//jyvIaMey1CtIZf2uM9teHrl
X-Google-Smtp-Source: APXvYqwzWvVs4QnanGfMatgFHr5QMMtOZlvGXUgCrYlwPajcir9vhoiyrRiUynRAN2XQSbReGOzRMw==
X-Received: by 2002:a05:6402:14cf:: with SMTP id f15mr73567405edx.255.1560957120000;
        Wed, 19 Jun 2019 08:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22sm2695920ejm.38.2019.06.19.08.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 08:11:59 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:11:59 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 15:11:55 GMT
Message-Id: <pull.254.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/3] [RFC] Create 'core.featureAdoptionRate' setting to update config defaults
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

 Documentation/config/core.txt  | 33 ++++++++++++++++++-
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
 12 files changed, 134 insertions(+), 19 deletions(-)
 create mode 100644 repo-settings.c
 create mode 100644 repo-settings.h


base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-254%2Fderrickstolee%2Fconfig-large%2Fupstream-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-254/derrickstolee/config-large/upstream-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/254

Range-diff vs v1:

  1:  704613f448 !  1:  bdaee3ea9d repo-settings: create repo.size=large setting
     @@ -1,6 +1,6 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    repo-settings: create repo.size=large setting
     +    repo-settings: create core.featureAdoptionRate setting
      
          Several advanced config settings are highly recommended for clients
          using large repositories. Power users learn these one-by-one and
     @@ -8,16 +8,31 @@
          more users to have access to these almost-always beneficial features
          (and more beneficial in larger repos).
      
     -    Create a 'repo.size' config setting whose only accepted value is
     -    'large'. When a repo.size=large is given, change the default values
     -    of some config settings. If the setting is given explicitly, then
     -    take the explicit value.
     +    Create a 'core.featureAdoptionRate' config setting that allows integer
     +    values. This is a rating from 0 to 10 for the user's willingness to
     +    adopt new or experimental features that improve Git performance.
     +    The default is 0, meaning "don't change anything!" A value of 10
     +    would mean "I'm willing for some behavior to change to get the
     +    best performance I can get, and can take experimental features
     +    in their first release." As we integrate this with more config
     +    settings, we will make this scale more clear.
      
     -    This change adds these two defaults to the repo.size=large setting:
     +    This config setting only changes the default values of other config
     +    settings. If the setting is given explicitly, then take the
     +    explicit value.
     +
     +    This change adds these two defaults when core.featureAdoptionRate
     +    is at least three:
      
           * core.commitGraph=true
           * gc.writeCommitGraph=true
      
     +    The use of "three or higher" for these settings means that a value
     +    of 3 means "I'm willing to add optional features that can augment
     +    the data on disk in favor of improved performance, but those
     +    features should be stable after being included in multiple major
     +    releases."
     +
          To centralize these config options and properly set the defaults,
          create a repo_settings that contains chars for each config variable.
          Use -1 as "unset", with 0 for false and 1 for true.
     @@ -36,24 +51,29 @@
       core.commitGraph::
       	If true, then git will read the commit-graph file (if it exists)
      -	to parse the graph structure of commits. Defaults to false. See
     --	linkgit:git-commit-graph[1] for more information.
      +	to parse the graph structure of commits. Defaults to false, unless
     -+	`core.size=large`. See linkgit:git-commit-graph[1] for more
     -+	information.
     ++	`core.featureAdoptionRate` is at least three. See
     + 	linkgit:git-commit-graph[1] for more information.
       
       core.useReplaceRefs::
     - 	If set to `false`, behave as if the `--no-replace-objects`
      @@
       	in your repository, which hopefully is enough for
       	abbreviated object names to stay unique for some time.
       	The minimum length is 4.
      +
     -+core.size::
     -+	When specified as "large", change the default values of some config
     -+	variables to improve performance in a large repository. If a variable
     ++core.featureAdoptionRate::
     ++	Set an integer value on a scale from 0 to 10 describing your
     ++	desire to adopt new performance features. Defaults to 0. As
     ++	the value increases, features are enabled by changing the
     ++	default values of other config settings. If a config variable
      +	is specified explicitly, the explicit value will override these
      +	defaults:
      ++
     ++If the value is at least 3, then the following defaults are modified.
     ++These represent relatively new features that have existed for multiple
     ++major releases, and present significant performance benefits. They do
     ++not modify the user-facing output of porcelain commands.
     +++
      +* `core.commitGraph=true` enables reading commit-graph files.
      ++
      +* `gc.writeCommitGraph=true` eneables writing commit-graph files during
     @@ -68,8 +88,8 @@
       	the commit-graph will be updated if housekeeping is
      -	required. Default is false. See linkgit:git-commit-graph[1]
      -	for details.
     -+	required. Default is false, unless `core.size=large`.
     -+	See linkgit:git-commit-graph[1] for details.
     ++	required. Default is false, unless `core.featureAdoptionRage`
     ++	is at least three. See linkgit:git-commit-graph[1] for details.
       
       gc.logExpiry::
       	If the file gc.log exists, then `git gc --auto` will print
     @@ -167,15 +187,15 @@
      +#include "config.h"
      +#include "repo-settings.h"
      +
     -+
     -+#define UPDATE_DEFAULT(s,v) if (s != -1) { s = v; }
     ++#define UPDATE_DEFAULT(s,v) do { if (s == -1) { s = v; } } while(0)
      +
      +static int git_repo_config(const char *key, const char *value, void *cb)
      +{
      +	struct repo_settings *rs = (struct repo_settings *)cb;
      +
     -+	if (!strcmp(key, "core.size")) {
     -+		if (!strcmp(value, "large")) {
     ++	if (!strcmp(key, "core.featureadoptionrate")) {
     ++		int rate = git_config_int(key, value);
     ++		if (rate >= 3) {
      +			UPDATE_DEFAULT(rs->core_commit_graph, 1);
      +			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
      +		}
  2:  d5f5d7453c !  2:  02c89415fe repo-settings: use index.version=4 by default
     @@ -4,7 +4,7 @@
      
          If a repo is large, it likely has many paths in its working directory.
          This means the index could be compressed using version 4. Set this as
     -    a default when core.size=large.
     +    a default when core.featureAdoptionRate is at least three.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -26,7 +26,8 @@
       index.version::
       	Specify the version with which new index files should be
       	initialized.  This does not affect existing repositories.
     -+	If `core.size=large`, then the default value is 4.
     ++	If `core.featureAdoptionRate` is at least three, then the
     ++	default value is 4.
      
       diff --git a/read-cache.c b/read-cache.c
       --- a/read-cache.c
     @@ -75,7 +76,7 @@
       --- a/repo-settings.c
       +++ b/repo-settings.c
      @@
     - 		if (!strcmp(value, "large")) {
     + 		if (rate >= 3) {
       			UPDATE_DEFAULT(rs->core_commit_graph, 1);
       			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
      +			UPDATE_DEFAULT(rs->index_version, 4);
  3:  f3ea4e3f27 !  3:  5bba9062f4 repo-settings: pack.useSparse=true
     @@ -7,7 +7,10 @@
          many fewer paths than the full path set. The sparse treewalk
          algorithm is optimized for this case, speeding up 'git push' calls.
      
     -    Use pack.useSparse=true when core.size=large.
     +    Use pack.useSparse=true when core.featureAdoptionRate is at least
     +    five. This is the first setting where the feature has only been
     +    out for a single major version. This could be moved to the "at
     +    least three" category after another major version.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -19,6 +22,11 @@
       * `index.version=4` uses prefix-compression to reduce the size of the
       .git/index file.
      ++
     ++If the value is at least 5, then all of the defaults above are included,
     ++plus the defaults below. These represent new features that present
     ++significant performance benefits, but may not have been released for
     ++multiple major versions.
     +++
      +* `pack.useSparse=true` uses the sparse tree-walk algorithm, which is
      +optimized for enumerating objects during linkgit:git-push[1] from a
      +client machine.
     @@ -32,7 +40,7 @@
       	that extra objects are added to the pack-file if the included
      -	commits contain certain types of direct renames.
      +	commits contain certain types of direct renames. Defaults to
     -+	false, unless `core.size=large`.
     ++	false, unless `core.featureAdoptionRate` is at least five.
       
       pack.writeBitmaps (deprecated)::
       	This is a deprecated synonym for `repack.writeBitmaps`.
     @@ -75,13 +83,15 @@
       --- a/repo-settings.c
       +++ b/repo-settings.c
      @@
     - 		if (!strcmp(value, "large")) {
     - 			UPDATE_DEFAULT(rs->core_commit_graph, 1);
       			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
     -+			UPDATE_DEFAULT(rs->pack_use_sparse, 1);
       			UPDATE_DEFAULT(rs->index_version, 4);
       		}
     ++		if (rate >= 5) {
     ++			UPDATE_DEFAULT(rs->pack_use_sparse, 1);
     ++		}
       		return 0;
     + 	}
     + 	if (!strcmp(key, "core.commitgraph")) {
      @@
       		rs->gc_write_commit_graph = git_config_bool(key, value);
       		return 0;
  4:  671cf092fd <  -:  ---------- status: add status.aheadbehind setting
  5:  d2e5cf1857 <  -:  ---------- status: add warning when a/b calculation takes too long for long/normal format
  6:  82ae00e495 <  -:  ---------- status: ignore status.aheadbehind in porcelain formats
  7:  936fae31b7 <  -:  ---------- repo-settings: status.aheadBehind=false
  8:  2d6bf8513d <  -:  ---------- fetch: add --[no-]show-forced-updates argument
  9:  6a80cfa5a5 <  -:  ---------- fetch: warn about forced updates after branch list
 10:  637aebc8ac <  -:  ---------- pull: add --[no-]show-forced-updates passthrough to fetch
 11:  d4ff987ad9 <  -:  ---------- repo-settings: fetch.showForcedUpdates=false

-- 
gitgitgadget
