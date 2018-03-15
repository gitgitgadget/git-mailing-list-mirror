Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 345E91F404
	for <e@80x24.org>; Thu, 15 Mar 2018 21:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCOVv2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 17:51:28 -0400
Received: from avasout01.plus.net ([84.93.230.227]:48619 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeCOVv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 17:51:27 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id wamSeIuA4MLyGwamTexJ6W; Thu, 15 Mar 2018 21:51:26 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=HInt6Llv c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=0T2KFXilnyIgIlDf_tMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, szeder.dev@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1803151821270.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <xmqq37115ggs.fsf@gitster-ct.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <fd51a62f-42bb-b0ef-ebe3-d8e08b047777@ramsayjones.plus.com>
Date:   Thu, 15 Mar 2018 21:51:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq37115ggs.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHz9dYBJiIX21Hpw7LQRSaPRChNhwwFYPOs5saVayywGDuaa+qV5ynWCJaXuSAbh9aLTNgqBxppzp3Nr23YEQVHCEY2HTx7joODQGCyb4wBAR8PpHts5
 X5ujQRGNg23etNUBywxvLrp4a4aiYcQgiAdZ9SR/c29E/39JM5Naf43W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/03/18 18:41, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Stolee, you definitely want to inspect those changes (`git log --check`
>> was introduced to show you whitespace problems). If all of those
>> whitespace issues are unintentional, you can fix them using `git rebase
>> --whitespace=fix` in the most efficient way.
> 
> Another way that may be easier (depending on the way Derrick works)
> is to fetch from me and start working from there, as if they were
> the last set of commits that were sent to the list.  "git log
> --first-parent --oneline master..pu" would show where the tip of the
> topic is.

BTW, thanks for adding the 'SQUASH??? sparse fixes' on top of that
branch - sparse is now quiet on the 'pu' branch. (The same can't
be said of static-check.pl, but that is a different issue. ;-) ).

Thanks!

ATB,
Ramsay Jones

