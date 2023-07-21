Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD08C04A6A
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 04:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGUEl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 00:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjGUElA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 00:41:00 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7792D4C
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 21:40:51 -0700 (PDT)
Date:   Fri, 21 Jul 2023 04:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689914450; x=1690173650;
        bh=pJXd8FY5WSrCNy6kRhGU82BGrv5mOg1MuRiWyX8jvI4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=gLSglWnoXJf5WijcSr13TX31JYgqg8Jj3qHWRfQiBG5WoZ8X9aTZPTlte7shqJsf7
         NpmesyDFxv3zpOZJ/Mq9SGJRuLf8Lpj4CJQ/0Kart1bqkmisJnzkOOL+uNrSlcRK1H
         00lPjfsQSU75hn5xcYbbWZAZjyWiCNNrhOuUHyJHQspUZlVYXoZemNpawfPKk9W+5E
         7DpZTmZT6CcIbFHv+P3e7XuK9iqH/WRnzzt5zwkYdyg+w2/oWk66bByNNYLhGN8aZh
         xBVpKD17MiaRXB0bBMEHqp8YlblVPZ+nv8LM5c0D8ezFc2E7xduvlkggE4/9qFMaga
         1L8Nlx8585dAA==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 2/3] builtin/worktree.c: convert tab in advice to space
Message-ID: <20230721044012.24360-3-jacobabel@nullpo.dev>
In-Reply-To: <20230721044012.24360-1-jacobabel@nullpo.dev>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <20230716033743.18200-1-jacobabel@nullpo.dev> <20230721044012.24360-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 builtin/worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7c114d56a3..3cdcb86cd4 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -54,14 +54,14 @@
 =09"(branch with no commits) for this repository, you can do so\n" \
 =09"using the --orphan flag:\n" \
 =09"\n" \
-=09"=09git worktree add --orphan -b %s %s\n")
+=09"    git worktree add --orphan -b %s %s\n")
=20
 #define WORKTREE_ADD_ORPHAN_NO_DASH_B_HINT_TEXT \
 =09_("If you meant to create a worktree containing a new orphan branch\n" =
\
 =09"(branch with no commits) for this repository, you can do so\n" \
 =09"using the --orphan flag:\n" \
 =09"\n" \
-=09"=09git worktree add --orphan %s\n")
+=09"    git worktree add --orphan %s\n")
=20
 static const char * const git_worktree_usage[] =3D {
 =09BUILTIN_WORKTREE_ADD_USAGE,
--=20
2.39.3


