Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E670C001DF
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 21:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGZVmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 17:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGZVmd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 17:42:33 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380026AE
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 14:42:31 -0700 (PDT)
Date:   Wed, 26 Jul 2023 21:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1690407749; x=1690666949;
        bh=uSZo9gXUOBlaHfJjX4TagKZNE44DysZm9wlkEDAdmv8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=N08NjBlsOFB/wqGBFzI2NM/6wIzLvod1k9THGzM+n8la0M/kPzWscREpqKGfLzn6l
         ESm9ZXLWvmfqBkI6iAbMXpwfbnacpZYAROAXCZPAvjAL1rRRNcVgr1VT+Vob+5e7CK
         02yUKwYZyjwihgltO+rQdTnAGDVq3JcbKu0tmMm5X58Ygw5jKdR57JBsbdjPsqmz56
         NQ0GefhINRRq4unSvQGUbTK+SSHzLn+MqVanHRKcDo2yLuzKqHW2R8fehEqMMhtGg7
         kARmzO0hkGFyU+KXmkp1QKJLLfxWkfkhObA6eKPkeK/HDPlO00yF6NlWj1NlJK6nTN
         vkkHDMhZmxL5Q==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 1/3] t2400: drop no-op `--sq` from rev-parse call
Message-ID: <20230726214202.15775-2-jacobabel@nullpo.dev>
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
 t/t2400-worktree-add.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 0ac468e69e..e106540c6d 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -995,7 +995,7 @@ test_dwim_orphan () {
 =09=09=09=09=09grep "$invalid_ref_regex" actual &&
 =09=09=09=09=09! grep "$orphan_hint" actual
 =09=09=09=09else
-=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-format=
=3Dabsolute --git-path HEAD) &&
+=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --path-format=3Dabso=
lute --git-path HEAD) &&
 =09=09=09=09=09headcontents=3D$(cat "$headpath") &&
 =09=09=09=09=09grep "HEAD points to an invalid (or orphaned) reference" ac=
tual &&
 =09=09=09=09=09grep "HEAD path:\s*.$headpath." actual &&
--=20
2.41.0


