Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 600AB1FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 21:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbcHNVql (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 17:46:41 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:19368 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbcHNVqk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 17:46:40 -0400
Received: from localhost.localdomain ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z3Esb3wiWcpskZ3EsbC7Dq; Sun, 14 Aug 2016 22:46:38 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=qkUL9DzVN51l37rgSWIA:9
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Subject: [PATCH v1 0/3] fixup fixup documenation
Date:	Sun, 14 Aug 2016 22:46:27 +0100
Message-Id: <20160814214630.1312-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
X-CMAE-Envelope: MS4wfFNaQgEfLn0EosU/kZv+yloddG/YMxPnpJbz9q9heeCk4EwxnDyGdFo5y5TINGq0pCDFpzwkvmLbSbywEJc2UBH4TTHMbyA6wJo+yfUw+JfrCyGhkr/a
 spy1j42MxGbRC93r+dWYMlDDt7vhd6lwsfSVh7+zo7xwcmJjc6y6GLP2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

With the review of the list's workflow, and failings in my personal
workflow, I asked a couple of questions about fixup and discovered
that my reading of the man pages hadn't provided the illumination
they hope to give. 

Here's three little documenation patches, and some queries to go
with them.

Philip Oakley (3):
  doc: commit: --fixup/--squash can take a commit revision
  doc: rebase: fixup! can take an object name
  doc: rebase: clarify fixup! fixup! constraint

 Documentation/git-commit.txt | 8 ++++----
 Documentation/git-rebase.txt | 9 +++++----
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.9.0.windows.1

