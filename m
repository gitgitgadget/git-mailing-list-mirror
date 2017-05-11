Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D7512018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932949AbdEKNsT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:60134 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932181AbdEKNrt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:47:49 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MF9WR-1dGCww1tIB-00GI1H; Thu, 11
 May 2017 15:47:41 +0200
Date:   Thu, 11 May 2017 15:47:40 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/11] Documentation: really deprecate .git/remotes/ and
 .git/branches/
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <9856edc5dd10c716eba6a00111478a5589cade8f.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ylugx+p+0T7xeP5nHy6h3wwvU9OGhwJ9hdCwtl0gakK9F+7c0h4
 ToUS6bYH1uX1heniwqJhbReBG91hJSwciVW6w9YMOgIdFxsacWzElryqWKX2AqhtUkzgdxS
 /YYjOqQLABiZdWeaT/9YC80vjjv6JnqXi41E2I4dkWR7XjTXb20slnkXcbItB6y1xtLaEQr
 lJbxmQsioQyEIKLBA0K5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V5fMHel5nA0=:fdUFx1FMmNZrvAHOMrKmYP
 LodTRsdacbf2CBcHF/7nM8X0z/MudjQnHRChuaPs0OrHFl3ZoW8WDTeCeML11QnH3l73iZXBI
 BGCt/JbMfSA7I1sU3F5X8J/CJt6b3swD/37HJBLhzUBqK7U4vvH6aMnyebEnUGOzaysABY626
 9DpGsXxZapIzP4FJyDKWUg3YKfgtRLHzMsQhAuNWRRs8XqluX7nj5hzoR9j7/nAmwhwbuv53W
 ix+yWBF3PGjT21T0Re7cq/lTCr/rq+65hhWSAIHhMYsVdbWjxmxX9qmBNagAtZXMzSFI47fG5
 kHO8hxXw2vPS/DG5GVl7S42+78hRpulMQ1cFOJgndggpgyS3ecYTgOwxXv0Do8nF3Jr458+HZ
 W8njNe+aGgnnrxeFuWd+T7ex60xgz6aHwnirks06sdkrFTcn+ij+ztjxCvLXemghf8Dk1b4MH
 BuKH7yDjIbyOsySco04cpcFRP0I9ITWOY1xdPZHaMBENhDNN24MPh4L+ETslDgUFGw102k8Hp
 GY5GYBfDQ14xbR6Q3SUuOxvuPV6nH7Ud54lnRbQMT3yzoBGZImt5x6zDyWxfL908yBO2sdsKn
 gqaDYm4pszSASZtTXzyvXOPJ43lir+qjhLi4JGIoln4pFYnYo9/KbWc20B7DyLBXp9h+Ff2Hx
 Zju9AFSi4vpdT9ZDtUQJOwOKq38d43rObo3+fNKp/v2G2jKZ2ek/WEyw+aRB8CAXg2KejNh+W
 9ZJ2KLZiXE/8un5VJKtGS50rRnFtpwrisHnO1nJ1a5RqcfQhiHCPTWMR+/W+PRNp8Q5Q6yq6v
 9q85Ssp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation did not make it quite clear just how deprecated these
directories are.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/gitrepository-layout.txt | 19 +++++-----
 Documentation/urls-remotes.txt         | 65 ++--------------------------------
 2 files changed, 11 insertions(+), 73 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index f51ed4e37cd..9f2275f06d5 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -144,12 +144,11 @@ config::
 	used instead.
 
 branches::
-	A slightly deprecated way to store shorthands to be used
+	A highly deprecated way to store shorthands to be used
 	to specify a URL to 'git fetch', 'git pull' and 'git push'.
 	A file can be stored as `branches/<name>` and then
 	'name' can be given to these commands in place of
-	'repository' argument.  See the REMOTES section in
-	linkgit:git-fetch[1] for details.  This mechanism is legacy
+	'repository' argument.  This mechanism is legacy
 	and not likely to be found in modern repositories. This
 	directory is ignored if $GIT_COMMON_DIR is set and
 	"$GIT_COMMON_DIR/branches" will be used instead.
@@ -213,13 +212,13 @@ info/sparse-checkout::
 	See also: linkgit:git-read-tree[1].
 
 remotes::
-	Stores shorthands for URL and default refnames for use
-	when interacting with remote repositories via 'git fetch',
-	'git pull' and 'git push' commands.  See the REMOTES section
-	in linkgit:git-fetch[1] for details.  This mechanism is legacy
-	and not likely to be found in modern repositories. This
-	directory is ignored if $GIT_COMMON_DIR is set and
-	"$GIT_COMMON_DIR/remotes" will be used instead.
+	A highly deprecated location to store shorthands for URL and
+	default refnames for use when interacting with remote
+	repositories via 'git fetch', 'git pull' and 'git push'
+	commands.  This mechanism is legacy and not likely to be
+	found in modern repositories. This directory is ignored if
+	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/remotes" will
+	be used instead.
 
 logs::
 	Records of changes made to refs are stored in this directory.
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index bd184cd6539..a7214a9cae5 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -3,15 +3,8 @@ include::urls.txt[]
 REMOTES[[REMOTES]]
 ------------------
 
-The name of one of the following can be used instead
-of a URL as `<repository>` argument:
-
-* a remote in the Git configuration file: `$GIT_DIR/config`,
-* a file in the `$GIT_DIR/remotes` directory, or
-* a file in the `$GIT_DIR/branches` directory.
-
-All of these also allow you to omit the refspec from the command line
-because they each contain a refspec which git will use by default.
+The name of a remote in the Git configuration file: `$GIT_DIR/config`
+can be used instead of a URL as `<repository>` argument.
 
 Named remote in configuration file
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -35,60 +28,6 @@ config file would appear like this:
 The `<pushurl>` is used for pushes only. It is optional and defaults
 to `<url>`.
 
-Named file in `$GIT_DIR/remotes`
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You can choose to provide the name of a
-file in `$GIT_DIR/remotes`.  The URL
-in this file will be used to access the repository.  The refspec
-in this file will be used as default when you do not
-provide a refspec on the command line.  This file should have the
-following format:
-
-------------
-	URL: one of the above URL format
-	Push: <refspec>
-	Pull: <refspec>
-
-------------
-
-`Push:` lines are used by 'git push' and
-`Pull:` lines are used by 'git pull' and 'git fetch'.
-Multiple `Push:` and `Pull:` lines may
-be specified for additional branch mappings.
-
-Named file in `$GIT_DIR/branches`
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-You can choose to provide the name of a
-file in `$GIT_DIR/branches`.
-The URL in this file will be used to access the repository.
-This file should have the following format:
-
-
-------------
-	<url>#<head>
-------------
-
-`<url>` is required; `#<head>` is optional.
-
-Depending on the operation, git will use one of the following
-refspecs, if you don't provide one on the command line.
-`<branch>` is the name of this file in `$GIT_DIR/branches` and
-`<head>` defaults to `master`.
-
-git fetch uses:
-
-------------
-	refs/heads/<head>:refs/heads/<branch>
-------------
-
-git push uses:
-
-------------
-	HEAD:refs/heads/<head>
-------------
-
 
 
 
-- 
2.12.2.windows.2.800.gede8f145e06


