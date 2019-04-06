Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C64E20248
	for <e@80x24.org>; Sat,  6 Apr 2019 17:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfDFRcA (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 13:32:00 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:20781 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfDFRcA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 13:32:00 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id CpAchGeOZniZTCpAchPuhz; Sat, 06 Apr 2019 18:31:58 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=IkcTkHD0fZMA:10 a=hm87Nvtktgr9obp-0xoA:9
 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
To:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Subject: git glossary --help ?
Message-ID: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org>
Date:   Sat, 6 Apr 2019 18:31:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBGx3nGMLUC2spvMJsSe8kQd+U2nRDf3kv0GvWAgLYevmUPUlGnpMvR4BQpAnGZOPcWZemqdt6ZCDXpvDlliOMmyjhYRl9IBhbyMdTRlhHYchtAOxHZX
 56ZYnosE0eJjlcs+5Bwfo0hLcQlMVjmLvoioSAcD7UxXOo+aNLqAStw+PNrc+NAXPu4bYoXZPFqJRMzukRSaDhHxEuAFv5XO/vw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following the discussions about the tag peeling issue, I thought to have 
a look at what the git glossary says.

I had it in my head that when the git guides were linked to the help 
system, that the --help option provided a short circuit direct to help 
item. However this did not happen.

I found that the capability had been lost, which given that a lot of the 
underpinning knowledge is in the guides this would appear to be a loss.

I don't have an older version to test, but I thought I remember the 
capability from about the time of my 65f98358c0 ("builtin/help.c: add 
--guide option", 2013-04-02).

Have I misremembered the --help capability?

cc'ing Duy in case he remembers something from the recent update

As a side note, the glossary does mention a few times the tag of tag 
capability but doesn't mention the peel/no-peel distinctions.
-- 
Philip
