Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D371E1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 20:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbdKHU2v (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 15:28:51 -0500
Received: from avasout04.plus.net ([212.159.14.19]:58204 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751770AbdKHU2u (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2017 15:28:50 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id CWxse4lhvzbmWCWxte3Csi; Wed, 08 Nov 2017 20:28:49 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=IkcTkHD0fZMA:10 a=H26aZnL-L6RbedqhYgUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Test failures on 'pu' branch
Message-ID: <cf38b57d-1424-0776-b67f-8cfd24e087bb@ramsayjones.plus.com>
Date:   Wed, 8 Nov 2017 20:28:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK1ToUUjjwSy8VOrdfinatAc0h7FMRP0dKjFx8NeAUhq3tLX6CCDaWdsA1+0DajhzwW6w6vx6yDP3ivt3nP9g1l2vORB1X/GUytGXE2CO3HCSNeoBENc
 KcknsyDac+fGnV5FaCaIsqC2DfUITm5WyixiVl7K59qKh84PoWZwfIBzg4bdchlyZQYiyj08PBICOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

You are probably already aware, but just in case, the 'pu' branch
fails the testsuite for me as follows:

$ tail -18 ptest-out
Test Summary Report
-------------------
t5300-pack-object.sh                             (Wstat: 256 Tests: 40 Failed: 2)
  Failed tests:  36-37
  Non-zero exit status: 1
t5500-fetch-pack.sh                              (Wstat: 256 Tests: 355 Failed: 6)
  Failed tests:  350-355
  Non-zero exit status: 1
t5601-clone.sh                                   (Wstat: 256 Tests: 102 Failed: 4)
  Failed tests:  99-102
  Non-zero exit status: 1
Files=800, Tests=16964, 462 wallclock secs ( 4.57 usr  0.78 sys + 57.93 cusr 24.16 csys = 87.44 CPU)
Result: FAIL
Makefile:45: recipe for target 'prove' failed
make[1]: *** [prove] Error 1
make[1]: Leaving directory '/home/ramsay/git/t'
Makefile:2448: recipe for target 'test' failed
make: *** [test] Error 2
$ 

Looking at the first test failure in each file, the failures seems
to be related to the 'jh/partial-clone' branch.

Just FYI. Thanks.

ATB,
Ramsay Jones

