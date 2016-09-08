Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936501F859
	for <e@80x24.org>; Thu,  8 Sep 2016 04:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbcIHEet (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 00:34:49 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35365 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbcIHEer (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 00:34:47 -0400
Received: by mail-it0-f65.google.com with SMTP id c198so3408183ith.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 21:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=H/oMKmqj2r/6fywoy1kPuqH4C9svHmztYaOTV3Va2SI=;
        b=vY1S+37qdNTufjqL+2mHluep1FkRTWhN9IufCbnP1sriD2CcmXX+/DEAG1SkLzenux
         epMySXOU0qegOyVWi35WrL+hK718YlPQGyGuLNAMDGs9EDCR3V8+riWxzk8MlRQsFlT/
         PnCLSwbC8pbjByHq0dfM5YGbvfsh1KHY/Odz9d80myAp1uIyTIDa32AU5RSDDxYufSP+
         OTZa8X33RNfEA4bnD6csSD74YIP+hDcgu2V1C0clCs6q2D+19q9lAmkm2dRjKM6yUtBd
         Lt0hqcXQCwPg0sZhxqiig2fJjhdzzrP9mTb9hMhAulwyXclJQYTHEiUpoorqyCLw2w3r
         XXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H/oMKmqj2r/6fywoy1kPuqH4C9svHmztYaOTV3Va2SI=;
        b=eg0xepQ56cMBc4lLK3l3p/wtrTeQMYG5XI6bL/GRdYmiHUxcsBe0gzb7rLPZTrYxGZ
         UV6boWidlrth3to+BazNd6gHvOm3Ewwz13mA+99u2SwZ6iEryqaSczCTpuni2fEzaS0T
         /qCHsOt7MZZLeUW6LG7Z04DDSnHhLt4CSNZy7EB/fSl9WJSNRiy0sEaSFFTSsd2d4rJD
         d/itUQxcgD1ippiB2Qxbucuq31gz/8Hlri4x3FcV4Jf8xXXjecFwy8QoWCU1b93YElrh
         3jwywAzRRQ8TnnI2t5Vmk0a8xMaFAqhJIFXAIVqFgj2I4tWmSWsJuS20TNZoEwe+iUzz
         n9ZA==
X-Gm-Message-State: AE9vXwMjzUs2fTBOivRshSBMbPAeuk3ijRJMRWJwjQMVlvpbKENIAyN9YHt7MWTA3IXqJw==
X-Received: by 10.36.107.82 with SMTP id v79mr11978773itc.52.1473309286816;
        Wed, 07 Sep 2016 21:34:46 -0700 (PDT)
Received: from wolverine.localdomain (c-67-182-247-84.hsd1.ut.comcast.net. [67.182.247.84])
        by smtp.gmail.com with ESMTPSA id x203sm5577519itb.11.2016.09.07.21.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 21:34:45 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     vascomalmeida@sapo.pt, gitster@pobox.com, git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH 4/5] git-merge-octopus: do not capitalize "octopus"
Date:   Wed,  7 Sep 2016 22:34:40 -0600
Message-Id: <20160908043440.5995-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In English, only proper nouns are capitalized.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 git-merge-octopus.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 308eafd..bcf0d92 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -30,7 +30,7 @@ do
 	esac
 done
 
-# Reject if this is not an Octopus -- resolve should be used instead.
+# Reject if this is not an octopus -- resolve should be used instead.
 case "$remotes" in
 ?*' '?*)
 	;;
@@ -59,7 +59,7 @@ do
 		# conflicts.  Last round failed and we still had
 		# a head to merge.
 		gettextln "Automated merge did not work."
-		gettextln "Should not be doing an Octopus."
+		gettextln "Should not be doing an octopus."
 		exit 2
 	esac
 
-- 
2.9.3

