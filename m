Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 165E820A28
	for <e@80x24.org>; Wed, 20 Sep 2017 12:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdITMWW (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 08:22:22 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:54176
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751488AbdITMWV (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 Sep 2017 08:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1505910140;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=U/jplJuqvTALv8QmRC1RdbbKrNPyeb7JwpJa9vC91VY=;
        b=aXs51fFP0kVGjQ/8rB9atEKh9OJjFPfKsLtNhC3k0ZEhg2V4tuJSPVKYQxnwIkHs
        jXaEZNyg4MGM8bmMF2jw7SICkqVCfBO5tT80bkSyzN6bpBWSpuEzfI/NrhyQxyHkTJw
        x3bb5YMsiqVFLMqU5QQw2QGHedQXKe6Iep8BrS/M=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015e9f3d2d6b-b68ad740-0847-42e2-beb6-9d3fde4b427f-000000@eu-west-1.amazonses.com>
In-Reply-To: <20170920052705.GC126984@aiede.mtv.corp.google.com>
References: <20170920052705.GC126984@aiede.mtv.corp.google.com>
Subject: [PATCH v2] doc: camelCase the config variables to improve
 readability
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Sep 2017 12:22:20 +0000
X-SES-Outgoing: 2017.09.20-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few configuration variable names of Git are composite words. References
to such variables in manpages are hard to read because they use all-lowercase
names, without indicating where each word ends and begins.

Improve its readability by using camelCase instead.  Git treats these
names case-insensitively so this does not affect functionality. This
also ensures consistency with other parts of the docs that use camelCase
fo refer to configuration variable names.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-branch.txt | 4 ++--
 Documentation/git-tag.txt    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index e292737b9c5ab..58f1e5c9c74e1 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -92,10 +92,10 @@ OPTIONS
 	all changes made to the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 	Note that in non-bare repositories, reflogs are usually
-	enabled by default by the `core.logallrefupdates` config option.
+	enabled by default by the `core.logAllRefUpdates` config option.
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
-	`core.logallrefupdates`.
+	`core.logAllRefUpdates`.
 
 -f::
 --force::
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 543fb425ee7c1..95e9f391d88fc 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -174,7 +174,7 @@ This option is only applicable when listing tags without annotation lines.
 	`core.logAllRefUpdates` in linkgit:git-config[1].
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
-	`core.logallrefupdates`.
+	`core.logAllRefUpdates`.
 
 <tagname>::
 	The name of the tag to create, delete, or describe.

--
https://github.com/git/git/pull/407
