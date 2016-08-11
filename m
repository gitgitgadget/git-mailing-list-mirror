Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208C820193
	for <e@80x24.org>; Thu, 11 Aug 2016 23:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbcHKXDg (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 19:03:36 -0400
Received: from smtp-d-1.talktalk.net ([78.144.6.129]:64940 "EHLO
	smtp-d-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbcHKXDf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 19:03:35 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Xz0fbUn3J0KuvXz0fbI48P; Fri, 12 Aug 2016 00:03:33 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	1
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 p=5rxgeBVgAAAA:8
 a=118V6UEFpCLMRzptT8w30g==:117 a=118V6UEFpCLMRzptT8w30g==:17
 a=Y4fupz4FIw0blsc7H_wA:9 a=PwKx63F5tFurRwaNxrlG:22
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 00/12] Update git revisions
Date:	Fri, 12 Aug 2016 00:03:15 +0100
Message-Id: <20160811230327.4416-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160720211007.5520-1-philipoakley@iee.org>
References: <20160720211007.5520-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfLWp2Hf9By3NivXlA11zd+j/e18ipGmU5dWUrJ1YVmJbAwR8xH1+jYY8yPbp/NwmcvIBria2MMKTSwcqzvb7WgsOb960muoZlhTYBpcu+zlbdOLtiUZt
 WoUyfFcZ4BB0Q8JX0ygK6kpcmIQG+B5FYwrEGM37H07//d5/pbcU5D+Ve7f6neQLVtAhGuwhKAa7eCSHT+cCFYav34CTPC0lVPY=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This has grown like topsy from a little two patch series that tried to
name the 2-dots notation [1] into this extended set of tweaks.

As documentation can be rather personal, I've split out each small change
so each can be individually justified.

Since V4, I've confirmed that the format breaking issue is that we cannot
quote code in headings in the man page layout - ultimately it's a docbook
decision, and follows the line of analysis Peff identified (see commentary
in the patch).

In addition the multi-parent notations have been clarified and extended.

Thus the old patch 4 has been split into three. The first three patches are
unchanged. The following 4 patches are also unchanged.

Finally, at the end an extra 2 patches are added to build up the examples by
including details of the notation expansions.

This updates po/range-doc (2016-07-20) 8 commits.

Hopefully my updated workflow will get the right patches to the right people.

[1] https://public-inbox.org/git/0648000B273C412AB7140AE959EBC99A%40PhilipOakley/

Philip Oakley (12):
  doc: use 'symmetric difference' consistently
  doc: revisions - name the left and right sides
  doc: show the actual left, right, and boundary marks
  doc: revisions: give headings for the two and three dot notations
  doc: revisions: extra clarification of <rev>^! notation effects
  doc: revisions: single vs multi-parent notation comparison
  doc: gitrevisions - use 'reachable' in page description
  doc: gitrevisions - clarify 'latter case' is revision walk
  doc: revisions  - define `reachable`
  doc: revisions - clarify reachability examples
  doc: revisions: show revision expansion in examples
  doc: revisions: sort examples and fix alignment of the unchanged

 Documentation/gitk.txt             |   2 +-
 Documentation/gitrevisions.txt     |   6 +-
 Documentation/pretty-formats.txt   |   2 +-
 Documentation/rev-list-options.txt |   4 +-
 Documentation/revisions.txt        | 121 +++++++++++++++++++++++--------------
 5 files changed, 84 insertions(+), 51 deletions(-)

-- 
2.9.0.windows.1

