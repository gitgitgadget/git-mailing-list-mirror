Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF03C433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbiA0TDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:03:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64947 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiA0TDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:03:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2D081068B0;
        Thu, 27 Jan 2022 14:03:09 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=/ZK8YbWOYtH11EdsuC4RtQLjS
        4oxlnCutn5CNEidS/0=; b=kDQsKgYVrKeBzqAvbqn+u2nKEeJYj1giYhJNnkE/8
        jzKnC9Jkb9MHquVyjfcYLeVkxlbagS49mVgTiortN1CeHa7YY3rf+TGwZvQLGhuZ
        s0WMJPIpTXhye7tAwyERk5aEWcyuvFh4mQDLfvRJ18Z612Sp/XiGA9X0LGIgzEHQ
        kA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C3A41068AF;
        Thu, 27 Jan 2022 14:03:09 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 906861068AC;
        Thu, 27 Jan 2022 14:03:06 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 2/3] CodingGuidelines: hint why we value clearly written log messages
Date:   Thu, 27 Jan 2022 11:02:58 -0800
Message-Id: <20220127190259.2470753-3-gitster@pobox.com>
X-Mailer: git-send-email 2.35.0-177-g7d269f5170
In-Reply-To: <20220126234205.2923388-1-gitster@pobox.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C2CA604C-7FA3-11EC-B157-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index 0e27b5395d..c37c43186e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -26,6 +26,13 @@ code.  For Git in general, a few rough rules are:
    go and fix it up."
    Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
=20
+ - Log messages to explain your changes are as important as the
+   changes themselves.  Clearly written code and in-code comments
+   explain how the code works and what is assumed from the surrounding
+   context.  The log messages explain what the changes wanted to
+   achieve and why the changes were necessary (more on this in the
+   accompanying SubmittingPatches document).
+
 Make your code readable and sensible, and don't try to be clever.
=20
 As for more concrete guidelines, just imitate the existing code
--=20
2.35.0-177-g7d269f5170

