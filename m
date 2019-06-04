Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB4C1F462
	for <e@80x24.org>; Tue,  4 Jun 2019 11:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfFDLxy (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 07:53:54 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:38148 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfFDLxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 07:53:53 -0400
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 51809E00BD
        for <git@vger.kernel.org>; Tue,  4 Jun 2019 13:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 51809E00BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1559648656; bh=mUmBzyyV6HOHQP3e4cBV/QQ+yFXrhSPMvAdQwqTTaqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whGTJKmo+UUXDC46V+KXy5RurOx2zybjvDCaaDlW2HlCg0HvYt7lVlAPfa/yYn+nk
         xhzb/wrCuuw/Dm2tHk52cPJZJ/ZbFyyEkSrzBYUHTXQ2RZs3eWidCgPrWnT7m6tUFO
         j2Y/G/MFCPug1NP/VzwWaq9JR0eRBTqII3HJRhgw=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 4CC771201D6;
        Tue,  4 Jun 2019 13:44:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from ani.desy.de (zitpcx21033.desy.de [131.169.185.213])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id 2192910003B;
        Tue,  4 Jun 2019 13:44:16 +0200 (CEST)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com
Subject: config option to force all tags be GPG-signed - comeback
Date:   Tue,  4 Jun 2019 13:43:55 +0200
Message-Id: <20190604114356.11042-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <60741736.3439901.1509090074292.JavaMail.zimbra@desy.de>
References: <60741736.3439901.1509090074292.JavaMail.zimbra@desy.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As there was some interest on my original pull request on github[1], 
I decided to rebase, update the commit message and re-post this patch.


[1] https://github.com/git/git/pull/419

