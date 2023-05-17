Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F14C7EE24
	for <git@archiver.kernel.org>; Wed, 17 May 2023 02:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjEQC4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 22:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjEQC4p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 22:56:45 -0400
X-Greylist: delayed 270 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 19:56:44 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FD64EC3
        for <git@vger.kernel.org>; Tue, 16 May 2023 19:56:44 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 893051924DD;
        Tue, 16 May 2023 22:52:12 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=CSmibykE6VSf4HvK8H/9qCAuNZal75OfbWm8tPd3puw=; b=P9dK
        LK6dpnvXBoYz9M60mQ31P2vLOiXJQY5An8yIRXfmwwriMNJy1ABzKA2U/VnBagL0
        htU3FluUvoPp+uYVVpivqcfcaq32rHo91uqtzkmyrKiYEGmGCHoQqNWwGWriOM4Q
        kTFNP8FUNzPScH4PiTTJ8s+eC9Adepo2H66AyXs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 811551924DC;
        Tue, 16 May 2023 22:52:12 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE8C31924DB;
        Tue, 16 May 2023 22:52:11 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] RelNotes/2.41.0: trivial case change in WWW-Authenticate
Date:   Tue, 16 May 2023 22:51:48 -0400
Message-ID: <20230517025148.1199907-1-tmz@pobox.com>
X-Mailer: git-send-email 2.41.0.rc0
MIME-Version: 1.0
X-Pobox-Relay-ID: D286734C-F45D-11ED-8277-307A8E0A682E-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Readers may wonder whether the upper case 'U' has special meaning in
WWW-AUthenticate.  Use a lower case 'u' to save them from such thoughts.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
This caught my eye while reading the 2.41.0 release notes.  It's a long r=
ead
this time -- folks here have been busy.

Nothing else jumped out, but I'm not a professional proofreader. ;)

Thanks!

Todd

 Documentation/RelNotes/2.41.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.41.0.txt b/Documentation/RelNotes/2=
.41.0.txt
index e177aff2d0..2bbf8fdc53 100644
--- a/Documentation/RelNotes/2.41.0.txt
+++ b/Documentation/RelNotes/2.41.0.txt
@@ -3,7 +3,7 @@ Git v2.41 Release Notes
=20
 UI, Workflows & Features
=20
- * Allow information carried on the WWW-AUthenticate header to be
+ * Allow information carried on the WWW-Authenticate header to be
    passed to the credential helpers.
=20
  * A new "fetch.hideRefs" option can be used to exclude specified refs
--=20
2.41.0.rc0

