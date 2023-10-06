Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A61E94139
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjJFW5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjJFW5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:57:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA429F7
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:57:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F3C111B9B1C;
        Fri,  6 Oct 2023 18:57:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=5
        9TrKDE5lm43v+xIik97PoPdkuseSIbHgsf2xKqzaR0=; b=Xsb+YPqLH8kpn40e/
        m7QRD6SW3I9MQGgH9BsaeTkSit46Cn9VjmEf9MZJEW2bee2fcYs/sM33+RExKuiM
        zA4EF+fWHDEblntwrlNYSrIjcTHIGjen9LGTF54MK/n/ViF6WdseQhGTekb1D/8S
        EC6aUpqpdWR31GkKtNGfOGAUwI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB8FF1B9B1B;
        Fri,  6 Oct 2023 18:57:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0A1C1B9B1A;
        Fri,  6 Oct 2023 18:57:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] doc: update list archive reference to use lore.kernel.org
Date:   Fri, 06 Oct 2023 15:57:03 -0700
Message-ID: <xmqq7cnz741s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB298CB8-649B-11EE-B584-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No disrespect to other mailing list archives, but the local part of
their URLs will become pretty much meaningless once the archives go
out of service, and we learned the lesson hard way when $gmane
stopped serving.

Let's point into https://lore.kernel.org/ for an article that can be
found there, because the local part of the URL has the Message-Id:
that can be used to find the same message in other archives, even if
lore goes down.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/CodingGuidelines | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 65af8d82ce..71afc5b259 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -24,7 +24,7 @@ code.  For Git in general, a few rough rules are:
 
    "Once it _is_ in the tree, it's not really worth the patch noise to
    go and fix it up."
-   Cf. http://lkml.iu.edu/hypermail/linux/kernel/1001.3/01069.html
+   Cf. https://lore.kernel.org/all/20100126160632.3bdbe172.akpm@linux-foundation.org/
 
  - Log messages to explain your changes are as important as the
    changes themselves.  Clearly written code and in-code comments
-- 
2.42.0-325-g3a06386e31

