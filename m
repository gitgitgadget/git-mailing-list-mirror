Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52BE1F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 13:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdGYNQM (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 09:16:12 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:11010 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbdGYNQL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 09:16:11 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jul 2017 09:16:11 EDT
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 599CC4C1;
        Tue, 25 Jul 2017 15:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:date:date:subject:subject:from:from:received:received
        :received; s=dkim20160331; t=1500987982; x=1500988004; bh=1PfgXu
        5gRiDebvn9U8b7DGGqsYejaSkDC71vddIVMmM=; b=nfPhcxLRHw/7AcrjsVm06A
        Eln5LAunCQLMHzAyT5TSvHewq7A1GrIwJVq/EqbPs2m6ZZ02SDdu7BDcWSWQwij4
        +GqVeEx70i7XC7ImPTjgKGa0XBK+qbPNoJh75nE35RwREIaNAFcwKH+fFrNL9Jem
        /z2F77esbXWqorzqq9cGULMlPligFvAdXXSBxLlW+cTQ/FE2jmTAkgowT+LgM0pA
        4H2soaaPv3QQP9MkUwKr/PRBOeL30JnJFagsm/cG3ntg/f/jCcDGAWc5EQVdQKje
        MKCeiagoQxN8UuaM4odk2V4lbLS5QsJDd0G97kctGMdgWodsp+0KF5QIqfjNkyqH
        6GjYfsIvJGq6Jv02wS2ZwKWTKdIwP2kWeMhN4vAjhzNX06DbYXtbg3CFiiwLuy8t
        lOTflITzW0KLQfUm8zKrC9HwN4gqyEcnQBPpdI2qJXgk6wLUtev4J/nnP6L8aIRK
        OVILtqeII8UyiXXplL7PBin89DlCMunzUxHtF9g9f6ertWJZuLAUUWM0wRphOTJ4
        WqugSiOt15EKgjpkLTTyz+1MIMyBYmKvUxKUulLGmNLLYHKJaMI7OIS4YX6E30de
        l82prD44JOjh/Lbhl5upXTy/LkHJgdlvZdG6QySKvbs5lFzctm6iIhAVV/Y/mwLP
        tydq9Xae8Ub9U0z0+wjN8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MiRdl396-d9K; Tue, 25 Jul 2017 15:06:22 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id CAF4C3C2;
        Tue, 25 Jul 2017 15:06:22 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 8E9091915;
        Tue, 25 Jul 2017 15:06:22 +0200 (CEST)
From:   Dimitrios Christidis <dimitrios@christidis.me>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Dimitrios Christidis <dimitrios@christidis.me>
Subject: [PATCH] fmt-merge-msg: fix coding style
Date:   Tue, 25 Jul 2017 15:06:06 +0200
Message-Id: <20170725130606.6158-1-dimitrios@christidis.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Align argument list and place opening brace on its own line.

Signed-off-by: Dimitrios Christidis <dimitrios@christidis.me>
---
 builtin/fmt-merge-msg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 10cbb4341..e99b5ddbf 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -408,7 +408,8 @@ static void shortlog(const char *name,
 }
 
 static void fmt_merge_msg_title(struct strbuf *out,
-	const char *current_branch) {
+				const char *current_branch)
+{
 	int i = 0;
 	char *sep = "";
 
-- 
2.13.3

