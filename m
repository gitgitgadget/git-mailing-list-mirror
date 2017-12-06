Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF91420C11
	for <e@80x24.org>; Wed,  6 Dec 2017 17:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbdLFRjf (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 12:39:35 -0500
Received: from avasout01.plus.net ([84.93.230.227]:40081 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbdLFRjf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 12:39:35 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id MdfQebIwnJjiPMdfReBeHl; Wed, 06 Dec 2017 17:39:33 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=O6ZJhF1W c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=Lepp-MNoklabaC6eycYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Jeff Hostetler <jeffhost@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: partial_clone_get_default_filter_spec has no callers
Message-ID: <ec83f2d9-0d87-9d6b-4860-f4cd7c19984e@ramsayjones.plus.com>
Date:   Wed, 6 Dec 2017 17:39:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNqg0DFL3EPdtCMiXRPSYxFu/LSf77FMlUYTCnL8wdMe7P59eRS9iBkW6c99PI0R9bgaU1n0IqR0PHXHFKT3lc8qd2q0Ob7XBP8FgaIifgSlgeTuLVHg
 gXiGK/xDA+LjxNQAFdJ6sid9NHM390Tr4Gfx/sqClDpH/gqu1wIwECBK108CRwHKXiyqA/WN25ZJGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

commit f1862e8153 ("partial-clone: define partial clone settings
in config", 2017-12-05), which is part of your 'jh/partial-clone'
branch, introduces the partial_clone_get_default_filter_spec()
function without any callers. Could you please confirm that this
is intentional and that, presumably, a future series will include
a call to this function.

Thanks!

ATB,
Ramsay Jones

