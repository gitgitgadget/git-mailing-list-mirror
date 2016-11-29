Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF23A1FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 09:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754241AbcK2J5d (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 04:57:33 -0500
Received: from mail.zhinst.com ([212.126.164.98]:46972 "EHLO mail.zhinst.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbcK2J5b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 04:57:31 -0500
Received: from ziws08.zhinst.com ([10.42.0.7])
        by mail.zhinst.com (Kerio Connect 9.2.0) with ESMTP;
        Tue, 29 Nov 2016 10:57:25 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] RelNotes: typo fix in 2.11.0 notes
Date:   Tue, 29 Nov 2016 10:57:25 +0100
Message-Id: <20161129095725.13280-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0.rc3.5.g7cdf2ab.dirty
In-Reply-To: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
References: <xmqqinrdlr3o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

s/paht/path/ in the "Backwards compatibility notes" section of the
2.11.0 release notes.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 Documentation/RelNotes/2.11.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.11.0.txt b/Documentation/RelNotes/2.11.0.txt
index b7b7dd361ef0..4c8a9be60f52 100644
--- a/Documentation/RelNotes/2.11.0.txt
+++ b/Documentation/RelNotes/2.11.0.txt
@@ -5,7 +5,7 @@ Backward compatibility notes.
 
  * An empty string used as a pathspec element has always meant
    'everything matches', but it is too easy to write a script that
-   finds a path to remove in $path and run 'git rm "$paht"' by
+   finds a path to remove in $path and run 'git rm "$path"' by
    mistake (when the user meant to give "$path"), which ends up
    removing everything.  This release starts warning about the
    use of an empty string that is used for 'everything matches' and
-- 
2.11.0.rc3.5.g7cdf2ab.dirty


