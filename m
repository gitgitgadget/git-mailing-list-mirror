Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDDEC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240951AbiCaTq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbiCaTq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:46:57 -0400
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50971E5A47
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:45:06 -0700 (PDT)
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=PTpFj7KxnoQhMsy+ZtIqqLrEv7XfEhLXrzOlXJndSua73hhuZqGtlYqHeCdJdSbcJPx4cGWtF0L/op5gidjyQuwzDyvv7MtAC1Hb3V7s7vxhiNftwymIvkK3vu1NVrbi8c11WXAsjt2yd0u2z5PSO2DDBTyEoaoewmogV3f7F+4DeIJpapyfbcz4yISzqa3gn0PHpggsQld8aqYzAsasr4WdhrHjM+LoIP6QnHuigxz29a/zW/oCQ2XZHb0+qflUFep+4EzKxQCXHAZIPSdMWJ9QReG90cV7IJJ19h07qNYJNpS2LSzuoZwj9+juwGhO70fUzDkRORJUYE/bXJ3/Lw==; s=purelymail1; d=slashdev.space; v=1; bh=2pl0evYXhy+G44bQ/88+eVQ80eu0Srsw79VBeK2NBEw=; h=Received:From:To;
DKIM-Signature: a=rsa-sha256; b=FhZd58EbUDTJuSYc/8w2XeG4squH4Xsb1c9dnKZQb8wct9v8DBQBO7MXYedFL/nvcKbjuJmJ4Tt+y35+k2Ia4DnZJerCqPuKwAaXft54CAAPo/7jRaLLSdaEg/HD3uN1+VMQJBDG0/+xvsYd1AT37EcH6ts5BmaBgYTNWzLV2bKhEeAEqaB+rLv4qh0SXfI76OuVic7UlOw4SvkffQ4pTXx7Fl5/SGtGwdUFCYXrVAF7FfP+KMoEo9r5a8qyD2ZXn2dwIIYBsh8vJXvrTPZI4nIYz2ef1SkOfGrZZ6PO9nx1HNoZZKQULnNNctQFmrVZ5/jo+ZMfHZ8+CiHkgxpgqA==; s=purelymail1; d=purelymail.com; v=1; bh=2pl0evYXhy+G44bQ/88+eVQ80eu0Srsw79VBeK2NBEw=; h=Feedback-ID:Received:From:To;
Feedback-ID: 6471:1573:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -517397822;
          (version=TLSv1.2 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384);
          Thu, 31 Mar 2022 19:45:00 +0000 (UTC)
From:   Garrit Franke <garrit@slashdev.space>
To:     git@vger.kernel.org
Cc:     Garrit Franke <garrit@slashdev.space>
Subject: [PATCH] bisect.c: remove unused includes
Date:   Thu, 31 Mar 2022 21:44:36 +0200
Message-Id: <20220331194436.58005-1-garrit@slashdev.space>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=ANSI_X3.4-1968
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up includes no longer needed by bisect.c.

Signed-off-by: Garrit Franke <garrit@slashdev.space>
---
 bisect.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/bisect.c b/bisect.c
index 9e6a2b7f20..e07e2d215d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1,21 +1,12 @@
-#include "cache.h"
 #include "config.h"
-#include "commit.h"
-#include "diff.h"
-#include "revision.h"
 #include "refs.h"
 #include "list-objects.h"
 #include "quote.h"
-#include "hash-lookup.h"
 #include "run-command.h"
 #include "log-tree.h"
 #include "bisect.h"
-#include "oid-array.h"
-#include "strvec.h"
-#include "commit-slab.h"
 #include "commit-reach.h"
 #include "object-store.h"
-#include "dir.h"
=20
 static struct oid_array good_revs;
 static struct oid_array skipped_revs;
--=20
2.35.1

