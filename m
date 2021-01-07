Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DC4C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 23:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E154D2368A
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 23:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbhAGXix (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 18:38:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51067 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAGXix (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 18:38:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91F7B8D64B;
        Thu,  7 Jan 2021 18:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8ZkhAHwPRM1rZipqaLzJpsFzbM8=; b=VFEyeE
        m2ixitYEgk1G84qBWRP7FU00Bt3lc4fvs3NQieSiAJSVRWQcWhUBpF+JGcrsY5LE
        UUQsDZVZLvM9GcPaX2lSYM0tY9Aqw3Oo5INlfDAeByBpW8YAMzj5dGkcXMXYakHv
        RsZtR4H9Mieo4NKHuLQMob/5KsLJa5nheTF3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IMW98CEfXmBc29s/O1rmk4sbL4Q1HN1t
        1T9C39A/zpr1FEpz8ShcaPFePmWSUx2dyzTIScZyjYXVHDYkvIvgUGE4gJug8KH0
        VdLuL+6ksgLP8zuXlLC/Nw97a/Q1+DTpnM3oga7UMBqsjXQqtHX/VpTEFb0aaAuA
        Ya08UzWqKTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B2898D64A;
        Thu,  7 Jan 2021 18:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23F428D649;
        Thu,  7 Jan 2021 18:38:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] SubmittingPatches: tighten wording on "sign-off" procedure
References: <xmqqh7o6jjt1.fsf@gitster.c.googlers.com>
Date:   Thu, 07 Jan 2021 15:38:09 -0800
In-Reply-To: <xmqqh7o6jjt1.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 28 Dec 2020 02:39:54 -0800")
Message-ID: <xmqqim88jp26.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66A2CADE-5141-11EB-B53D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The text says "if you can certify DCO then you add a Signed-off-by
trailer".  But it does not say anything about people who cannot or
do not want to certify.  A natural reading may be that if you do not
certify, you must not add the trailer, but it shouldn't hurt to be
overly explicit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d12094bac5..0452db2e67 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -307,7 +307,7 @@ wrote the patch or have the right to pass it on under the same license
 as ours, by "signing off" your patch.  Without sign-off, we cannot
 accept your patches.
 
-If you can certify the below D-C-O:
+If (and only if) you certify the below D-C-O:
 
 [[dco]]
 .Developer's Certificate of Origin 1.1
-- 
2.30.0-274-g31e3a2ed96

