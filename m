Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B16DC47088
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 22:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiK0Wn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Nov 2022 17:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK0Wn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 17:43:27 -0500
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A9663EE
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 14:43:25 -0800 (PST)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1ozQMq-0004gs-IX; Sun, 27 Nov 2022 17:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
        references; bh=pqsOSKea/nRUb/uyy5d/nRfuF1khpDqSMWxbzSwAfA8=; b=iErCnT4gUibvPS
        dy03ieGT/ec69MWNbYk/Qf7KVd1kmUuoE0PlrfapI5gusjAR3qC8eGFfbRe6EF/Wh7JE0mxoBR3Gn
        JwXTbwFN5VhH14YzSMc4uXNZSWOEFLPW6H82Ue9+B/8tFDQxFhEL4N+thierX3lEfcW7rfFGXSCnE
        chwI8kgqz/EvHqRTYZ+08S1C2Q3IGJKJQZ2BZML//2Qb9asNoYDQcewycjphJxBNtrNWjbFNL12BN
        nHWX2aZme/bJU6d9NRp7T8LKmljE8luPspgPA6Jg9LL8V1AJnC1MpHEmC/PBUBCAK1w/rVy/n4rsw
        K8HemWBpP8b7HW6NL3Fg==;
Received: from pool-71-245-225-93.bstnma.fios.verizon.net ([71.245.225.93] helo=llin-psh13-dsa.internal.nuodb.com)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1ozQMp-0004HF-54; Sun, 27 Nov 2022 17:43:19 -0500
From:   Paul Smith <psmith@gnu.org>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [PATCH 0/1] Avoid multiple patterns when recipes generate one file
Date:   Sun, 27 Nov 2022 17:42:50 -0500
Message-Id: <20221127224251.2508200-1-psmith@gnu.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Needed for GNU make 4.4 or above.  This is backward-compatible with
all previous versions of GNU make.

I'm not sure if this should be considered a bug fix; I based it on
maint just in case.

Paul Smith (1):
  Avoid multiple patterns when recipes generate one file

 Documentation/Makefile | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)


base-commit: e7e5c6f715b2de7bea0d39c7d2ba887335b40aa0
-- 
2.35.3

