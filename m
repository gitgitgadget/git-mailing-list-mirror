Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303401FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 21:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdJEVMw (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 17:12:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59710 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751381AbdJEVMv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 17:12:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC122A2342;
        Thu,  5 Oct 2017 17:12:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=vb97T9aPMunqiE8gxp9P1tH9bTw
        =; b=l4Dfbbt941NrBIwWy3Ft3wTEsVcFU+e2ttbd3n9iVCncNVWg8MH2/yiJ6PD
        Cl1U4Ydvy+MzX1EvbpHaTF6kzOKqYT7MI1LVNopNEk0sK3eIxq659aBbdhTI71rk
        vB0yZXr5s3gkvWsYEZbbrhIkH9hQs/fulwYli7PEScSqAKdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id; q=dns; s=sasl; b=jY4ZaTu4ZEtiMROtkzy/+
        a4Yhhu8YYSXLgBPOt2WdfR5SM7QhdirwD68LqZzx6LeQZpLMRej/zNHPIBIS/90h
        RpBtyjgyyGVw3uuCnX27kopvrooMXTQ1v8J8q95Rb/oqZmMIMP1Zw7lwUdnOdlDf
        Pby4tiLZoILeqI1nEHOCc4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0AA1A2341;
        Thu,  5 Oct 2017 17:12:50 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2ADDBA2340;
        Thu,  5 Oct 2017 17:12:50 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH] api-argv-array.txt: Update link to string-list API
Date:   Thu,  5 Oct 2017 17:12:03 -0400
Message-Id: <20171005211203.11913-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0.rc0
X-Pobox-Relay-ID: F19C1B20-AA11-11E7-90CD-575F0C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4f665f2cf3 (string-list.h: move documentation from Documentation/api/
into header, 2017-09-26) the string-list API documentation was moved
into string-list.h.  Fix the link from the argv-array API documentation.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Hi,

I noticed this broken link in the html documentation while building
2.15.0-rc0.  I'm not sure whether it's better to point the link to the
string-list.h file on Git Hub, remove the link, or drop the entire
paragraph.

The change I made to remove the link was simply:

-The link:api-string-list.html[string-list API] is similar, but cannot be
+The string-list API (documented in string-list.h) is similar, but cannot be

 Documentation/technical/api-argv-array.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index cfc063018c..1603f4a941 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -8,7 +8,7 @@ always NULL-terminated at the element pointed to by `argv[argc]`. This
 makes the result suitable for passing to functions expecting to receive
 argv from main(), or the link:api-run-command.html[run-command API].
 
-The link:api-string-list.html[string-list API] is similar, but cannot be
+The https://raw.githubusercontent.com/git/git/master/string-list.h[string-list API] is similar, but cannot be
 used for these purposes; instead of storing a straight string pointer,
 it contains an item structure with a `util` field that is not compatible
 with the traditional argv interface.
-- 
2.14.2

