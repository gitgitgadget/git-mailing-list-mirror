Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB162C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 10:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiDVKpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 06:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352844AbiDVKo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 06:44:58 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83399E31
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 03:42:05 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23MAg01u043328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Apr 2022 06:42:00 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Alyssa Ross'" <hi@alyssa.is>
Cc:     "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>,
        <git@vger.kernel.org>
References: <20220421194832.lshqkl3bogy2f2hy@eve> <220421.86tuam5hoi.gmgdl@evledraar.gmail.com> <20220421223843.6z3y4bnrbu76erhk@eve> <024e01d855d6$35003d00$9f00b700$@nexbridge.com> <20220422075633.rpiteai4uwdd6jvr@eve>
In-Reply-To: <20220422075633.rpiteai4uwdd6jvr@eve>
Subject: RE: Failures in t9001-send-email
Date:   Fri, 22 Apr 2022 06:41:55 -0400
Organization: Nexbridge Inc.
Message-ID: <028501d85635$99790410$cc6b0c30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNcJ8Y8zFGc2cpM3gWndKn2cOomuwGsTrEwAfGnE7ADF6EZOQKfFH2Iqal2HMA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 22, 2022 3:57 AM, Alyssa Ross wrote:
>On Thu, Apr 21, 2022 at 07:19:04PM -0400, rsbecker@nexbridge.com wrote:
>> On April 21, 2022 6:39 PM, Alyssa Ross wrote:
>> >I thought I'd have a go at a patch, but I wasn't able to get the
>> >tests
>> >running:
>> >
>> >    prove ./t9001-send-email.sh
>> >    ./t9001-send-email.sh .. Dubious, test returned 1 (wstat 256, 0x100)
>> >    Failed 15/188 subtests
>> >      (less 1 skipped subtest: 172 okay)
>> >
>> >    Test Summary Report
>> >    -------------------
>> >    ./t9001-send-email.sh (Wstat: 256 Tests: 188 Failed: 15)
>> >      Failed tests:  27, 51, 78-84, 123, 147-150, 185
>> >      Non-zero exit status: 1
>> >    Files=1, Tests=188, 17 wallclock secs ( 0.06 usr  0.01 sys +
>> > 11.66 cusr
>> 5.37 csys =
>> >17.10 CPU)
>> >    Result: FAIL
>> >
>> >I had a look at the tests to try to guess what was wrong, but I
>> >didn't come
>> up with
>> >anything.  Any ideas?  When I run make test, every other test is
>> >fine, it's
>> just the
>> >send-email tests that are problematic.
>>
>> I have the same issue on NonStop. Not sure why, other than our
>> sendmail is massively broken.
>> --Randall
>
>For me the solution was to make Term::ReadLine available in my development
>environment.  I hope that helps you too!

Thanks. I will look into this.
--Randall

