Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF2F41F461
	for <e@80x24.org>; Tue, 25 Jun 2019 06:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfFYGgU (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 02:36:20 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:43218
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727141AbfFYGgU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Jun 2019 02:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1561444578;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=0AmcfvTYFeSgQB4NSZNHcHC6DudIHyMrfhIid4dcmEA=;
        b=eq/T9lHniSIIuZTZenGsXtrCitjdXtRtQh8FUDwbk3ELyIz+vsaNnW4vRg7qefgQ
        ycrzOJgMDsuUTu9d+Bd/EKC7kJNYaSlsik/QIAL4P8BnpMQGJgbkazXUMYIyIGerjec
        jp9ZH7SFsiZKt5zGfpktnZ/+6P0HqOKQNjCCWKVc=
From:   Catalin Criste <cris_linu_w@yahoo.com>
To:     git@vger.kernel.org
Message-ID: <0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com>
Subject: [PATCH] doc: fix form -> from typo
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Jun 2019 06:36:18 +0000
X-SES-Outgoing: 2019.06.25-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Catalin Criste <cris_linu_w@yahoo.com>
---
 Documentation/git-stash.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 7ef8c4791177b..b96ce2d02d149 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -88,7 +88,7 @@ save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
 
 	This option is deprecated in favour of 'git stash push'.  It
 	differs from "stash push" in that it cannot take pathspecs,
-	and any non-option arguments form the message.
+	and any non-option arguments from the message.
 
 list [<options>]::
 

--
https://github.com/git/git/pull/521
