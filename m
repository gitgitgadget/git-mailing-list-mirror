Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50BC20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbdLERw4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:52:56 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:38597 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdLERwv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:51 -0500
Received: by mail-it0-f68.google.com with SMTP id r6so3515964itr.3
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gz3xiVv3ISny7uecT9Un1VWPgaDxV6S0PNjIfuAyhBk=;
        b=X7l5mMfb6yUtVBJ92dHtyAtNBrGg4CCwPMZby5WEfwTR6kfJvL1yHlSNNHxHx687SY
         LcAXhi0+GpsaIXmAFoCgL8wOc4MPyVyTXLgFfTGUZa0DAuDbVAVmL8McnTXhmEU/9Bwi
         VM2pXDI6G9ncQslF3JRq5mJLZiIaw0AmjELxx1rZ0YS1IqHdjaturT242rFVUfy6hpLD
         qEFykrjkyT9L+qGy0xFAo4iWdgzEtdupkaOANQcKsXJGdlbmw2UdnwMCkjT5sS8AUL6X
         mp0tXw1Sq2hwo933XTz6kfS8PognMYJVA9olu6Y/j4RKBtbHdPspypCZcU//vbfISJ0V
         JTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gz3xiVv3ISny7uecT9Un1VWPgaDxV6S0PNjIfuAyhBk=;
        b=aGxu4hge7UmwOGsQiRS/zhYX94EzPmh7hqvVGo5d8RFcAsRf+I7JtO284SXfEgoRyC
         zzMHLR1hb1b9FRgoMwVlUbZF6myMzDHE2PExxxQGJ/TVhnlAP18U0rwxoZ45txIUkA93
         EJH/qJd0erAIruowuu04AZ2mTIpMpqI1aLgEMrxHvOc3nQBLgJS6o97hgEDuiGMeZ080
         kvXHv7JeLOTojLxeplaRCg4/waqJzfsPxn9tOnV801TIpIgmPCWus/AQPT4xtjXadHtx
         2vZ2lXoE5tO41rf4SZjWPR0tT58WNvtepx/CYWUx77N3g2YGfAiFEVXQh88ia4pU2mTx
         q4jw==
X-Gm-Message-State: AJaThX7Mf1bPqpzdfOuY38/dDgR0C5usyP6pZ1Z+2WGtUWorFDU0da9z
        pyGgVRtZAppxnoYkTVzbNaJxt2Aw660=
X-Google-Smtp-Source: AGs4zMayPRJzTbBswF8buBwPs3hq/0axgIVv24u3et0mkt0sKDHpeu27X2gqRjEvRmt7am21db6tqg==
X-Received: by 10.107.198.3 with SMTP id w3mr31576595iof.90.1512496370747;
        Tue, 05 Dec 2017 09:52:50 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:50 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 2/9] Documentation: use preferred name for the 'todo list' script
Date:   Tue,  5 Dec 2017 12:52:28 -0500
Message-Id: <20171205175235.32319-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use "todo list" instead of "instruction list" or "todo-list" to
reduce further confusion regarding the name of this script.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/rebase-config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
index dba088d7c68f..30ae08cb5a4b 100644
--- a/Documentation/rebase-config.txt
+++ b/Documentation/rebase-config.txt
@@ -23,10 +23,10 @@ rebase.missingCommitsCheck::
 	--edit-todo' can then be used to correct the error. If set to
 	"ignore", no checking is done.
 	To drop a commit without warning or error, use the `drop`
-	command in the todo-list.
+	command in the todo list.
 	Defaults to "ignore".
 
 rebase.instructionFormat::
 	A format string, as specified in linkgit:git-log[1], to be used for the
-	instruction list during an interactive rebase.  The format will
+	todo list during an interactive rebase.  The format will
 	automatically have the long commit hash prepended to the format.
-- 
2.15.1.280.g10402c1f5b5c

