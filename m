Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87871F462
	for <e@80x24.org>; Thu,  6 Jun 2019 17:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfFFRAb (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 13:00:31 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:11964 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfFFRAa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 13:00:30 -0400
Received: from [192.168.1.22] ([78.148.161.28])
        by smtp.talktalk.net with SMTP
        id YvkahEvvqgI7iYvkahLtxI; Thu, 06 Jun 2019 18:00:29 +0100
X-Originating-IP: [78.148.161.28]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=ujKALdKAi7z8notBBWqKeA==:117
 a=ujKALdKAi7z8notBBWqKeA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=tSB6hO8UNCUCU2u52DAA:9 a=QEXdDO2ut3YA:10
Subject: Re: [PATCH v4 10/14] commit-graph: allow cross-alternate chains
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
 <pull.184.v4.git.gitgitgadget@gmail.com>
 <62b3fca582814c2cee050bab07533409e22e2c3c.1559830527.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <37599a09-c89f-6ef7-1743-d21316348db2@iee.org>
Date:   Thu, 6 Jun 2019 18:00:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <62b3fca582814c2cee050bab07533409e22e2c3c.1559830527.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfDOeyEu3Dt1xgq1OHHdGibN6/ozBNOcH+oG+DKuJi3BIpVCI18yvaMCKDgEv8t1LqgXhzOhvFy/WlCOFxaHE8Wo86s17G6FOO+xUn3Abt0XLoNC66Hrk
 o7FcbmJ99PQYCl3XMGNjIroj5/aOeb9YOe3WpVbkSY2wRR5UPIp299yULjGMA9LVDUGvGmG0A9jcdd66/tMzmcbQRGo/uQ70/5efojyiUVnz0gobubMVBY5X
 scj4bUCU9TAz1oZmShwJAclR4Pf4NR+oWsPZqs9RhknypsO9fdwxEbQj8S0EXRy4U2oWpt7WY5L+5pLmtL3XeBas5K+/SrOHtejSb3aAm69qyMTrPSkTv1WF
 kzhLlUFa+FOAigUUn3O1Ky3IRL5dMnvYeckAb9HbWSu3Yxbx+fJ/Ykzw+o2XQIp7fr+hYRJdkJ9HkMHvTJR2GIDvTPHKfFTSeR6JV8VNMzEO3P/1chQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is this a spelling nit?
On 06/06/2019 15:15, Derrick Stolee via GitGitGadget wrote:
> 3. When writing a new commit-graph chain based on a commit-graph file
>     in another object directory, do not allow success if the base file
>     has of the name "commit-graph" instead of
>     "commit-graphs/graoh-{hash}.graph".
s/graoh-/graph-/    ?
--
Philip
