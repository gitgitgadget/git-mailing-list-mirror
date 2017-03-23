Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78CD820958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbdCWRck (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:32:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51704 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751313AbdCWRcj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:32:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9308E885CA;
        Thu, 23 Mar 2017 13:32:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=1oeMgsYIYR/5jjyIFgWUkrq+9zQ
        =; b=mSjoPRRQ+0Iw85scr7TcBvE88rDZl0Lj7VAnSwilCpKNe2lHCeFfdpypXM9
        7obH5jmqbWRTbjjt2nWoo1WhvuXer5SO94TGZN+jVSsiCzbiEBKn7RS7Sm1IMGcc
        o9dKjKYOxXTxKY+IWW8ubP6uGrS5/qxMigkSvICyC7Jte8pA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF0E3885C9;
        Thu, 23 Mar 2017 13:32:36 -0400 (EDT)
Received: from kmlap.hsd1.ct.comcast.net (unknown [24.60.167.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4308B885C8;
        Thu, 23 Mar 2017 13:32:36 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] doc/config: grammar fixes for core.{editor,commentChar}
Date:   Thu, 23 Mar 2017 13:32:16 -0400
Message-Id: <20170323173216.26176-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.12.1
X-Pobox-Relay-ID: B4853ED2-0FEE-11E7-8211-FC50AE2156B6-24757444!pb-smtp2.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id; s=mesmtp;
 bh=1oeMgsYIYR/5jjyIFgWUkrq+9zQ=;
 b=qAFCPLK6k+kaonK+g7WrSv6pRnAZwuK0zXgH2qjeHsjAOeU70yI/m15nQmV93xRevFLxypqMVvZ5RDVaKO6C4T0Dm4dtWXdd5ANFxG/PoJpQmZvUd06Xpo//ajHWWWOH8qcuOpFzHr+YRaExSm3qY097WcGzTeQXp9LGVln4ZcU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/config.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0d8df5a9f..1df196545 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -737,13 +737,13 @@ alternative to having an `init.templateDir` where you've changed
 default hooks.
 
 core.editor::
-	Commands such as `commit` and `tag` that lets you edit
-	messages by launching an editor uses the value of this
+	Commands such as `commit` and `tag` that let you edit
+	messages by launching an editor use the value of this
 	variable when it is set, and the environment variable
 	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
 
 core.commentChar::
-	Commands such as `commit` and `tag` that lets you edit
+	Commands such as `commit` and `tag` that let you edit
 	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
 	(default '#').
-- 
2.12.1

