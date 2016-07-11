Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04E3E1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 20:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbcGKUZ2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 16:25:28 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:8443 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923AbcGKUZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 16:25:27 -0400
Received: from localhost.localdomain ([92.22.73.13])
	by smtp.talktalk.net with SMTP
	id MhlcbLEzMY8RwMhlcbR8lR; Mon, 11 Jul 2016 21:25:25 +0100
X-Originating-IP: [92.22.73.13]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=R5CpdR+gL2+IAQkTIkP0Ow==:117
 a=R5CpdR+gL2+IAQkTIkP0Ow==:17 a=xtxXYLxNAAAA:8 a=c7trA8--hQxIVeBfZrYA:9
 a=xts0dhWdiJbonKbuqhAr:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/8] Name for A..B ranges?
Date:	Mon, 11 Jul 2016 21:25:10 +0100
Message-Id: <20160711202518.532-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <20160630202509.4472-1-philipoakley@iee.org>
References: <20160630202509.4472-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfIQ0oaomVwL5ZsS+1F+KzY0YXX0CYZcIJOV4PDeauSzDjM8yebpjBlK+/uxRLbMvn/G+7DxYPbmKH6+Ejyu0sG4zS9KAQGms3facuhREso8TujcLbgEB
 wAuEYhJqWzjYzcler1NmdyuoCLYZkwu6Kfs+WwapxWVoSG7WdyFhmLNZ2isK/sb2/nDEENtI1lUJ+ayODgnpPkcAUJNR1JBuqds9b55mQ7aJK8eyJHh5UYmB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the re-roll of the po/range-doc (2016-07-01) 3 commits and its
follow on patch.

The series has gained additional patches following the discussions
($gmane/298790).

The original first 3 patches are unchanged, though 2/8 has been inserted
to name the Left and Right ranges.

The extra four patches carefully tease out the clarification of
reachability. Reachability is defined relative the ancestry chain thus
(hopefully) avoiding misunderstandings.

The final patch updates the summary examples, and the tricky (for the
untutored reader) two dots case of a linear development where r1..r2
excludes r1 itself.

The patches can be squashed together if required.

Original discussion starts at: $gmane/297908
V1 patch series $gmane/298223
V2 patch series $gmane/298689


Philip Oakley (8):
  doc: use 'symmetric difference' consistently
  doc: revisions - name the Left and Right sides
  doc: show the actual left, right, and boundary marks
  doc: give headings for the two and three dot notations
  doc: gitrevisions - use 'reachable' in page description
  doc: gitrevisions - clarify 'latter case' is revision walk
  doc: revisions  - define `reachable`
  doc: revisions - clarify reachability examples

 Documentation/gitk.txt             |  2 +-
 Documentation/gitrevisions.txt     |  6 ++---
 Documentation/pretty-formats.txt   |  2 +-
 Documentation/rev-list-options.txt |  4 +--
 Documentation/revisions.txt        | 50 ++++++++++++++++++++++++++------------
 5 files changed, 41 insertions(+), 23 deletions(-)

-- 
2.8.4.windows.1.3.ge328a54

follows from msg-ID <20160630202509.4472-1-philipoakley@iee.org>
