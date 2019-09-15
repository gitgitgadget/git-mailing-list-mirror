Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45BD01F463
	for <e@80x24.org>; Sun, 15 Sep 2019 23:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfIOXde (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 19:33:34 -0400
Received: from ozlabs.org ([203.11.71.1]:52845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfIOXde (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 19:33:34 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 46Wm0C6d7Kz9sP7; Mon, 16 Sep 2019 09:33:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1568590411; bh=uN92NnDiqGdrhE2F8gmsziNlNRsN0FYQUIRwfp4z60k=;
        h=Date:From:To:Cc:Subject:From;
        b=ZtfNNSavydHn7t6cIX5NdZe7U/GSfuhpMBUfWTgtdIAdQOq+J37w7Sr3L5g+duvN/
         gcBygFU2BTup1T2ZYlWLmfl3i7nf9At0gFQxcQbjaolJ9ocnXn5+LhTV+K39ETrJ50
         YorlH8FMkjSzvPEFSYUUKAHsoYpCabLPXpHTFJz1KuqF/4JxTbKfqjXHhW5jk7HGVe
         ZkGx3wf+jI6ipeV0o8diEEELRQ7xgv3iUCrRSaaZ+ISIb6Qbk9ub/U0T03IPs8chmr
         QjqPke8Lzvi/OaNfyTPYIsfLYx7YekjzdbIOcYq/W5wopwnj8p8o8Cn1S/Im383j0F
         ugs5VqpdvqXFg==
Date:   Mon, 16 Sep 2019 09:33:28 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [GIT PULL] gitk update
Message-ID: <20190915233328.GD9560@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Whenever it's convenient, please do a pull from my gitk repository at
git://ozlabs.org/~paulus/gitk.git to get four commits updating gitk.

Thanks,
Paul.

----------------------------------------------------------------
Gabriele Mazzotta (1):
      gitk: Do not mistake unchanged lines for submodule changes

Paul Mackerras (1):
      gitk: Make web links clickable

Paul Wise (1):
      gitk: Use right colour for remote refs in the "Tags and heads" dialog

YanKe (1):
      gitk: Add Chinese (zh_CN) translation

 gitk        |   64 ++-
 po/zh_CN.po | 1367 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1427 insertions(+), 4 deletions(-)
 create mode 100644 po/zh_CN.po
