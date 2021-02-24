Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4865C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF7764E20
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 20:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbhBXU1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:27:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52184 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbhBXU1d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 15:27:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A691112B8F;
        Wed, 24 Feb 2021 15:26:53 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=XwvXZbg4Eq7tpwDf6pdAiZg1k
        ig=; b=OApjQF/FE1IuQvIABD1KzdmtYRquNlW3c8WkwJjlwLpv3Y//j78ImFX6M
        emS95ZNv0Zs7LMhZy+FUK1TvQjWNn6QpCBPH/0H+fWbUL01wizRUGIA9iDBw7CMr
        sHzPXrVC9ovIU/XQLY7zEJg8/T0Gda3haEK97EmPB5iHrqFiYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=wXMTIDBiMpU1vcRVz+Z
        Hokl7c3ptgz9w5JxaogD2qgXAJ5k5YomX+ZNA5cgqU2u9en722DSqEEuk1dB6Nxm
        vz2pUGfjWI6nMEsPapNnABwyjZqLHCiZlagPvNQSlGfOYRhU1PmH9QT5NfhKI7+8
        HPakXVU4bDhhQwI6/Vid+lHE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 833E8112B8E;
        Wed, 24 Feb 2021 15:26:53 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9B59112B8D;
        Wed, 24 Feb 2021 15:26:50 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 2/3] blame-options.txt: camelcase blame.blankBoundary
Date:   Wed, 24 Feb 2021 12:26:40 -0800
Message-Id: <20210224202641.913770-3-gitster@pobox.com>
X-Mailer: git-send-email 2.30.1-826-g07a034c5ea
In-Reply-To: <20210224202641.913770-1-gitster@pobox.com>
References: <xmqqlfbe1sim.fsf@gitster.g>
 <20210224202641.913770-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: A0416260-76DE-11EB-AB08-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All other references to blame.* configuration variables are
camelCased already.  Update this one to match.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/blame-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-option=
s.txt
index dc3bceb6d1..117f4cf806 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -1,6 +1,6 @@
 -b::
 	Show blank SHA-1 for boundary commits.  This can also
-	be controlled via the `blame.blankboundary` config option.
+	be controlled via the `blame.blankBoundary` config option.
=20
 --root::
 	Do not treat root commits as boundaries.  This can also be
--=20
2.30.1-826-g07a034c5ea

