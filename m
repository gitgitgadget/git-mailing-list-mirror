Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A2B51F45F
	for <e@80x24.org>; Wed,  8 May 2019 23:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfEHXKQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 19:10:16 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:46238 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbfEHXKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 19:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1557357114; bh=sXe4D5/guF26H7DmUhvpmc6TNB/X9HwtCsP/lLz1a7Q=;
        h=Date:From:To:Subject;
        b=NZdp5kYKMjtuAwAnRVjcJS2kbm2W2wzqox0rZM6x3cQnFB7jtcJob0wQuxoR5xL8B
         3lUt7eUl+fmPQMJShtWmyTXJ8G6AgP3uxGqKVxnc4+0p+cb/UeO5MzptHs7iWv3cA6
         ixgu+5yStLaHo2TYVn/Al14Q0iZ2HySKOXJZCp1s=
Date:   Wed, 8 May 2019 19:10:13 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Subject: Proposal: Remembering message IDs sent with git send-email
Message-ID: <20190508231013.GA25216@homura.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want to gather some thoughts about this. Say you've written a patch
series and are getting ready to send a -v2. If you set
--in-reply-to=ask, it'll show you a list of emails you've recently sent,
and their subject lines, and ask you to pick one to use the message ID
from. It'll set the In-Reply-To header to your selection.

I'd also like to add a custom header, X-Patch-Supersedes: <message ID>,
with a similar behavior & purpose.

Thoughts?
