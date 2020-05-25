Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB43BC433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95931206C3
	for <git@archiver.kernel.org>; Mon, 25 May 2020 21:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbgEYVov (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 17:44:51 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:61133 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388279AbgEYVov (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 17:44:51 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 May 2020 17:44:50 EDT
Received: from localhost.localdomain ([89.243.191.101])
        by smtp.talktalk.net with SMTP
        id dKm0jC4AIIndsdKm0jhP2k; Mon, 25 May 2020 22:36:41 +0100
X-Originating-IP: [89.243.191.101]
X-Spam: 0
X-OAuthority: v=2.3 cv=QYIYQfTv c=1 sm=1 tr=0 a=5KGm1Kp77X3djDixdaHiLg==:117
 a=5KGm1Kp77X3djDixdaHiLg==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=PKzvZo6CAAAA:8 a=QlQZUAzrdk9ouUhyZUQA:9 a=tBxIHIgKA4YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=q92HNjYiIAC_jH7JDaYf:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
From:   Philip Oakley <philipoakley@iee.email>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Paul Ganssle <paul@ganssle.io>, Jeff King <peff@peff.net>
Subject: [PATCH 0/2] Clarify some of the fixup! documenation
Date:   Mon, 25 May 2020 22:36:30 +0100
Message-Id: <20200525213632.1626-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.26.2.windows.1.13.g9dddff6983
In-Reply-To: <9a9e7432-7a74-f46e-9a77-b8acaa9a974f@iee.email>
References: <9a9e7432-7a74-f46e-9a77-b8acaa9a974f@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPvfo84edlVVru6jFcucucps12gYOMusUar0/MVu2kqoF30RAgAMcv/RwYnsfF+3r4zSEYapKQPr7E+Sr/Hvk0JsdCjv9d+Iih0AoMhj3hJpHT0C/Q4/
 KU/g3bi+uObfGMaL1Nxslsc46nOkpJ0YGYVOZRkgHs7sxISIItKg/2mIw1+5CvB1bjyF7S/ggNNPQwu8DNb7n3e9LsEaEetmXChRamYcv0IiNG6V5iXel30m
 /mB5If5mT8kuWGSFaOywmN3bvEyXstNBNJfJAMU1r3dpVK8yCttr2uG/J6Cz9T2z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's easy to think that all fixup!  commit messages must match a
previous subject line based on commit's --fixup option. It had this
developer confused for many years.

Lets at least do a some small changes to make the use of the commit
hash in the fixup message more obvious.

Philip

In-Reply-To: 9a9e7432-7a74-f46e-9a77-b8acaa9a974f@iee.email
To: git@vger.kernel.org
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc: Andrei Rybak <rybak.a.v@gmail.com>
cc: Paul Ganssle <paul@ganssle.io>
cc: Jeff King <peff@peff.net>


Philip Oakley (2):
  doc: fixup/squash: clarify use of <oid-hash> in subject line
  doc: fixup/squash: remove ellipsis marks, use <line> for clarify

 Documentation/git-rebase.txt | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.26.2.windows.1.13.g9dddff6983

