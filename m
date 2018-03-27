Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6771F404
	for <e@80x24.org>; Tue, 27 Mar 2018 15:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeC0PpV (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 11:45:21 -0400
Received: from avasout04.plus.net ([212.159.14.19]:34629 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeC0PpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 11:45:20 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 0qmjfryN0sD7b0qmkfEDzm; Tue, 27 Mar 2018 16:45:19 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=bt3WUTiwAAAA:8 a=yMhMjlubAAAA:8 a=VO3WoFkWJeSQ_Oc1fIIA:9
 a=QEXdDO2ut3YA:10 a=OXx4ngWzwLx9h_IvVXMu:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON
 format
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, l.s.r@web.de, wink@saville.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180326143136.47116-1-git@jeffhostetler.com>
 <20180326143136.47116-2-git@jeffhostetler.com>
 <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
Message-ID: <ad15ccab-088d-b827-a9fa-c83d397c3479@ramsayjones.plus.com>
Date:   Tue, 27 Mar 2018 16:45:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <ce076d5e-f30f-006e-a25e-ff1a900562bf@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP4nlak2Lzr9k/zWlcMp29bxstR8sLNYh2UOE06EUS1jIDE0dI4jcC/M4L7E2AyxFinGzLBid03/hk2JUcb+NGapPfc2479jt43W2yDQ0m8fO6UWm+eV
 G3Q8k0evC0Pvhooku5u9QTv3uGtcs240HCjxmQtJ5SZmNP+ANMCWYsiR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/03/18 04:18, Ramsay Jones wrote:
> On 26/03/18 15:31, git@jeffhostetler.com wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
> [snip]
> 
> Thanks, this version fixes all issues I had (with the compilation
> and sparse warnings).
> 
> [Was using UINT64_C(0xffffffffffffffff) a problem on windows?]

BTW, I forgot to mention that you had some whitespace problems
with this patch, viz:

  $ git log --oneline -1 --check master-json
  ab643d838 (master-json) json_writer: new routines to create data in JSON format
  t/helper/test-json-writer.c:280: trailing whitespace.
  + */ 
  t/t0019-json-writer.sh:179: indent with spaces.
  +        "g": 0,
  t/t0019-json-writer.sh:180: indent with spaces.
  +        "h": 1
  $ 

ATB,
Ramsay Jones

