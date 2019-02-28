Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28BC620248
	for <e@80x24.org>; Thu, 28 Feb 2019 02:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfB1CnZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 21:43:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60691 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfB1CnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 21:43:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3192614BCD9;
        Wed, 27 Feb 2019 21:43:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=eBSKnTe3985kiHD0JxTfqx2BUr0=; b=COOM3CgaBX22Xi+kKzM2
        tAHbpiQp+OdQQguGYNWbZ2+UQmWshvwghzQ2XRSCd8nNDqaxvaAaov4pZ2o9wPtZ
        qhHWAI3lcWwCzDmDDqmazq/ETzjHZ281YI4KAnoY9i2MJhsnz6HH67pF7Evty0M+
        TPyw/WYTBLfXGQO10aGOFRU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2814614BCD8;
        Wed, 27 Feb 2019 21:43:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=mesmtp; bh=pz3753JoyaI4Ln7Ca3HXMAlykQLK1PqVo0d1V/P9TeM=;
 b=m9EQfKvLECIQX06xsvXpC44a8t2hWDv9onniTZHDuLGJ3VmQeZMBf0A+3Cf3CQShZGajzYBfM+1keqmbIAsJJOzbPpvMOGS+hfx7k8mkbWToMqiCMD5US4DwFPSkMiKNi2fyMDadH+L+Gw0FTSb6rPnbPcYuyCmYnetB4UWJlVU=
Received: from hylob.local (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 968B814BCD7;
        Wed, 27 Feb 2019 21:43:20 -0500 (EST)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] rebase docs: fix "gitlink" typo
Date:   Wed, 27 Feb 2019 21:43:15 -0500
Message-Id: <20190228024315.1470303-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Pobox-Relay-ID: 9C20495E-3B02-11E9-9B4B-F733E42159A7-24757444!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change it to "linkgit" so that the reference is properly rendered.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 5629ba4c5d..6363d674b7 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -410,7 +410,7 @@ See also INCOMPATIBLE OPTIONS below.
 +
 By default, or when `no-rebase-cousins` was specified, commits which do =
not
 have `<upstream>` as direct ancestor will keep their original branch poi=
nt,
-i.e. commits that would be excluded by gitlink:git-log[1]'s
+i.e. commits that would be excluded by linkgit:git-log[1]'s
 `--ancestry-path` option will keep their original ancestry by default. I=
f
 the `rebase-cousins` mode is turned on, such commits are instead rebased
 onto `<upstream>` (or `<onto>`, if specified).
--=20
2.21.0

