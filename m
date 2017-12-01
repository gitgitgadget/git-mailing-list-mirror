Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A71E20C11
	for <e@80x24.org>; Fri,  1 Dec 2017 02:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbdLACcp (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 21:32:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60506 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751846AbdLACcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 21:32:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A06AB199B;
        Thu, 30 Nov 2017 21:32:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=JkiT
        emTLti+p7KkH9WLEgZL5CC8=; b=ng8RNTeeexdo+XpsFC7J0BwcNgFNFuq0f7+r
        g+gz37CDkbaT3IXiw2mrjenyCO6c1zyygMX41960TX+8cJdDVuCOzc3kwj39ejTZ
        QNB1RXOIqs6lXUqzwtd0wgahd9ihHSvtzl0kfJQSPJ6kSK6QvjPSe2G6jigE3f+q
        nUjjk64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        eAAYdWV+barze7jF2KmIqicTWSvz8eGmWObWfDXEPlutk/ajsT2W7mVaWCtGljqe
        TmqqpK1w2dc/SZtGb/QzLAJXpYzpSthAtBx68bzJWa5sLz8RyTlbxZoyNrDOy9sI
        yoeIYS4lhPxcUb9SuZ7AcHkwvlc5M3M4ueur0Jz8VQg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 222F4B199A;
        Thu, 30 Nov 2017 21:32:43 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 88689B1995;
        Thu, 30 Nov 2017 21:32:41 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>
Subject: [PATCH 1/2] t/lib-git-svn: whitespace cleanup
Date:   Thu, 30 Nov 2017 21:32:38 -0500
Message-Id: <20171201023239.26153-2-tmz@pobox.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171201023239.26153-1-tmz@pobox.com>
References: <20171201023239.26153-1-tmz@pobox.com>
X-Pobox-Relay-ID: E84B29A8-D63F-11E7-8C07-8EF31968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-git-svn.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
index 688313ed5c..84366b2624 100644
--- a/t/lib-git-svn.sh
+++ b/t/lib-git-svn.sh
@@ -17,8 +17,8 @@ SVN_TREE=$GIT_SVN_DIR/svn-tree
 svn >/dev/null 2>&1
 if test $? -ne 1
 then
-    skip_all='skipping git svn tests, svn not found'
-    test_done
+	skip_all='skipping git svn tests, svn not found'
+	test_done
 fi
 
 svnrepo=$PWD/svnrepo
@@ -110,18 +110,18 @@ EOF
 }
 
 require_svnserve () {
-    if test -z "$SVNSERVE_PORT"
-    then
-	skip_all='skipping svnserve test. (set $SVNSERVE_PORT to enable)'
-        test_done
-    fi
+	if test -z "$SVNSERVE_PORT"
+	then
+		skip_all='skipping svnserve test. (set $SVNSERVE_PORT to enable)'
+		test_done
+	fi
 }
 
 start_svnserve () {
-    svnserve --listen-port $SVNSERVE_PORT \
-             --root "$rawsvnrepo" \
-             --listen-once \
-             --listen-host 127.0.0.1 &
+	svnserve --listen-port $SVNSERVE_PORT \
+		 --root "$rawsvnrepo" \
+		 --listen-once \
+		 --listen-host 127.0.0.1 &
 }
 
 prepare_a_utf8_locale () {
-- 
2.15.1

