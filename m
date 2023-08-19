Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B409C7EE2C
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 00:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjHTALG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Aug 2023 20:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjHTAKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2023 20:10:47 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF53F4CC133
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 13:35:49 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 8385F3EA0E
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 22:35:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 59EB53E7C7
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 22:35:48 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fV38G02IWM-K for <git@vger.kernel.org>;
        Sat, 19 Aug 2023 22:35:48 +0200 (CEST)
Received: from neptune.setarnet.aw (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 89C7A3E667
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 22:35:47 +0200 (CEST)
From:   Wesley Schwengle <wesleys@opperschaap.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] git-rebase.txt: Add deprecation notice to the --fork-point options
Date:   Sat, 19 Aug 2023 16:34:50 -0400
Message-ID: <20230819203528.562156-3-wesleys@opperschaap.net>
X-Mailer: git-send-email 2.42.0.rc2.7.gf9972720e9.dirty
In-Reply-To: <20230819203528.562156-1-wesleys@opperschaap.net>
References: <20230819203528.562156-1-wesleys@opperschaap.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=UttIx32zK-AA:10 a=N3miCFJ7AAAA:8 a=3Io1k9uqV22mWJ5WRBcA:9
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
2.42.0.rc2.7.gf9972720e9.dirty

