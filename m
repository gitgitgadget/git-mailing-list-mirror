Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B88C20282
	for <e@80x24.org>; Tue, 20 Jun 2017 18:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdFTSVo (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 14:21:44 -0400
Received: from smtp74.iad3a.emailsrvr.com ([173.203.187.74]:51573 "EHLO
        smtp74.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750823AbdFTSVo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Jun 2017 14:21:44 -0400
Received: from smtp34.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp34.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 36DF024CFD;
        Tue, 20 Jun 2017 14:21:43 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp34.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CEF4924C83;
        Tue, 20 Jun 2017 14:21:42 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 20 Jun 2017 14:21:43 -0400
Subject: Re: [PATCHv2] Tweak help auto-correct phrasing.
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
References: <xmqqpoknmv7d.fsf@gitster.mtv.corp.google.com>
 <20161220140226.18456-1-marcnarc@xiplink.com>
 <1497981886.28187.6.camel@gmail.com>
Cc:     Chris Packham <judge.packham@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <3164ca01-9b54-3c9b-96d8-182c9fbbceb9@xiplink.com>
Date:   Tue, 20 Jun 2017 14:21:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1497981886.28187.6.camel@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-06-20 02:04 PM, Kaartic Sivaraam wrote:
> On Tue, 2016-12-20 at 09:02 -0500, Marc Branchaud wrote:
>> When auto-correct is enabled, an invalid git command prints a warning
>> and
>> a continuation message, which differs depending on whether or not
>> help.autoCorrect is positive or negative.
>>
>> With help.autoCorrect = 15:
>>
>>     WARNING: You called a Git command named 'lgo', which does not
>> exist.
>>     Continuing under the assumption that you meant 'log'
>>     in 1.5 seconds automatically...
>>
>> With help.autoCorrect < 0:
>>
>>     WARNING: You called a Git command named 'lgo', which does not
>> exist.
>>     Continuing under the assumption that you meant 'log'
>>
>> The continuation message's phrasing is awkward.  This commit cleans
>> it up.
>> As a bonus, we now use full-sentence strings which make translation
>> easier.
>>
>> With help.autoCorrect = 15:
>>
>>     WARNING: You called a Git command named 'lgo', which does not
>> exist.
>>     Continuing in 1.5 seconds, assuming that you meant 'log'.
>>
>> With help.autoCorrect < 0:
>>
>>     WARNING: You called a Git command named 'lgo', which does not
>> exist.
>>     Continuing under the assumption that you meant 'log'.
>>
>> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>> ---
>>
> Excuse me for bringing this up after a long time. What's the status of
> this patch? Was it applied?

Looks like it got lost in the shuffle.

The topic thread starts at:
	http://public-inbox.org/git/1482063500.10858.1.camel@gmail.com/

There's no reply to my v2 patch, and I neglected to follow up on it -- 
sorry!

Shall I resend the patch?

		M.

