Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF601F461
	for <e@80x24.org>; Wed,  3 Jul 2019 01:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGCBQg (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 21:16:36 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:37922 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGCBQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 21:16:36 -0400
Received: by mail-yb1-f177.google.com with SMTP id j199so370768ybg.5
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 18:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QB1llH9BSpEbW4EnF/9Q97F49iAG6SX1PZ3OURaJMBU=;
        b=nysWaUbM30GNnzmph1Zi6FXiz9j2E8hcpewFSrNgxF83HOWiB3/CHNUoHXG8TSRL71
         ew7Zb4nJee9xPO7ghE6jmNMYuThvFUGghtBfoPBPKbvtdPp8GOVJNvQfo+DmwyrZPANQ
         uG5SNs7+j5Jh7JwLHqnBGjylvoRbnRNjIzaFuEk1K1jQDINr9CkU66VdQehmlMPfmrk7
         OLTUBcZFsjawMtWSTzYjXuS3sww43VOSYr8pYYBPlvmylJ7HO9ZZfuPseYmyUgvDD3q5
         8R9+0M+f8XDMyc+psOdlPISLTrT5KGp4a4u72928gFW9ujDMifn5FzqRboey8UcyuZWO
         qGuA==
X-Gm-Message-State: APjAAAUxLxB2z3f2sQ76cG0+Auu7V+k8453KE6TZbg3NxzI2HYC2rnRF
        w8bVBfpAs1C78jbiLMKPZQ7ps7KB8ZKzbWhGgBsnGFGE
X-Google-Smtp-Source: APXvYqx6ziENMXxgZAXe+CRuK5xXH5v4HJBdZN8j5fSPl5zSWfpikHdRNRCqEm58xMMnILCfXBB8+PHhvQuJJrN0rsQ=
X-Received: by 2002:a25:3cc7:: with SMTP id j190mr12368512yba.452.1562098049586;
 Tue, 02 Jul 2019 13:07:29 -0700 (PDT)
MIME-Version: 1.0
From:   Nathan Moreau <nathan.moreau@m4x.org>
Date:   Tue, 2 Jul 2019 22:07:18 +0200
Message-ID: <CADDcBWXzyK_-r6+R9NXwd1cMGb_iuTOv2cXRBu+A4uxhfYaLCQ@mail.gmail.com>
Subject: [ANNOUNCE] diffr, a diff highlighting tool
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

diffr is a diff highlighting tool that tries to improve on
diff-highlight by computing largest common subsequence on
hunks with a word resolution.
The resulting diff is displayed on top of the classic unified diff.

I share it here in the hope that it can be useful.
You can find it at https://github.com/mookid/diffr

Nathan
