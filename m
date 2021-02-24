Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C73C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F84F60202
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhBXU1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:27:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64857 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbhBXU1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 15:27:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C797F95F41;
        Wed, 24 Feb 2021 15:26:53 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=r8Mj2h52tJJTeoxhAR6EhTYFa
        0I=; b=ALCBwtk8IJHUm0Y5/atb4n4m9bUhwQ3b7z8M2v8QXp7b83Tpkbm3+SPbs
        1erDgIjF4bEfVh/MyxJelkrc4kUYZY0Lm5UL5IXpxDx/so0jyYSo2EHpkLXRZhY5
        CJ8Vfmwb5FRAomXl1ZkxSqboJuwXLzzGAX01Zkpitp0NUboTk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=K9l2X8fZ+vqZFn6biGu
        1afxCZ9hvpEUaZZn+ZmBqA8a/RDQaakvKCg6rHtkt/dBHrHYQWgzcbCRiVpVPRU7
        6BDaNwbjNBSKqul6U60Y1NuuKLF5JmKLD2dtdhwjnruEiNXfhYinDaKJk1KEy5s0
        kz5XY2X0hB8htKuaC4I4s12g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD9F595F40;
        Wed, 24 Feb 2021 15:26:53 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5163295F3E;
        Wed, 24 Feb 2021 15:26:53 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 3/3] index-format doc: camelCase core.excludesFile
Date:   Wed, 24 Feb 2021 12:26:41 -0800
Message-Id: <20210224202641.913770-4-gitster@pobox.com>
X-Mailer: git-send-email 2.30.1-826-g07a034c5ea
In-Reply-To: <20210224202641.913770-1-gitster@pobox.com>
References: <xmqqlfbe1sim.fsf@gitster.g>
 <20210224202641.913770-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: A1C0368E-76DE-11EB-92B8-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/index-format.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/tec=
hnical/index-format.txt
index 69edf46c03..8af608055f 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -251,14 +251,14 @@ Git index format
   - Stat data of $GIT_DIR/info/exclude. See "Index entry" section from
     ctime field until "file size".
=20
-  - Stat data of core.excludesfile
+  - Stat data of core.excludesFile
=20
   - 32-bit dir_flags (see struct dir_struct)
=20
   - Hash of $GIT_DIR/info/exclude. A null hash means the file
     does not exist.
=20
-  - Hash of core.excludesfile. A null hash means the file does
+  - Hash of core.excludesFile. A null hash means the file does
     not exist.
=20
   - NUL-terminated string of per-dir exclude file name. This usually
--=20
2.30.1-826-g07a034c5ea

