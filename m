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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3A32047F
	for <e@80x24.org>; Tue, 19 Sep 2017 12:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdISMqx (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 08:46:53 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:45688
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751769AbdISMqw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 08:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1505825210;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=hJ83v1CqPupV69A+724ILcUY+gFzYqF+JGwi+oltxQQ=;
        b=Ck2S0T31AhiAs0PEBISd5umNZe6Pxk3cNVcf58GYYrZWjL28smt6M6elLVLs/B2r
        z5DZIw9ez1yvfHy8z72s2sOslFHA2RS8nHUgoG9Gf3bchffdVQzFS2zekm8DhQNiqFw
        Vf2xlA41LSo5XZbmmGx+Ebi5MaYpmnYY1y1HYw6Q=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015e9a2d3eb6-bee76ba8-4298-47d2-8822-d513bc33bd71-000000@eu-west-1.amazonses.com>
Subject: [PATCH] doc: camelCase the config variables to improve readability
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Sep 2017 12:46:50 +0000
X-SES-Outgoing: 2017.09.19-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The config variable used weren't readable as they were in the
crude form of how git stores/uses it's config variables.

Improve it's readability by replacing them with camelCased versions
of config variables as it doesn't have any impact on it's usage.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
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
