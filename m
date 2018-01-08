Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 150CD1FAE2
	for <e@80x24.org>; Mon,  8 Jan 2018 20:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbeAHUMC (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 15:12:02 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53345 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754362AbeAHUMB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Jan 2018 15:12:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F6E020E83
        for <git@vger.kernel.org>; Mon,  8 Jan 2018 15:12:00 -0500 (EST)
Received: from web4 ([10.202.2.214])
  by compute3.internal (MEProxy); Mon, 08 Jan 2018 15:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=ygJnt6PgHoOtCYXiYAa+K7v/rOltI
        OFKubWNRpxnPow=; b=UYBoUKzK2fd2X9xM99dOdupxAQpDEaeu+Ku+Jmh1S4wPQ
        Ib2USg5s5TfrH+qZbhklipZQ8Q8Ul6M8k5KMWaZh8P2oHO+ZRrWj1BfoS04wJAFW
        eeqkOWVwyGcPAsTCtb/EMgjyuEOe5p+4k7pzYom+sgy2dVxTuY72nI7Dp/OuJK22
        35DQbsTLkOevTRwlLMeY2JoqsabX8ksKbcLOMu3xoxqdJGypuI/yMel+5cKh6unO
        cIU7u7BdID9Cl0F2HVfhTw91GCfqg2CZzbE8AlAU+K3EmcKacF8ukAPNnz3dJ5PP
        qKTPfWEYI3iWyDnRpuLhYpSehmYpiGObVCypPKSKg==
X-ME-Sender: <xms:kNBTWnScBdJnPb8uS8BEzPrIudk7jG3yM-txu6Nu2xGFwY5zaca7Wg>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 4CD75BA1AC; Mon,  8 Jan 2018 15:12:00 -0500 (EST)
Message-Id: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
From:   Colin Walters <walters@verbum.org>
To:     git@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-6368b27c
Date:   Mon, 08 Jan 2018 15:12:00 -0500
Subject: upstreaming https://github.com/cgwalters/git-evtag ?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, so quite a while ago I wrote this:
https://github.com/cgwalters/git-evtag

Since I last posted about this on the list here, of course
shattered.io happened.  It also looks
like there was a node.js implementation written.

Any interest in having this in core git?  
