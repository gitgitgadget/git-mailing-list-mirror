Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DEEC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 03:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiCGDq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Mar 2022 22:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiCGDqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Mar 2022 22:46:22 -0500
Received: from box.jasonyundt.email (box.jasonyundt.email [206.189.182.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8BD5D5CB
        for <git@vger.kernel.org>; Sun,  6 Mar 2022 19:45:28 -0800 (PST)
Received: from authenticated-user (box.jasonyundt.email [206.189.182.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.jasonyundt.email (Postfix) with ESMTPSA id E2B3F7EA70;
        Sun,  6 Mar 2022 22:37:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jasonyundt.email;
        s=mail; t=1646624262;
        bh=SzG6NtlVAPEM+254YR2XaRaODvoawJAa2ILvcRMYcpA=;
        h=From:To:Cc:Subject:Date:From;
        b=KpRod2PytQmD51M1pN2kVXY7FhorXsInMq5SqwIFZvQTkXLFOT1PTrXpo6Fon+/Pc
         5rJmtRjqaec4vCbQPvbDyvqDj+bc60SxlDdGuWVtFptQoIsWvMCRtr7M/6H+4tDZw8
         NqHcKiAlowdnOPVYibVukvpftfD+NuZap3vN6ebQf48GkEb+i8agqrAAraLgkxMggP
         pM6eKGOfeb9QQtwkmnYUATGdoOHsy/yZuEGJDl+rt5gJQ+Vy6VZTdMVD9hv33fZq0b
         l2e4ARSsSVJJ+h3Zc9wzCusHIjy3D6ivapH2N3NfBG3GJUncqST2o0PKyq84hJntKF
         xAw49eyfHXlWA==
From:   Jason Yundt <jason@jasonyundt.email>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jason Yundt <jason@jasonyundt.email>
Subject: [PATCH 0/2] gitweb: remove invalid http-equiv="content-type"
Date:   Sun,  6 Mar 2022 22:37:21 -0500
Message-Id: <20220307033723.175553-1-jason@jasonyundt.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the second commit's message for more details.

Jason Yundt (2):
  comment: fix typo
  gitweb: remove invalid http-equiv="content-type"

 gitweb/gitweb.perl                        |  4 +---
 t/t9502-gitweb-standalone-parse-output.sh | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.35.1

