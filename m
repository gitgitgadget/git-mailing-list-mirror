Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4976C2018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756112AbdEKNs0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:61216 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932948AbdEKNsU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:48:20 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1msU-1e2Puc1bgI-00tnOZ; Thu, 11
 May 2017 15:48:16 +0200
Date:   Thu, 11 May 2017 15:48:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/11] PREVIEW: t5515: remove .git/remotes/ and .git/branches/
 tests
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <b9fcc61b2e01a7b97057f5aa5b307bdf5dae8587.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JWYxHLANGMYYasXuL7RjGMzhzTg74JBnuwFTX/8WEnGcS1hSP1c
 bR3cnthGBTDGMinI5z2ipicYCpW4w+L1eaQLcSztuSS/n6hzOhXTVjNznPywsn6adIevjYK
 fwGO9w4LO68f5MxjbzZqzRL5NZagKFbRWtD2w8OIxghSDf3MmOTS3kU3DOI1z4fLHc9tiYz
 +uFc+Q6nhWAHHPnKdER9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h8XlHVDdRZs=:riUSsCyMLF/vPAV8cJTlat
 w2gHjLZ61vFaVCF4BFYAWLgI8QSNlk78H6M6xf53/4Hu9cYL0luf51uUeYAmTG8Pi1dHdNyXl
 kKCn985IgoFm41MgTw67Bt1TjhroR1MEkPLOdJUNSNf+a01XWPxs5xCaabzSB8QxeE//8EQAg
 i2XKJGvTFii4rmMYQM6rnsrFERPN4jqcma8giqiuWBFz+UpQGxsQPZCHRWg2X67JRPKggBfZ+
 Cyu9/qWyVunWcrD0fp+NN4XeJY+rd/Ze7ty1iKl6xLi2TSo8H9pmaWHUd7dhiAyJaibG0+bS4
 Wry+1fQNSVlKnEHMTY26KB5X2TFa/s5MlqmXnbWUJdZcW5k2E6Ti2q42+QVCRgx1QScxLlu1b
 SHLVMS9AdJAOtkIvuWqvnfBbDdQVGvHUTzXIBBYxF+Nu21wkj+1+5dcVyGATwD30k5i36EF0s
 uhQTmyHOnd7soqIkJpgpYqHDeBS9m0vDxS2JRO8VlRG2us4ZR6aRUPZF+mHoh745cjKeTCYsp
 PWD00Ekvx4/kleQk5yGSkjSKnvAVglgbMNjYOYk49BZstC9OD7fu45tvhcfD1zYyb9uRDd/hw
 JKCjoNWHynL1kDf6IzqwCkcXPARFSwnqB5jDl6nGSEBPSmmR607/VY3qh5ANxXY3axL0qZ4gr
 337YMSJe0T4XXmgL3ibWaklbto03MA/PQf34eBSVeMsi7KvRyJMQFP2yIyoQSbniPaPM+Lmh6
 znT5P+8VmExp344Myg7/jmnE/lPK7c2K4CiBA1snFF0aSmLZnWh6x4my93jXPKZ8OEbob9g6W
 +YUHcT8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to remove support for the long-obsolete .git/remotes/ and
.git/branches/ directories. Let's stop testing them, in preparation for
that move.

