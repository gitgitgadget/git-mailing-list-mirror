Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9FD20179
	for <e@80x24.org>; Thu, 30 Jun 2016 20:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbcF3UlW (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 16:41:22 -0400
Received: from smtp-d-6.talktalk.net ([78.144.6.134]:36975 "EHLO
	smtp-d-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbcF3UlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 16:41:19 -0400
Received: from localhost.localdomain ([2.96.205.30])
	by smtp.talktalk.net with SMTP
	id IiWUbMHWfgKstIiWUbS4FS; Thu, 30 Jun 2016 21:25:19 +0100
X-Originating-IP: [2.96.205.30]
X-Spam:	0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=QTrtdgWXx+RZbj7kV87ZQA==:117
 a=QTrtdgWXx+RZbj7kV87ZQA==:17 a=FqmO25z5HV8n3wyg-FAA:9
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/4] Name for A..B ranges?
Date:	Thu, 30 Jun 2016 21:25:05 +0100
Message-Id: <20160630202509.4472-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160625164654.5192-1-philipoakley@iee.org>
References: <20160625164654.5192-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfGay74BJ6NxrQRIaQN0ICKAishAQIEJfsIf1DeE1TyPLVigAAxrsYBDvQPywbzDi2qMblB7go0KazU816RAFvY0GaSqWXh+1ABntPcGB/43ttRCiAf7E
 MAuDwW6QgG3Dy/2wcQvMTFlg32b/bV/6GPcY5mD0bb2NVV+kB9ANWTiqBpJ7ow56skGZI8kIiPHaWXvFyqYN22MvJrlbKM9kvilkcO+Y7avZuY/5Mdiiobhk
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the re-roll of the po/range-doc (2016-06-27) 3 commits

The order is slightly re-arranged, and an additional patch clarifying
that ^r1 excludes r1 itself being added.

The heading have been tweaked.

Discussion: $gmane/297908
previous patch series $gmane/298223

Philip Oakley (4):
  doc: use 'symmetric difference' consistently
  doc: show the actual left, right, and boundary marks
  doc: give headings for the two and three dot notations
  doc: clarify that `^r1` will exclude `r1` itself

 Documentation/gitk.txt             |  2 +-
 Documentation/pretty-formats.txt   |  2 +-
 Documentation/rev-list-options.txt |  4 ++--
 Documentation/revisions.txt        | 25 ++++++++++++++++++-------
 4 files changed, 22 insertions(+), 11 deletions(-)

-- 
2.8.4.windows.1.3.ge328a54

