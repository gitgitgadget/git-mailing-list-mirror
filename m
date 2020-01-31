Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B9DC35246
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 23:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEE420705
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 23:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgAaXcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:32:10 -0500
Received: from mx.sdas.de ([88.198.162.67]:42102 "EHLO mx.sdas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgAaXcK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 18:32:10 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2020 18:32:09 EST
Received: from [192.168.1.58] (unknown [31.36.247.254])
        (Authenticated sender: etienne.servais@voucoux.fr)
        by mx.sdas.de (Postfix) with ESMTPSA id 9ED4811C19F
        for <git@vger.kernel.org>; Sat,  1 Feb 2020 00:24:31 +0100 (CET)
From:   =?UTF-8?Q?=c3=89tienne_Servais?= <etienne.servais@voucoux.fr>
Subject: [PATCH] doc: add documentation for git log --no-follow
To:     git@vger.kernel.org
Message-ID: <85e71c97-9e0a-863e-179f-a6e1f14365ce@voucoux.fr>
Date:   Sat, 1 Feb 2020 00:24:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This feature was added by commit
076c98372e (log: add "log.follow" configuration variable, 2015-07-07)
but remained undocumented.

Signed-off-by: Étienne Servais <etienne.servais@voucoux.fr>
---
This is my first patch to git \o/
Sent with thunderbird with help of format-patch'doc (So, it works!).
I've tested the patch and git am works well on maint and next.
I couldn't figure if I shall merge the --no-follow doc with the follow
as is done for --no-decorate and --decorate just after. 
I couldn't think of a proper phrasing so I'll be glad to get suggestion on this.

 Documentation/git-log.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index bed09bb09e..cc2ad98167 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -28,6 +28,9 @@ OPTIONS
 	Continue listing the history of a file beyond renames
 	(works only for a single file).
 
+--no-follow::
+	Override the log.follow configuration.
+
 --no-decorate::
 --decorate[=short|full|auto|no]::
 	Print out the ref names of any commits that are shown. If 'short' is
@@ -205,7 +208,8 @@ log.follow::
 	If `true`, `git log` will act as if the `--follow` option was used when
 	a single <path> is given.  This has the same limitations as `--follow`,
 	i.e. it cannot be used to follow multiple files and does not work well
-	on non-linear history.
+	on non-linear history. This setting can be disabled by the `--no-follow`
+	option.
 
 log.showRoot::
 	If `false`, `git log` and related commands will not treat the
-- 
2.17.1

