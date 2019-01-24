Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55F11F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfAXVpg (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:45:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50232 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAXVpg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:45:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F16721350AF;
        Thu, 24 Jan 2019 16:45:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=LtqXSbm90vzQ94k3JuNGT6wTbxE=; b=sY9HJYz6tac5HR4okz6v
        uWMGWg6pdHWZd8DGh58Hfzqon5tEitu8rt3wsSOOCRKdgdSYbeaqbeXo4zd3ldcv
        EFQZEFHR+x0Mlhj21Ex+XD/dDYqkIfydII45usFrHlgT4kNReYlduI8VL+14f94X
        eGSK+PZmUkah14dxk1eS2l4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA5DE1350AE;
        Thu, 24 Jan 2019 16:45:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=mesmtp; bh=Qiu1Vb1LurDAmrkn30N2ahlVuKUHjXpybEzEwIU/FOo=;
 b=UH8r9M5im3FxsyEsQYa/dl7TuibEdluwmu4i9uyrAdBtTYtiB5wXqpXw2qZpxyvLA90gWRGvTykkcUZvDG5sbe4BCy8uBkXRZHZ14T1I4NWNZS5657pIHwys3a26L2+vefnkGZAtc09FuNWForKNW9gCAROE5vXeqH9bK8WnzHo=
Received: from hylob.local (unknown [74.215.108.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 51D5F1350AD;
        Thu, 24 Jan 2019 16:45:31 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] init docs: correct a punctuation typo
Date:   Thu, 24 Jan 2019 16:44:16 -0500
Message-Id: <20190124214416.19924-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Pobox-Relay-ID: 5F2A0AFE-2021-11E9-8B70-84B4F54BB12D-24757444!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/git-init.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 057076ca38..32880aafb0 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -128,7 +128,7 @@ The template directory will be one of the following (=
in order):
 The default template directory includes some directory structure, sugges=
ted
 "exclude patterns" (see linkgit:gitignore[5]), and sample hook files.
=20
-The sample hooks are all disabled by default, To enable one of the
+The sample hooks are all disabled by default. To enable one of the
 sample hooks rename it by removing its `.sample` suffix.
=20
 See linkgit:githooks[5] for more general info on hook execution.
--=20
2.20.1

