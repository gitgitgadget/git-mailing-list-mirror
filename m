Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C945C20954
	for <e@80x24.org>; Fri,  1 Dec 2017 15:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbdLAP5G (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 10:57:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60780 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752375AbdLAP46 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 10:56:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 090ADC9834;
        Fri,  1 Dec 2017 10:56:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=mh4M
        AgxjoCqvQ30nmo1gK1FFMDw=; b=h62LoyfQNItonuv5SwshTEzUkHsHRKDREyPk
        xhET5WhruSn/cZ+3iGQ9Apiqu0gUFpmo6loGyDcOZ96wgFWuUQ5ftR8uIUjJ+//L
        L6QcjjVlp/ywLAiUde4rVG7nZCwHUvWvvGzM8rro6QAupVdioxu3R8+K2Tvb7DE9
        O8RVtfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        nruRmbVi4dxKXrzRLxCpWvVXTEDFELIJKIbHOPEe1cMWXUN97oYth5oI7Spt+I3Y
        75L8xwqangH0K8dqZH3YKGsRZNYnZbc61Kpor5JwrGHRtXx05ljf9cJa1UNxvKeq
        b007Zk/ioM+Nj2vXvqtY+sFSIef+uPo3iKtYnfOISWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2A21C9833;
        Fri,  1 Dec 2017 10:56:55 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4AC4EC9831;
        Fri,  1 Dec 2017 10:56:55 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 1/2] t/lib-git-svn: cleanup inconsistent tab/space usage
Date:   Fri,  1 Dec 2017 10:56:52 -0500
Message-Id: <20171201155653.29553-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171201041133.GF3693@zaya.teonanacatl.net>
References: <20171201041133.GF3693@zaya.teonanacatl.net>
X-Pobox-Relay-ID: 413A1F72-D6B0-11E7-87F8-575F0C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Acked-by: Eric Wong <e@80x24.org>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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

