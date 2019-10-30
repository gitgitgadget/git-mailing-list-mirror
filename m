Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 287DE1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 16:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfJ3Q3R (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 12:29:17 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:7575 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3Q3R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 12:29:17 -0400
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iPqqQ-0002aq-Cu
        for git@vger.kernel.org; Wed, 30 Oct 2019 17:29:14 +0100
To:     git@vger.kernel.org
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: 'git reset -- NonExistingFile' succeeds
Message-ID: <f6d853ce-6f27-ed58-a850-d9a6f245509a@syntevo.com>
Date:   Wed, 30 Oct 2019 17:29:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is that expected?

Other commands seem to not like that:

$ git checkout NonExistingFile
error: pathspec 'NonExistingFile' did not match any file(s) known to git
