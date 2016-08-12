Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F09D1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 23:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbcHLXpd (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 19:45:33 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:16927 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcHLXpc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 19:45:32 -0400
Received: from localhost.localdomain ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id YM8nbWgnZY8RwYM8nbscXj; Sat, 13 Aug 2016 00:45:30 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=118V6UEFpCLMRzptT8w30g==:117
 a=118V6UEFpCLMRzptT8w30g==:17 a=IkcTkHD0fZMA:10 a=6tO7PsMtg9iJQeDmi2YA:9
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 00/12] Update git revisions
Date:	Sat, 13 Aug 2016 00:45:18 +0100
Message-Id: <20160812234522.7792-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1
In-Reply-To: <20160811215035.4108-1-philipoakley@iee.org>
References: <20160811215035.4108-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLREmZRZokuiksMLj4b/lM60RgMc1Ieh0sNjs3bCy8YXs5zDbxvkx5lBMEAmni6z+NtzDKxCMD6w1/t8e5idgnnKYtG6iJjrnTKYUjJJuBFUWpYZYqG8
 x5PIo1VP46PS76UKmWRB3zmJO6A+18U7LnFdGebDsWc36258LkYKyyOjzogZYt6HRuC57daCOOXDGKp18GUdRM6hF3edq/EbMTs=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

These are the quick fixes to Marc's comments to patches 5,6,11,
and a consequential change to 12.

Only the changed patches are included.

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
 Documentation/revisions.txt        | 125 ++++++++++++++++++++++++-------------
 5 files changed, 88 insertions(+), 51 deletions(-)

-- 
2.9.0.windows.1

