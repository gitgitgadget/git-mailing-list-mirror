Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8997C1FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 03:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdJFDPG (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 23:15:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64864 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751440AbdJFDPF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 23:15:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 086179A38A;
        Thu,  5 Oct 2017 23:15:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to; s=sasl; bh=Scuk8ys92EodGMk
        WBNQ8gl0xP4g=; b=Z4Lsgs8RkNVuXAyEe2etGVZr+Dyhk8Yw4QGiNpKlDs3sqtp
        /RwePABfuK+k931ZaPM7HJKQrBo/obJyKSuCaNuLjAHREzGmW1DSlKuNYh97Eg+z
        noy0mB3iwbcGd579/gro78WJRbQZdUVx8bKOuzpHEtMD42C4BrYThrNIfnVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to; q=dns; s=sasl; b=Hplz+utaO
        utjzM7vahWVn/LxFuAZolxC8aDopZNHADCYywz6Pxjn2qit9a0T4nYOS17L+dNa1
        gb7Dcm2V0XZT0tpFTeD/wb+NhqvKvfY4HZ+ffzm4nASaGkveUb6c1Vil/F092F8m
        jeWXWWcf6tzACMSwet/G5yYlow+wtN6Um4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E67469A388;
        Thu,  5 Oct 2017 23:15:04 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.94.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DFDB9A382;
        Thu,  5 Oct 2017 23:15:04 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v2] api-argv-array.txt: Remove broken link to string-list API
Date:   Thu,  5 Oct 2017 23:14:56 -0400
Message-Id: <20171006031456.9632-1-tmz@pobox.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <xmqq4lrdyp8v.fsf@gitster.mtv.corp.google.com>
X-Pobox-Relay-ID: 8C0A9FE2-AA44-11E7-B2B5-8EF31968708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4f665f2cf3 (string-list.h: move documentation from Documentation/api/
into header, 2017-09-26) the string-list API documentation was moved to
string-list.h.  The argv-array API documentation may follow a similar
course in the future.  Until then, prevent the broken link from making
it to the end-user documentation.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
Junio C Hamano wrote:
> Probably removing the link is the right thing to do.

Excellent.  Thank you for detailing the likely progression as well as
the preferred solution.

 Documentation/technical/api-argv-array.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index cfc063018c..870c8edbfb 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -8,7 +8,7 @@ always NULL-terminated at the element pointed to by `argv[argc]`. This
 makes the result suitable for passing to functions expecting to receive
 argv from main(), or the link:api-run-command.html[run-command API].
 
-The link:api-string-list.html[string-list API] is similar, but cannot be
+The string-list API (documented in string-list.h) is similar, but cannot be
 used for these purposes; instead of storing a straight string pointer,
 it contains an item structure with a `util` field that is not compatible
 with the traditional argv interface.
-- 
2.15.0.rc0

