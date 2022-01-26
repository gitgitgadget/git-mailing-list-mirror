Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73577C433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 23:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiAZXmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 18:42:17 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62835 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiAZXmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 18:42:16 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FA68179584;
        Wed, 26 Jan 2022 18:42:15 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=ySNTZM05VGhw/fv3BQtzh3m2g
        JuIQ+l2vmcYIut+Eu4=; b=SvHDT9h1wJrfEyTXmA3SVrCY2TUfiaQUAF8PePAJz
        Ku7DLnbjs1aE/1SKwc7o8PVjW0HQP7G/NEt51zyJegF9I38VEnp7aUAjY6zTTjYU
        ez7RkJG9/6VQxGgr5RDfq9BkhJ7wHELADMCasA/ASTC0HWegdxSAMUwnePuf8ggG
        To=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 093C9179583;
        Wed, 26 Jan 2022 18:42:15 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 753BF179582;
        Wed, 26 Jan 2022 18:42:12 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/3] CodingGuidelines: hint why we value clearly written log messages
Date:   Wed, 26 Jan 2022 15:42:04 -0800
Message-Id: <20220126234205.2923388-3-gitster@pobox.com>
X-Mailer: git-send-email 2.35.0-168-gb86c5231e1
In-Reply-To: <20220126234205.2923388-1-gitster@pobox.com>
References: <xmqqilua89z5.fsf@gitster.g>
 <20220126234205.2923388-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 95B3D694-7F01-11EC-A150-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
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
index 0e27b5395d..5f40595f6e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -26,6 +26,13 @@ code.  For Git in general, a few rough rules are:
    go and fix it up."
    Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
=20
+ - Log messages to explain your changes are as much important as the
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
2.35.0-155-g0eb5153edc

