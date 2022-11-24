Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FCBC4321E
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 18:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKXR77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 12:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiKXR76 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 12:59:58 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4DD69AAA
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 09:59:56 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2AOHxsmw056539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:59:54 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG} t2201.7+ Failure to Create Thread in 2.39.0-rc0
Date:   Thu, 24 Nov 2022 12:59:48 -0500
Organization: Nexbridge Inc.
Message-ID: <010201d9002e$8e2f9940$aa8ecbc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdkALorOhlGy4XXST6OXFjS3a8vYqA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While running t2201.7 (and subsequent) for 2.39.0-rc0, I hit a condition
where:

<snip>
+ test_when_finished rm trace.perf actual
+ test_config_global trace2.perfBrief 1
+ pwd
+ test_config_global trace2.perfTarget
/home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/t/trash
directory.t0211-trace2-perf/trace.perf
+ test-tool trace2 101timer 5 10 3
fatal: failed to create thread[0]

was encountered, causing the test to fail. Pointers on resolving this would
be helpful.

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



