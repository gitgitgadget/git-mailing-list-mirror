Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E4C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 14:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245094AbiFCOR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245088AbiFCORV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 10:17:21 -0400
X-Greylist: delayed 1124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Jun 2022 07:17:00 PDT
Received: from mnementh.co.uk (mail.mnementh.co.uk [IPv6:2a07:4580:b0d:4f0::c573])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24BDE82
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mnementh.co.uk; s=exim; h=Content-Transfer-Encoding:Content-Type:Cc:Subject
        :From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FzkC9RZIExBHcgCF2OtTYIRLWq3LCRiyCvA+jYwLIts=; b=j3Yj5umf2MRvnrdf5RSHsvxhKJ
        q0FD1Qa7cSUCZQhE3ZX1nPJCyq+lwAivxvSzX3/mjNfcq8F4DA+6cEmdT/aaLhNBz0zoPBNlTVlzx
        fW5jz0Emr+ekStz/LRrCTPVztwd49i1hDmvDdo96e3V8ZVLTdOvF3004wyeWuHjKy49DEsW8wKIRj
        EP18YFCMV4Qby/rF0cuypKOOz6qNT/UoH2N7XhrP4FO7enIuOyZLuCxjfY6x3Hqm+DPLRtSgdzGyQ
        v5Sf/CPUKO4lFfJqpVtjX17tNLPKIAuZWmtZQ/9vn5racGqWlvqs4tVPFW6ZkBg0yyKTYFuqEeL0z
        RgA8X8Nw==;
Received: from 115.24.187.81.in-addr.arpa ([81.187.24.115] helo=[192.168.1.64])
        by mnementh.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git-ian@mnementh.co.uk>)
        id 1nx7oa-009QDU-Pm; Fri, 03 Jun 2022 14:58:12 +0100
Message-ID: <870137b1-9134-5791-d9fa-4826687e0781@mnementh.co.uk>
Date:   Fri, 3 Jun 2022 14:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-GB
To:     git@vger.kernel.org
From:   Ian Molton <git-ian@mnementh.co.uk>
Subject: BUG report: git-gui does not show commit message templates
Cc:     Ian Molton <git-ian@mnementh.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Please CC: me in replies, I'm not a list member.

I've just found that git-gui does not show commit templates.

I've checked and found this commit:
627c87f84c157885d587125cf0c73591a0e3ee7a

which suggests to me that the issue should have been fixed, but it
clearly has not.

I've removed git-gui from the system (Ubuntu package), and compiled the
latest mainline git-gui (as of today), and the problem remains.

(In fact, worse, its now auto-filling in my signed-off-by: line rather
than leaving the commit message blank (or preferably, showing the template).

-Ian
