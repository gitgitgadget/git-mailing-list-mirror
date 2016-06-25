Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB391FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcFYQrH (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 12:47:07 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:40183 "EHLO
	smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbcFYQrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 12:47:05 -0400
Received: from localhost.localdomain ([92.22.68.35])
	by smtp.talktalk.net with SMTP
	id GqjWbvjeqYIiqGqjWbpjXO; Sat, 25 Jun 2016 17:47:03 +0100
X-Originating-IP: [92.22.68.35]
X-Spam:	0
X-OAuthority: v=2.2 cv=P/l4vWIu c=1 sm=1 tr=0 a=MvvZD7eUgq4fJAFIMo7fmA==:117
 a=MvvZD7eUgq4fJAFIMo7fmA==:17 a=NuIX-1x_Lz6RfGzgSVoA:9
From:	Philip Oakley <philipoakley@iee.org>
To:	GitList <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/2] Re: name for A..B ranges?
Date:	Sat, 25 Jun 2016 17:46:52 +0100
Message-Id: <20160625164654.5192-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.8.4.windows.1.3.ge328a54
In-Reply-To: <E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley>
References: <E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley>
X-CMAE-Envelope: MS4wfGdk9lzN0WQaA+bRR53gcjGqaR7z/iH0d2wxP16Raoh84XzfrxLfbbL7s0/ZCrOd3pqZEJj8vfKpJCrgow30QzcGVT44MPAa+gkO5gOS4Hkb9Fpxkdlx
 RJKb0Zqa6Fs2uFOgFChxeLtsY6fW5RHOig6wOE+t9h1yzJ+ymjuhXAm3/4QH7D4IB2kAeYpvds1ESjkqoTZ5lEd7uCaLy/YZQiZo0vVENQqS18U4vdZQXjzk
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

>> On Wed, Jun 22, 2016 at 08:25:59AM +0100, Philip Oakley wrote:
>>
>>> Is there a common name for the A..B range format (two dots) that would
>>> complement the A...B (three dots) symmetric range format's name?
$gmane/297908

Here is a short two patch series to hopefully enhance the
revisions (and rev-parse) man page to help clarify the symmetric
difference and two / three dots notations.

The HTML versions look OK to me - tested on the Git-for-Windows SDK.

Philip Oakley (2):
  doc: use 'symmetric difference' consistently
  doc: give headings for the two and three dot notations

 Documentation/gitk.txt             |  2 +-
 Documentation/rev-list-options.txt |  4 ++--
 Documentation/revisions.txt        | 17 +++++++++++++----
 3 files changed, 16 insertions(+), 7 deletions(-)

-- 
2.8.4.windows.1.3.ge328a54
