Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD0C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 18:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJGSJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJGSJl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 14:09:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02126CC82A
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 11:09:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 407B31B68BB;
        Fri,  7 Oct 2022 14:07:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=x
        gZi4gaZ4AP1qnJAGdFfnhqf5jPumS2IN4DEhyMPI3w=; b=QPhzuyeOCNKNM16C8
        Q38MKXc3bxgmrwRtdIKp3WLQoqz1MWogTY/yF4ncjZkEZJVNMHlk4R70f+3GMXH1
        Ufg/+xcgdHOAjjV8Kl2Sk5TPtLzacz4Yr4SZwSg9r/Jc9vb+k8V0N2EsSvUGRkSI
        fJK44LbdeEzrxz46WfuznUPoSk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3971B1B68BA;
        Fri,  7 Oct 2022 14:07:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46AE91B68B9;
        Fri,  7 Oct 2022 14:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] SubmittingPatches: use usual capitalization in the log
 message body
Date:   Fri, 07 Oct 2022 11:07:54 -0700
Message-ID: <xmqqedvjfqx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F79C2D94-466A-11ED-AFFB-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the description of the summary section to clarify that the
"do not capitalize" rule applies only the word after the "<area>:"
prefix of the title and nowhere else.  This hopefully will prevent
folks from writing their proposed log message in all lowercase.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 5bd795e5db..927f7329a5 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -153,7 +153,9 @@ files you are modifying to see the current conventions.
 
 [[summary-section]]
 The title sentence after the "area:" prefix omits the full stop at the
-end, and its first word is not capitalized unless there is a reason to
+end, and its first word is not capitalized (the omission
+of capitalization applies only to the word after the "area:"
+prefix of the title) unless there is a reason to
 capitalize it other than because it is the first word in the sentence.
 E.g. "doc: clarify...", not "doc: Clarify...", or "githooks.txt:
 improve...", not "githooks.txt: Improve...".  But "refs: HEAD is also
