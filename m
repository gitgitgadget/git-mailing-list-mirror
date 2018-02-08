Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881841F404
	for <e@80x24.org>; Thu,  8 Feb 2018 18:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeBHS4m (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 13:56:42 -0500
Received: from smtp122.ord1c.emailsrvr.com ([108.166.43.122]:58748 "EHLO
        smtp122.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752166AbeBHS4l (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Feb 2018 13:56:41 -0500
Received: from smtp24.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 5296E6060E;
        Thu,  8 Feb 2018 13:48:04 -0500 (EST)
X-Auth-ID: jon@jonsimons.org
Received: by smtp24.relay.ord1c.emailsrvr.com (Authenticated sender: jon-AT-jonsimons.org) with ESMTPSA id F0440604B5;
        Thu,  8 Feb 2018 13:48:03 -0500 (EST)
X-Sender-Id: jon@jonsimons.org
Received: from 73.223.68.52 (c-73-223-68-52.hsd1.ca.comcast.net [73.223.68.52])
        (using TLSv1.2 with cipher AES128-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 08 Feb 2018 13:48:04 -0500
From:   Jon Simons <jon@jonsimons.org>
To:     git@vger.kernel.org
Cc:     Jon Simons <jon@jonsimons.org>
Subject: [PATCH 0/2] Fix NULL checks for some packet_read_line call sites
Date:   Thu,  8 Feb 2018 13:47:48 -0500
Message-Id: <1518115670-2646-1-git-send-email-jon@jonsimons.org>
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Included here are a couple of fixes and cleanups for
handling NULL return values from 'packet_read_line'.

Jeff King (1):
  correct error messages for NULL packet_read_line()

Jon Simons (1):
  always check for NULL return from packet_read_line()

 builtin/archive.c | 2 +-
 fetch-pack.c      | 4 ++--
 remote-curl.c     | 2 ++
 send-pack.c       | 2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.1.4

