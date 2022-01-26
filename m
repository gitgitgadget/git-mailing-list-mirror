Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F33EC433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 23:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiAZXmM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 18:42:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58346 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiAZXmM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 18:42:12 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DD96103ECF;
        Wed, 26 Jan 2022 18:42:11 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=gfcivo8vUxbiIUcuTKllSms8V
        jeOkW7NATG62jYZCrE=; b=yR6nco+4p5Iq/1APrLgTG4NagKRn+hWinT3ZcGaAU
        zOBH2ml2z+JB1gUmKgfQf2iw1IRnXpAG87MbelMnQ1C5mzxfYf2Pc96bWa8TPvdJ
        tblFS0GZ39F9lyhiMjkBRH06i9q/98T/tlKHxd1CmfJKBUTBytQQzO53RGARhDJq
        /Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7698A103ECD;
        Wed, 26 Jan 2022 18:42:11 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0CA7103ECC;
        Wed, 26 Jan 2022 18:42:10 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/3] SubmittingPatches: write problem statement in the log in the present tense
Date:   Wed, 26 Jan 2022 15:42:03 -0800
Message-Id: <20220126234205.2923388-2-gitster@pobox.com>
X-Mailer: git-send-email 2.35.0-168-gb86c5231e1
In-Reply-To: <20220126234205.2923388-1-gitster@pobox.com>
References: <xmqqilua89z5.fsf@gitster.g>
 <20220126234205.2923388-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 94C61346-7F01-11EC-96BE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We give a guidance for proposed log message to write problem
statement first, followed by the reasoning behind, and recipe for,
the solution.  Clarify that we describe the situation _before_ the
proposed patch is applied in the present tense (not in the past
tense e.g. "we used to do X, but thanks to this commit we now do Y")
for consistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
index 92b80d94d4..7225a0fb52 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -142,6 +142,13 @@ The body should provide a meaningful commit message,=
 which:
=20
 . alternate solutions considered but discarded, if any.
=20
+[[present-tense]]
+The problem statement that describes the status quo is written in the
+present tense.  Write "The code does X when it is given input Y",
+instead of "The code used to do Y when given input X".  You do not
+have to say "Currently"---the status quo in the problem statement is
+about the code _without_ your change, by project convention.
+
 [[imperative-mood]]
 Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
 instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
--=20
2.35.0-155-g0eb5153edc

