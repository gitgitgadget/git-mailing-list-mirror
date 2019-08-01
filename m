Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C121F731
	for <e@80x24.org>; Thu,  1 Aug 2019 14:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfHAOq3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 10:46:29 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:24468 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfHAOq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 10:46:29 -0400
X-Greylist: delayed 761 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 10:46:29 EDT
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1htC9K-0002Ic-NF; Thu, 01 Aug 2019 16:33:46 +0200
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
 <066cfd61-9700-e154-042f-fc9cffbd6346@web.de>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <a5c7d7af-b83c-5ea7-b8bf-1e4a4e986469@syntevo.com>
Date:   Thu, 1 Aug 2019 16:33:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <066cfd61-9700-e154-042f-fc9cffbd6346@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.08.2019 16:26, René Scharfe wrote:
> Would it make sense to have a --paths-file parameter instead

Both approaches (stdin or file) will work well for us. File sounds
easier from programming perspective. However, in previous discussion, 
there was some concern about possible security problems with this approach.
