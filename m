Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E60C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 01:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjHJBVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 21:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHJBVR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 21:21:17 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CF119A1
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 18:21:15 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 4AD2F34EE6
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 03:21:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 22AF734EFB
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 03:21:14 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vmvBbGc5QnmK for <git@vger.kernel.org>;
        Thu, 10 Aug 2023 03:21:14 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 5F19F34EF4
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 03:21:12 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     git@vger.kernel.org
Subject: [[PATCH v2]] git-push.txt: fix grammar
Date:   Wed,  9 Aug 2023 21:21:05 -0400
Message-ID: <20230810012105.1423462-1-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.rc0.26.ga73c38ecaa
In-Reply-To: <xmqqcyzvk8cn.fsf@gitster.g>
References: <xmqqcyzvk8cn.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=UttIx32zK-AA:10 a=N3miCFJ7AAAA:8 a=tRapPCp_8zSyA7T_caMA:9
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on a blog post and using grammarly it suggested this
change.

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 Documentation/git-push.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 297927d866..5b4edaf4a8 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -37,7 +37,7 @@ the default `<refspec>` by consulting `remote.*.push` c=
onfiguration,
 and if it is not found, honors `push.default` configuration to decide
 what to push (See linkgit:git-config[1] for the meaning of `push.default=
`).
=20
-When neither the command-line nor the configuration specify what to
+When neither the command-line nor the configuration specifies what to
 push, the default behavior is used, which corresponds to the `simple`
 value for `push.default`: the current branch is pushed to the
 corresponding upstream branch, but as a safety measure, the push is
--=20
2.42.0.rc0.26.ga73c38ecaa

