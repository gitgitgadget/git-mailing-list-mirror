Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52063C001DF
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 21:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjGZVm7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjGZVms (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 17:42:48 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE1626BB
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 14:42:43 -0700 (PDT)
Date:   Wed, 26 Jul 2023 21:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1690407760; x=1690666960;
        bh=SkAfcAnkysXjqNunJXXA7246z0207bBbBOJUNHOMcYY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=D8qwII7Vr8DabVjDzNPUaQEXcKE5dnSN7HpYFhw/5XeXL/n3UxgQVm4Qc6NfcBdI+
         5oPaJLlh7NYaVELdOkNFDMrzHLVn8fn//85Mbzg7X5WWABMagmCTTGkF95mi2z2hXL
         FIKs0boa0NpiMa4LLjxqbaPDWcVJKkG1WODT18zgOICIaiKGr5P5RSV5haTo1p6x3n
         Byd47HLU/nBvrV7eiFmyygYFuhc/9VEBdwD1E/j0WKl/eIGqOmLoBHd51JCuIJBIMF
         Wtl+XkVMPAzIUh+Jq9UkpbJsBnKoOw0vmZaaCSR68M1w6NaQG8CMalGYxH87lUAhzG
         w1UQ2ijNujUZw==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 2/3] builtin/worktree.c: convert tab in advice to space
Message-ID: <20230726214202.15775-3-jacobabel@nullpo.dev>
In-Reply-To: <20230726214202.15775-1-jacobabel@nullpo.dev>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <20230716033743.18200-1-jacobabel@nullpo.dev> <20230721044012.24360-1-jacobabel@nullpo.dev> <20230726214202.15775-1-jacobabel@nullpo.dev>
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
2.41.0


