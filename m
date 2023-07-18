Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB978EB64DC
	for <git@archiver.kernel.org>; Tue, 18 Jul 2023 17:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjGRRsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jul 2023 13:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGRRsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2023 13:48:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34FC0
        for <git@vger.kernel.org>; Tue, 18 Jul 2023 10:47:45 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B13C63458F;
        Tue, 18 Jul 2023 13:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=n
        yeKaZI3fxlmT67qdPJR8xSqcpamgekncFaGT/+mxD4=; b=acKvWwTCzIvtq9URq
        /8ITP9w7ePyU6dXmeu2CCa1UBAR63oojHcNGh0kFwh+5WGpUNRST3lX6UMJZ1Gr3
        WRWv+lYryXAbj972ITLCnIgzNPuRkkQWk57Zjt5qTZTFUuMsDdP7BHAxLXtzdkBw
        cr7v0rX/F/cdWiGzp3SxSn6+qQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D6B23458E;
        Tue, 18 Jul 2023 13:47:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A0273458C;
        Tue, 18 Jul 2023 13:47:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] gitignore.txt: mark up explanation of patterns consistently
Date:   Tue, 18 Jul 2023 10:47:39 -0700
Message-ID: <xmqqwmyxglhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3137E932-2593-11EE-B37C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the "PATTERN FORMAT" section, all the other pattern elements are
shown as `monospace` literals inside "double quoted" strings.  Do
the same for the explanation of a slash to make it consistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitignore.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 4c17f2356c..bf2d823c94 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -88,7 +88,7 @@ PATTERN FORMAT
    Put a backslash ("`\`") in front of the first "`!`" for patterns
    that begin with a literal "`!`", for example, "`\!important!.txt`".
 
- - The slash '/' is used as the directory separator. Separators may
+ - The slash "`/`" is used as the directory separator. Separators may
    occur at the beginning, middle or end of the `.gitignore` search pattern.
 
  - If there is a separator at the beginning or middle (or both) of the
-- 
2.41.0-376-gcba07a324d

