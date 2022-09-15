Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958A5C6FA89
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 16:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiIOQMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIOQMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 12:12:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B3D9A947
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 09:12:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25EEE15474F;
        Thu, 15 Sep 2022 12:07:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ZZWICYlvf1bZMWL1JZ69hByEF
        JSFJRUU/UFIYrs6SnU=; b=ge9MRdKxL3ZKS0MuUpAPX90zTCYMDvH2UP93jMLId
        lA+WoSv28yZW6SyW2Fa9ijnh6gpKU+3wniaRhxPvzBAIH4FYBsY+G8mLC5JtbcuH
        WsBbz5Si6xIaeOF1I600KDJOpcxBwZTML7iaaSed9/qmoIjjSGOL3+HqAiGFdU6m
        Mo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D5F715474D;
        Thu, 15 Sep 2022 12:07:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 787D715474C;
        Thu, 15 Sep 2022 12:07:12 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] environ: simplify description of GIT_INDEX_FILE
Date:   Thu, 15 Sep 2022 09:06:58 -0700
Message-Id: <20220915160659.126441-5-gitster@pobox.com>
X-Mailer: git-send-email 2.37.3-780-gd940517dcb
In-Reply-To: <20220915160659.126441-1-gitster@pobox.com>
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 757A8CA4-3510-11ED-A60B-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3d31252bf2..535ff561c6 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -472,7 +472,7 @@ is worth noting that they may be used/overridden by S=
CMS sitting above
 Git so take care if using a foreign front-end.
=20
 `GIT_INDEX_FILE`::
-	This environment allows the specification of an alternate
+	This environment specifies an alternate
 	index file. If not specified, the default of `$GIT_DIR/index`
 	is used.
=20
--=20
2.37.3-780-gd940517dcb

