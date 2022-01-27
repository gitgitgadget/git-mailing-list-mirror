Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA877C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbiA0TDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:03:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58488 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245167AbiA0TDF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:03:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB88C17FA05;
        Thu, 27 Jan 2022 14:03:04 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=8WDD9xr0IUslGJmf/0Pc7oJDz
        24fglo6GtsOmluKvxU=; b=pbEYbTMJbuga3cKQP4Qfinprxq9Vbq/gC1AQsHK6q
        ubdF4N4VcFFQH7sCl2nmPe5zsOr6W8nFHrIN4tDU+zJTk1aSJaSnHKowpHDXLV5k
        MY6Zz/VYsy/X2sm961omgQ6cCtr9Qt0Q2yFm8oMRldjDhBYZQbTt+tWIPtTXg0TR
        iQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C46EB17FA04;
        Thu, 27 Jan 2022 14:03:04 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3FF0217FA02;
        Thu, 27 Jan 2022 14:03:02 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v3 1/3] SubmittingPatches: write problem statement in the log in the present tense
Date:   Thu, 27 Jan 2022 11:02:57 -0800
Message-Id: <20220127190259.2470753-2-gitster@pobox.com>
X-Mailer: git-send-email 2.35.0-177-g7d269f5170
In-Reply-To: <20220126234205.2923388-1-gitster@pobox.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: C0356354-7FA3-11EC-B456-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
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
2.35.0-177-g7d269f5170

