Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB05F20248
	for <e@80x24.org>; Wed, 10 Apr 2019 15:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfDJP3I (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 11:29:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53160 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbfDJP3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 11:29:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28B8E58DA8;
        Wed, 10 Apr 2019 11:29:06 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=o8ettSnByU03Blv9zpOPJBsg8+M=; b=BxurEUP+b/ImNSwc6BQl
        Fk1D6ldy26SHMcBEG+rS0hRRFmb4NPbgal5pc/2U7z6XQzn3TOoh8ZVhwHJOOjB/
        NCuI7tVVB6PmFy9PchxVZDi+cdmz1vKR7xz/wpaQh4QGyaCVlFl5KuZCTn0LWK7d
        qwQdUqBYc060dAFIOBFJa9g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 207E958DA7;
        Wed, 10 Apr 2019 11:29:06 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding;
 s=mesmtp; bh=XMGlIe8SX1a7AVSI+PY6d7F3H9aP1Cdk/KRWGzz9dLs=;
 b=kjTZC3QUlE6os4yZ5oixRXmGYPhSwVOYRKutYxAlAU23fWvlnsHVsyfBuLpR2acZ34sE9EcR9REgVhTNRqR0uijwwNhStFkqbTiPzA2KlTeaow7jeIRWsYIawXQm8QT1WZODp2852bszmE/K0iO4sG7/Mbbs9gjvrRsKvqWOhM0=
Received: from hylob.dartmouth.edu (unknown [129.170.31.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 681F758DA5;
        Wed, 10 Apr 2019 11:29:03 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] t3000 (ls-files -o): widen description to reflect current tests
Date:   Wed, 10 Apr 2019 11:28:57 -0400
Message-Id: <20190410152857.16368-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Pobox-Relay-ID: 5F2B0C46-5BA5-11E9-BA61-EE24A11ADF13-24757444!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the mention of symlinks from the test description because
several tests that are not related to symlinks have been added since
this file was introduced long ago.

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 t/t3000-ls-files-others.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
index afd4756134..0aefadacb0 100755
--- a/t/t3000-ls-files-others.sh
+++ b/t/t3000-ls-files-others.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano
 #
=20
-test_description=3D'git ls-files test (--others should pick up symlinks)=
.
+test_description=3D'basic tests for ls-files --others
=20
 This test runs git ls-files --others with the following on the
 filesystem.
--=20
2.21.0

