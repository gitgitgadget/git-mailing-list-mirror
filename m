Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ADAA1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 15:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfFFPTg (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 11:19:36 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:55142 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbfFFPTg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 11:19:36 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id YuAvhEgH7gI7iYuAvhLp3q; Thu, 06 Jun 2019 16:19:34 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=UX3GHJjoH3VJePlpQi8A:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH v4 02/14] commit-graph: prepare for commit-graph chains
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
 <pull.184.v4.git.gitgitgadget@gmail.com>
 <d0dc154a27c80a8113ff47eb60a6b6f98fbeec91.1559830527.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <287d8877-cbeb-6712-68df-b231dac247e4@iee.org>
Date:   Thu, 6 Jun 2019 16:19:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d0dc154a27c80a8113ff47eb60a6b6f98fbeec91.1559830527.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfKr7c1IDfWFpJ7hAWb8VJMAutnMvToT/MIyCI3h/+rLyIAhRbQrAJ4UUoOQHupMnN7EN2et06RVCGb1sGeGlury8+XkIAZPamOTcMAbGcUWOO7+o6zs5
 aq1mUn3cyn+gxQ+4mkBO+vJnRAU59IbnZvrOmvsHDU9rxpMxwTlzBTQtEpU74NTdu1AFhxAT39UZO0nrkBPEZXJepZQMhAPpHCrIB6lc03/EKMPtBwFpoN5r
 gvfAmHEY+C4tx1HtrI/w1JZdfVoo4y+IN6VYfvyVwC9ckdVK+7sDeTjg32gosckqmhgvKufs2BaWh9lT2+Znyl4WFJFSJtzpAyP8xLzAEcMQU66m4P7ScCUz
 vzP91CWAbNenz89DktRBQ6mW9Iery74U/T3eiUQnS9JQljY4/n9kk0MW4BRDpNeGLWnFENnx36vQ/+Uqzsuzj3V2j6GhVMjj/UZ9L02YAKT9CA9sOgc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

spelling nit in the commit message..
On 06/06/2019 15:15, Derrick Stolee via GitGitGadget wrote:
>   * graph position: the posiiton within the concatenated order
s/posiiton/position/
--
Philip
