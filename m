Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A882C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 23:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442442AbiDUXWF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 19:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442406AbiDUXWE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 19:22:04 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C18242EE6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 16:19:13 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 23LNJ9mv000726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 21 Apr 2022 19:19:09 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Alyssa Ross'" <hi@alyssa.is>,
        "=?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0_Bjarmason'?=" <avarab@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20220421194832.lshqkl3bogy2f2hy@eve> <220421.86tuam5hoi.gmgdl@evledraar.gmail.com> <20220421223843.6z3y4bnrbu76erhk@eve>
In-Reply-To: <20220421223843.6z3y4bnrbu76erhk@eve>
Subject: RE: Failures in t9001-send-email
Date:   Thu, 21 Apr 2022 19:19:04 -0400
Organization: Nexbridge Inc.
Message-ID: <024e01d855d6$35003d00$9f00b700$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNcJ8Y8zFGc2cpM3gWndKn2cOomuwGsTrEwAfGnE7Cp1mzfQA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 21, 2022 6:39 PM, Alyssa Ross wrote:
>> I think a patch to do that would be worth having/reviewing (hint
>> hint!). As always the real work is updating docs, running the tests
>> etc., digging up ML discussions to see if there's been any past
>> arguments for/against it etc.
>>
>> In this case the code change itself should be trivial (I honestly
>> didn't look this time, but really, it's a config default...). So this
>> seems like a perfect task for someone not too familiar with Git's
>> codebase, but still interested in contributing :)
>
>I thought I'd have a go at a patch, but I wasn't able to get the tests
>running:
>
>    prove ./t9001-send-email.sh
>    ./t9001-send-email.sh .. Dubious, test returned 1 (wstat 256, 0x100)
>    Failed 15/188 subtests
>      (less 1 skipped subtest: 172 okay)
>
>    Test Summary Report
>    -------------------
>    ./t9001-send-email.sh (Wstat: 256 Tests: 188 Failed: 15)
>      Failed tests:  27, 51, 78-84, 123, 147-150, 185
>      Non-zero exit status: 1
>    Files=1, Tests=188, 17 wallclock secs ( 0.06 usr  0.01 sys + 11.66 cusr
5.37 csys =
>17.10 CPU)
>    Result: FAIL
>
>I had a look at the tests to try to guess what was wrong, but I didn't come
up with
>anything.  Any ideas?  When I run make test, every other test is fine, it's
just the
>send-email tests that are problematic.

I have the same issue on NonStop. Not sure why, other than our sendmail is
massively broken.
--Randall

