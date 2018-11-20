Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF281F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 18:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeKUEfW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 23:35:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58201 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeKUEfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 23:35:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AD6B12AA5F;
        Tue, 20 Nov 2018 13:04:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=WOu+xBjcjSXjk5C3i4XPXPvSfKI=; b=N+jV2IjYRmT9jwb4RHpa
        39u8ngEeKTPA+mADFtmQvIzNwFLglw2z3vOHvTC6IWJmIdR1+fuOG4sHCI4Qozth
        cSBq2A/rcy/ORi2Grrik4w/pF8655p4B0MKXoHxXqH1wx8NQ/9VNrqfq1reRrPCb
        AzAxmAlF/oPyt2wQAPoogXc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         q=dns; s=sasl; b=xptkJDAdPuS8mDUqzOsfSDilVEhC0ALo6+tZ1pK+Ne9iQE
        B6kmzsZWFlbP8L4FUonzgwcMiHJzz+joYW7Hx6O6htzjrKigDrOcGQdWHX6RwmI1
        fo20sWC2Bqc+p6PviHTqsHWr0BCSVA0sqU/HcgaWah2wxbbbh6pZOh8P1YZOQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9155712AA5E;
        Tue, 20 Nov 2018 13:04:57 -0500 (EST)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.85.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E02F312AA5C;
        Tue, 20 Nov 2018 13:04:56 -0500 (EST)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH] Documentation: build technical/multi-pack-index
Date:   Tue, 20 Nov 2018 13:04:54 -0500
Message-Id: <20181120180454.16181-1-tmz@pobox.com>
X-Mailer: git-send-email 2.20.0.rc0
MIME-Version: 1.0
X-Pobox-Relay-ID: CA083C26-ECEE-11E8-9F0B-BFB3E64BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-multi-pack-index doc links to technical/multi-pack-index.html.
Ensure it is built to prevent a broken link.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
While building 2.20.0-rc0 I noticed the broken link from
git-multi-pack-index to technical/multi-pack-index.html.

 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 48d261dc2c..d5d936e6a7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -73,6 +73,7 @@ TECH_DOCS +=3D technical/hash-function-transition
 TECH_DOCS +=3D technical/http-protocol
 TECH_DOCS +=3D technical/index-format
 TECH_DOCS +=3D technical/long-running-process-protocol
+TECH_DOCS +=3D technical/multi-pack-index
 TECH_DOCS +=3D technical/pack-format
 TECH_DOCS +=3D technical/pack-heuristics
 TECH_DOCS +=3D technical/pack-protocol
--=20
2.19.1

