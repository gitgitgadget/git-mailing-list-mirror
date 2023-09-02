Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877B0C83F2C
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 22:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjIBWRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 18:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjIBWRG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 18:17:06 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C2BCE0
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 15:17:03 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id F28653F837;
        Sun,  3 Sep 2023 00:17:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id B159F3F9A4;
        Sun,  3 Sep 2023 00:17:01 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y-gfVPQ5hp98; Sun,  3 Sep 2023 00:17:01 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id B95E63F5E2;
        Sun,  3 Sep 2023 00:16:59 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2 3/3] git-rebase.txt: Add deprecation notice to the --fork-point options
Date:   Sat,  2 Sep 2023 18:16:41 -0400
Message-ID: <20230902221641.1399624-4-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.114.g06b8c4a877
In-Reply-To: <20230902221641.1399624-1-wesleys@opperschaap.net>
References: <xmqq1qfiubg5.fsf@gitster.g>
 <20230902221641.1399624-1-wesleys@opperschaap.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=zNV7Rl7Rt7sA:10 a=N3miCFJ7AAAA:8 a=3Io1k9uqV22mWJ5WRBcA:9
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Wesley Schwengle <wesleys@opperschaap.net>
---
 Documentation/git-rebase.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e7b39ad244..e47b58bec2 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -462,7 +462,9 @@ ends up being empty, the `<upstream>` will be used as=
 a fallback.
 +
 If `<upstream>` or `--keep-base` is given on the command line, then
 the default is `--no-fork-point`, otherwise the default is
-`--fork-point`. See also `rebase.forkpoint` in linkgit:git-config[1].
+`--fork-point`. See also `rebase.forkpoint` in linkgit:git-config[1]. Th=
is
+behaviour will be changed in an upcoming release of git. It is advised t=
hat you
+set `rebase.forkpoint` in your config or supply the command line switche=
s.
 +
 If your branch was based on `<upstream>` but `<upstream>` was rewound an=
d
 your branch contains commits which were dropped, this option can be used
--=20
2.42.0.103.g5622fd1409.dirty