The bulk of this patch simply removes support files that are no longer
needed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5515-fetch-merge-logic.sh                       | 23 ----------------------
 t/t5515/fetch.br-branches-default                  |  8 --------
 t/t5515/fetch.br-branches-default-merge            |  9 ---------
 ...etch.br-branches-default-merge_branches-default |  9 ---------
 t/t5515/fetch.br-branches-default-octopus          | 10 ----------
 ...ch.br-branches-default-octopus_branches-default | 10 ----------
 t/t5515/fetch.br-branches-default_branches-default |  8 --------
 t/t5515/fetch.br-branches-one                      |  8 --------
 t/t5515/fetch.br-branches-one-merge                |  9 ---------
 t/t5515/fetch.br-branches-one-merge_branches-one   |  9 ---------
 t/t5515/fetch.br-branches-one-octopus              |  9 ---------
 t/t5515/fetch.br-branches-one-octopus_branches-one |  9 ---------
 t/t5515/fetch.br-branches-one_branches-one         |  8 --------
 t/t5515/fetch.br-remote-explicit                   | 11 -----------
 t/t5515/fetch.br-remote-explicit-merge             | 11 -----------
 .../fetch.br-remote-explicit-merge_remote-explicit | 11 -----------
 t/t5515/fetch.br-remote-explicit-octopus           | 11 -----------
 ...etch.br-remote-explicit-octopus_remote-explicit | 11 -----------
 t/t5515/fetch.br-remote-explicit_remote-explicit   | 11 -----------
 t/t5515/fetch.br-remote-glob                       | 11 -----------
 t/t5515/fetch.br-remote-glob-merge                 | 11 -----------
 t/t5515/fetch.br-remote-glob-merge_remote-glob     | 11 -----------
 t/t5515/fetch.br-remote-glob-octopus               | 11 -----------
 t/t5515/fetch.br-remote-glob-octopus_remote-glob   | 11 -----------
 t/t5515/fetch.br-remote-glob_remote-glob           | 11 -----------
 t/t5515/fetch.br-unconfig_branches-default         |  8 --------
 t/t5515/fetch.br-unconfig_branches-one             |  8 --------
 t/t5515/fetch.br-unconfig_remote-explicit          | 11 -----------
 t/t5515/fetch.br-unconfig_remote-glob              | 11 -----------
 t/t5515/fetch.master_branches-default              |  8 --------
 t/t5515/fetch.master_branches-one                  |  8 --------
 t/t5515/fetch.master_remote-explicit               | 11 -----------
 t/t5515/fetch.master_remote-glob                   | 11 -----------
 t/t5515/refs.br-branches-default                   | 12 -----------
 t/t5515/refs.br-branches-default-merge             | 12 -----------
 ...refs.br-branches-default-merge_branches-default | 12 -----------
 t/t5515/refs.br-branches-default-octopus           | 12 -----------
 ...fs.br-branches-default-octopus_branches-default | 12 -----------
 t/t5515/refs.br-branches-default_branches-default  | 12 -----------
 t/t5515/refs.br-branches-one                       | 12 -----------
 t/t5515/refs.br-branches-one-merge                 | 12 -----------
 t/t5515/refs.br-branches-one-merge_branches-one    | 12 -----------
 t/t5515/refs.br-branches-one-octopus               | 12 -----------
 t/t5515/refs.br-branches-one-octopus_branches-one  | 12 -----------
 t/t5515/refs.br-branches-one_branches-one          | 12 -----------
 t/t5515/refs.br-remote-explicit                    | 15 --------------
 t/t5515/refs.br-remote-explicit-merge              | 15 --------------
 .../refs.br-remote-explicit-merge_remote-explicit  | 15 --------------
 t/t5515/refs.br-remote-explicit-octopus            | 15 --------------
 ...refs.br-remote-explicit-octopus_remote-explicit | 15 --------------
 t/t5515/refs.br-remote-explicit_remote-explicit    | 15 --------------
 t/t5515/refs.br-remote-glob                        | 15 --------------
 t/t5515/refs.br-remote-glob-merge                  | 15 --------------
 t/t5515/refs.br-remote-glob-merge_remote-glob      | 15 --------------
 t/t5515/refs.br-remote-glob-octopus                | 15 --------------
 t/t5515/refs.br-remote-glob-octopus_remote-glob    | 15 --------------
 t/t5515/refs.br-remote-glob_remote-glob            | 15 --------------
 t/t5515/refs.br-unconfig_branches-default          | 12 -----------
 t/t5515/refs.br-unconfig_branches-one              | 12 -----------
 t/t5515/refs.br-unconfig_remote-explicit           | 15 --------------
 t/t5515/refs.br-unconfig_remote-glob               | 15 --------------
 t/t5515/refs.master_branches-default               | 12 -----------
 t/t5515/refs.master_branches-one                   | 12 -----------
 t/t5515/refs.master_remote-explicit                | 15 --------------
 t/t5515/refs.master_remote-glob                    | 15 --------------
 65 files changed, 769 deletions(-)
 delete mode 100644 t/t5515/fetch.br-branches-default
 delete mode 100644 t/t5515/fetch.br-branches-default-merge
 delete mode 100644 t/t5515/fetch.br-branches-default-merge_branches-default
 delete mode 100644 t/t5515/fetch.br-branches-default-octopus
 delete mode 100644 t/t5515/fetch.br-branches-default-octopus_branches-default
 delete mode 100644 t/t5515/fetch.br-branches-default_branches-default
 delete mode 100644 t/t5515/fetch.br-branches-one
 delete mode 100644 t/t5515/fetch.br-branches-one-merge
 delete mode 100644 t/t5515/fetch.br-branches-one-merge_branches-one
 delete mode 100644 t/t5515/fetch.br-branches-one-octopus
 delete mode 100644 t/t5515/fetch.br-branches-one-octopus_branches-one
 delete mode 100644 t/t5515/fetch.br-branches-one_branches-one
 delete mode 100644 t/t5515/fetch.br-remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-explicit-merge
 delete mode 100644 t/t5515/fetch.br-remote-explicit-merge_remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-explicit-octopus
 delete mode 100644 t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-explicit_remote-explicit
 delete mode 100644 t/t5515/fetch.br-remote-glob
 delete mode 100644 t/t5515/fetch.br-remote-glob-merge
 delete mode 100644 t/t5515/fetch.br-remote-glob-merge_remote-glob
 delete mode 100644 t/t5515/fetch.br-remote-glob-octopus
 delete mode 100644 t/t5515/fetch.br-remote-glob-octopus_remote-glob
 delete mode 100644 t/t5515/fetch.br-remote-glob_remote-glob
 delete mode 100644 t/t5515/fetch.br-unconfig_branches-default
 delete mode 100644 t/t5515/fetch.br-unconfig_branches-one
 delete mode 100644 t/t5515/fetch.br-unconfig_remote-explicit
 delete mode 100644 t/t5515/fetch.br-unconfig_remote-glob
 delete mode 100644 t/t5515/fetch.master_branches-default
 delete mode 100644 t/t5515/fetch.master_branches-one
 delete mode 100644 t/t5515/fetch.master_remote-explicit
 delete mode 100644 t/t5515/fetch.master_remote-glob
 delete mode 100644 t/t5515/refs.br-branches-default
 delete mode 100644 t/t5515/refs.br-branches-default-merge
 delete mode 100644 t/t5515/refs.br-branches-default-merge_branches-default
 delete mode 100644 t/t5515/refs.br-branches-default-octopus
 delete mode 100644 t/t5515/refs.br-branches-default-octopus_branches-default
 delete mode 100644 t/t5515/refs.br-branches-default_branches-default
 delete mode 100644 t/t5515/refs.br-branches-one
 delete mode 100644 t/t5515/refs.br-branches-one-merge
 delete mode 100644 t/t5515/refs.br-branches-one-merge_branches-one
 delete mode 100644 t/t5515/refs.br-branches-one-octopus
 delete mode 100644 t/t5515/refs.br-branches-one-octopus_branches-one
 delete mode 100644 t/t5515/refs.br-branches-one_branches-one
 delete mode 100644 t/t5515/refs.br-remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-explicit-merge
 delete mode 100644 t/t5515/refs.br-remote-explicit-merge_remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-explicit-octopus
 delete mode 100644 t/t5515/refs.br-remote-explicit-octopus_remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-explicit_remote-explicit
 delete mode 100644 t/t5515/refs.br-remote-glob
 delete mode 100644 t/t5515/refs.br-remote-glob-merge
 delete mode 100644 t/t5515/refs.br-remote-glob-merge_remote-glob
 delete mode 100644 t/t5515/refs.br-remote-glob-octopus
 delete mode 100644 t/t5515/refs.br-remote-glob-octopus_remote-glob
 delete mode 100644 t/t5515/refs.br-remote-glob_remote-glob
 delete mode 100644 t/t5515/refs.br-unconfig_branches-default
 delete mode 100644 t/t5515/refs.br-unconfig_branches-one
 delete mode 100644 t/t5515/refs.br-unconfig_remote-explicit
 delete mode 100644 t/t5515/refs.br-unconfig_remote-glob
 delete mode 100644 t/t5515/refs.master_branches-default
 delete mode 100644 t/t5515/refs.master_branches-one
 delete mode 100644 t/t5515/refs.master_remote-explicit
 delete mode 100644 t/t5515/refs.master_remote-glob

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 36b0dbc01cf..19639ffe598 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -55,29 +55,6 @@ test_expect_success setup '
 	git config remote.config-glob.fetch refs/heads/*:refs/remotes/rem/* &&
 	remotes="$remotes config-glob" &&
 
-	mkdir -p .git/remotes &&
-	{
-		echo "URL: ../.git/"
-		echo "Pull: refs/heads/master:remotes/rem/master"
-		echo "Pull: refs/heads/one:remotes/rem/one"
-		echo "Pull: two:remotes/rem/two"
-		echo "Pull: refs/heads/three:remotes/rem/three"
-	} >.git/remotes/remote-explicit &&
-	remotes="$remotes remote-explicit" &&
-
-	{
-		echo "URL: ../.git/"
-		echo "Pull: refs/heads/*:refs/remotes/rem/*"
-	} >.git/remotes/remote-glob &&
-	remotes="$remotes remote-glob" &&
-
-	mkdir -p .git/branches &&
-	echo "../.git" > .git/branches/branches-default &&
-	remotes="$remotes branches-default" &&
-
-	echo "../.git#one" > .git/branches/branches-one &&
-	remotes="$remotes branches-one" &&
-
 	for remote in $remotes ; do
 		git config branch.br-$remote.remote $remote &&
 		git config branch.br-$remote-merge.remote $remote &&
diff --git a/t/t5515/fetch.br-branches-default b/t/t5515/fetch.br-branches-default
deleted file mode 100644
index a1bc3d53a60..00000000000
--- a/t/t5515/fetch.br-branches-default
+++ /dev/null
@@ -1,8 +0,0 @@
-# br-branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br-branches-default-merge
deleted file mode 100644
index 12ab08e8acb..00000000000
--- a/t/t5515/fetch.br-branches-default-merge
+++ /dev/null
@@ -1,9 +0,0 @@
-# br-branches-default-merge
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge_branches-default b/t/t5515/fetch.br-branches-default-merge_branches-default
deleted file mode 100644
index 54427522dd5..00000000000
--- a/t/t5515/fetch.br-branches-default-merge_branches-default
+++ /dev/null
@@ -1,9 +0,0 @@
-# br-branches-default-merge branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.br-branches-default-octopus
deleted file mode 100644
index 498a761aae8..00000000000
--- a/t/t5515/fetch.br-branches-default-octopus
+++ /dev/null
@@ -1,10 +0,0 @@
-# br-branches-default-octopus
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus_branches-default b/t/t5515/fetch.br-branches-default-octopus_branches-default
deleted file mode 100644
index 0857f134e10..00000000000
--- a/t/t5515/fetch.br-branches-default-octopus_branches-default
+++ /dev/null
@@ -1,10 +0,0 @@
-# br-branches-default-octopus branches-default
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-default_branches-default b/t/t5515/fetch.br-branches-default_branches-default
deleted file mode 100644
index 8cbd7189362..00000000000
--- a/t/t5515/fetch.br-branches-default_branches-default
+++ /dev/null
@@ -1,8 +0,0 @@
-# br-branches-default branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one b/t/t5515/fetch.br-branches-one
deleted file mode 100644
index c98f6705263..00000000000
--- a/t/t5515/fetch.br-branches-one
+++ /dev/null
@@ -1,8 +0,0 @@
-# br-branches-one
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-branches-one-merge
deleted file mode 100644
index 54a77420d5d..00000000000
--- a/t/t5515/fetch.br-branches-one-merge
+++ /dev/null
@@ -1,9 +0,0 @@
-# br-branches-one-merge
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge_branches-one b/t/t5515/fetch.br-branches-one-merge_branches-one
deleted file mode 100644
index b4d1bb0b0ba..00000000000
--- a/t/t5515/fetch.br-branches-one-merge_branches-one
+++ /dev/null
@@ -1,9 +0,0 @@
-# br-branches-one-merge branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus b/t/t5515/fetch.br-branches-one-octopus
deleted file mode 100644
index 97c4b544b8c..00000000000
--- a/t/t5515/fetch.br-branches-one-octopus
+++ /dev/null
@@ -1,9 +0,0 @@
-# br-branches-one-octopus
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one-octopus_branches-one b/t/t5515/fetch.br-branches-one-octopus_branches-one
deleted file mode 100644
index df705f74c7d..00000000000
--- a/t/t5515/fetch.br-branches-one-octopus_branches-one
+++ /dev/null
@@ -1,9 +0,0 @@
-# br-branches-one-octopus branches-one
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-branches-one_branches-one b/t/t5515/fetch.br-branches-one_branches-one
deleted file mode 100644
index 96890e5bd99..00000000000
--- a/t/t5515/fetch.br-branches-one_branches-one
+++ /dev/null
@@ -1,8 +0,0 @@
-# br-branches-one branches-one
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit b/t/t5515/fetch.br-remote-explicit
deleted file mode 100644
index ab44bc55196..00000000000
--- a/t/t5515/fetch.br-remote-explicit
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge b/t/t5515/fetch.br-remote-explicit-merge
deleted file mode 100644
index d018b3515f7..00000000000
--- a/t/t5515/fetch.br-remote-explicit-merge
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-explicit-merge
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit b/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
deleted file mode 100644
index 0d3d780dd0c..00000000000
--- a/t/t5515/fetch.br-remote-explicit-merge_remote-explicit
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-explicit-merge remote-explicit
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus b/t/t5515/fetch.br-remote-explicit-octopus
deleted file mode 100644
index 6f843044ede..00000000000
--- a/t/t5515/fetch.br-remote-explicit-octopus
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-explicit-octopus
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit b/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
deleted file mode 100644
index 3546a837136..00000000000
--- a/t/t5515/fetch.br-remote-explicit-octopus_remote-explicit
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-explicit-octopus remote-explicit
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-explicit_remote-explicit b/t/t5515/fetch.br-remote-explicit_remote-explicit
deleted file mode 100644
index 01e014e6a02..00000000000
--- a/t/t5515/fetch.br-remote-explicit_remote-explicit
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-explicit remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob b/t/t5515/fetch.br-remote-glob
deleted file mode 100644
index 09bfcee00f9..00000000000
--- a/t/t5515/fetch.br-remote-glob
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge b/t/t5515/fetch.br-remote-glob-merge
deleted file mode 100644
index 7e1a433a64f..00000000000
--- a/t/t5515/fetch.br-remote-glob-merge
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-glob-merge
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-merge_remote-glob b/t/t5515/fetch.br-remote-glob-merge_remote-glob
deleted file mode 100644
index 53571bb4ec6..00000000000
--- a/t/t5515/fetch.br-remote-glob-merge_remote-glob
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-glob-merge remote-glob
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b		branch 'three' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus b/t/t5515/fetch.br-remote-glob-octopus
deleted file mode 100644
index c7c8b6d7f47..00000000000
--- a/t/t5515/fetch.br-remote-glob-octopus
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-glob-octopus
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus_remote-glob b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
deleted file mode 100644
index 36076fba0cc..00000000000
--- a/t/t5515/fetch.br-remote-glob-octopus_remote-glob
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-glob-octopus remote-glob
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-remote-glob_remote-glob b/t/t5515/fetch.br-remote-glob_remote-glob
deleted file mode 100644
index 20ba5cb1725..00000000000
--- a/t/t5515/fetch.br-remote-glob_remote-glob
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-remote-glob remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_branches-default b/t/t5515/fetch.br-unconfig_branches-default
deleted file mode 100644
index da30e3c62c2..00000000000
--- a/t/t5515/fetch.br-unconfig_branches-default
+++ /dev/null
@@ -1,8 +0,0 @@
-# br-unconfig branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_branches-one b/t/t5515/fetch.br-unconfig_branches-one
deleted file mode 100644
index e4614314c54..00000000000
--- a/t/t5515/fetch.br-unconfig_branches-one
+++ /dev/null
@@ -1,8 +0,0 @@
-# br-unconfig branches-one
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_remote-explicit b/t/t5515/fetch.br-unconfig_remote-explicit
deleted file mode 100644
index 6318dd11b4c..00000000000
--- a/t/t5515/fetch.br-unconfig_remote-explicit
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-unconfig remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.br-unconfig_remote-glob b/t/t5515/fetch.br-unconfig_remote-glob
deleted file mode 100644
index 1d9afad7d84..00000000000
--- a/t/t5515/fetch.br-unconfig_remote-glob
+++ /dev/null
@@ -1,11 +0,0 @@
-# br-unconfig remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_branches-default b/t/t5515/fetch.master_branches-default
deleted file mode 100644
index 2eedd3bfa4a..00000000000
--- a/t/t5515/fetch.master_branches-default
+++ /dev/null
@@ -1,8 +0,0 @@
-# master branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_branches-one b/t/t5515/fetch.master_branches-one
deleted file mode 100644
index 901ce21d333..00000000000
--- a/t/t5515/fetch.master_branches-one
+++ /dev/null
@@ -1,8 +0,0 @@
-# master branches-one
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_remote-explicit b/t/t5515/fetch.master_remote-explicit
deleted file mode 100644
index b3cfe6b98b2..00000000000
--- a/t/t5515/fetch.master_remote-explicit
+++ /dev/null
@@ -1,11 +0,0 @@
-# master remote-explicit
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/fetch.master_remote-glob b/t/t5515/fetch.master_remote-glob
deleted file mode 100644
index 118befd1e48..00000000000
--- a/t/t5515/fetch.master_remote-glob
+++ /dev/null
@@ -1,11 +0,0 @@
-# master remote-glob
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5	not-for-merge	tag 'tag-master' of ../
-8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
-22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-c61a82b60967180544e3c19f819ddbd0c9f89899	not-for-merge	tag 'tag-three' of ../
-0e3b14047d3ee365f4f2a1b673db059c3972589c	not-for-merge	tag 'tag-three-file' of ../
-525b7fb068d59950d185a8779dc957c77eed73ba	not-for-merge	tag 'tag-two' of ../
diff --git a/t/t5515/refs.br-branches-default b/t/t5515/refs.br-branches-default
deleted file mode 100644
index 21917c1e5db..00000000000
--- a/t/t5515/refs.br-branches-default
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-merge b/t/t5515/refs.br-branches-default-merge
deleted file mode 100644
index 21917c1e5db..00000000000
--- a/t/t5515/refs.br-branches-default-merge
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-merge_branches-default b/t/t5515/refs.br-branches-default-merge_branches-default
deleted file mode 100644
index 21917c1e5db..00000000000
--- a/t/t5515/refs.br-branches-default-merge_branches-default
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-octopus b/t/t5515/refs.br-branches-default-octopus
deleted file mode 100644
index 21917c1e5db..00000000000
--- a/t/t5515/refs.br-branches-default-octopus
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default-octopus_branches-default b/t/t5515/refs.br-branches-default-octopus_branches-default
deleted file mode 100644
index 21917c1e5db..00000000000
--- a/t/t5515/refs.br-branches-default-octopus_branches-default
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-default_branches-default b/t/t5515/refs.br-branches-default_branches-default
deleted file mode 100644
index 21917c1e5db..00000000000
--- a/t/t5515/refs.br-branches-default_branches-default
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one b/t/t5515/refs.br-branches-one
deleted file mode 100644
index 8a705a5df25..00000000000
--- a/t/t5515/refs.br-branches-one
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-merge b/t/t5515/refs.br-branches-one-merge
deleted file mode 100644
index 8a705a5df25..00000000000
--- a/t/t5515/refs.br-branches-one-merge
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-merge_branches-one b/t/t5515/refs.br-branches-one-merge_branches-one
deleted file mode 100644
index 8a705a5df25..00000000000
--- a/t/t5515/refs.br-branches-one-merge_branches-one
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-octopus b/t/t5515/refs.br-branches-one-octopus
deleted file mode 100644
index 8a705a5df25..00000000000
--- a/t/t5515/refs.br-branches-one-octopus
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one-octopus_branches-one b/t/t5515/refs.br-branches-one-octopus_branches-one
deleted file mode 100644
index 8a705a5df25..00000000000
--- a/t/t5515/refs.br-branches-one-octopus_branches-one
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-branches-one_branches-one b/t/t5515/refs.br-branches-one_branches-one
deleted file mode 100644
index 8a705a5df25..00000000000
--- a/t/t5515/refs.br-branches-one_branches-one
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit b/t/t5515/refs.br-remote-explicit
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-explicit
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-merge b/t/t5515/refs.br-remote-explicit-merge
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-explicit-merge
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-merge_remote-explicit b/t/t5515/refs.br-remote-explicit-merge_remote-explicit
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-explicit-merge_remote-explicit
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-octopus b/t/t5515/refs.br-remote-explicit-octopus
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-explicit-octopus
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit-octopus_remote-explicit b/t/t5515/refs.br-remote-explicit-octopus_remote-explicit
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-explicit-octopus_remote-explicit
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-explicit_remote-explicit b/t/t5515/refs.br-remote-explicit_remote-explicit
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-explicit_remote-explicit
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob b/t/t5515/refs.br-remote-glob
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-glob
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-merge b/t/t5515/refs.br-remote-glob-merge
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-glob-merge
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-merge_remote-glob b/t/t5515/refs.br-remote-glob-merge_remote-glob
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-glob-merge_remote-glob
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-octopus b/t/t5515/refs.br-remote-glob-octopus
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-glob-octopus
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob-octopus_remote-glob b/t/t5515/refs.br-remote-glob-octopus_remote-glob
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-glob-octopus_remote-glob
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-remote-glob_remote-glob b/t/t5515/refs.br-remote-glob_remote-glob
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-remote-glob_remote-glob
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_branches-default b/t/t5515/refs.br-unconfig_branches-default
deleted file mode 100644
index 21917c1e5db..00000000000
--- a/t/t5515/refs.br-unconfig_branches-default
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_branches-one b/t/t5515/refs.br-unconfig_branches-one
deleted file mode 100644
index 8a705a5df25..00000000000
--- a/t/t5515/refs.br-unconfig_branches-one
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_remote-explicit b/t/t5515/refs.br-unconfig_remote-explicit
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-unconfig_remote-explicit
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.br-unconfig_remote-glob b/t/t5515/refs.br-unconfig_remote-glob
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.br-unconfig_remote-glob
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_branches-default b/t/t5515/refs.master_branches-default
deleted file mode 100644
index 21917c1e5db..00000000000
--- a/t/t5515/refs.master_branches-default
+++ /dev/null
@@ -1,12 +0,0 @@
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/heads/branches-default
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_branches-one b/t/t5515/refs.master_branches-one
deleted file mode 100644
index 8a705a5df25..00000000000
--- a/t/t5515/refs.master_branches-one
+++ /dev/null
@@ -1,12 +0,0 @@
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/heads/branches-one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_remote-explicit b/t/t5515/refs.master_remote-explicit
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.master_remote-explicit
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
diff --git a/t/t5515/refs.master_remote-glob b/t/t5515/refs.master_remote-glob
deleted file mode 100644
index 9bbbfd9fc53..00000000000
--- a/t/t5515/refs.master_remote-glob
+++ /dev/null
@@ -1,15 +0,0 @@
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/HEAD
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/origin/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/origin/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/origin/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/origin/two
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f refs/remotes/rem/master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/remotes/rem/one
-0567da4d5edd2ff4bb292a465ba9e64dcad9536b refs/remotes/rem/three
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8 refs/remotes/rem/two
-6c9dec2b923228c9ff994c6cfe4ae16c12408dc5 refs/tags/tag-master
-8e32a6d901327a23ef831511badce7bf3bf46689 refs/tags/tag-one
-22feea448b023a2d864ef94b013735af34d238ba refs/tags/tag-one-tree
-c61a82b60967180544e3c19f819ddbd0c9f89899 refs/tags/tag-three
-0e3b14047d3ee365f4f2a1b673db059c3972589c refs/tags/tag-three-file
-525b7fb068d59950d185a8779dc957c77eed73ba refs/tags/tag-two
-- 
2.12.2.windows.2.800.gede8f145e06


