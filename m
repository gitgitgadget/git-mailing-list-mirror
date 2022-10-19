Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9017AC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 16:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJSQZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJSQZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 12:25:15 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548F418C971
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 09:25:12 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 29JGPAYb054778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Oct 2022 12:25:10 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <01cd01d8e3c7$e93bff50$bbb3fdf0$@nexbridge.com>        <01d101d8e3cb$ab9d7940$02d86bc0$@nexbridge.com> <xmqqk04vu8xr.fsf@gitster.g>
In-Reply-To: <xmqqk04vu8xr.fsf@gitster.g>
Subject: RE: 2.38.1 Build Version Confusion
Date:   Wed, 19 Oct 2022 12:25:04 -0400
Organization: Nexbridge Inc.
Message-ID: <01db01d8e3d7$5b9f4cf0$12dde6d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFw3wsZA0PwGatLtaORLvCEJEEHMwEl83V4AoMrxgCuyKdTYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 19, 2022 11:31 AM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> On October 19, 2022 10:35 AM, I wrote:
>>>When I build 2.38.1, I'm ending up with GIT-VERSION-FILE as follows:
>>>
>>>$ cat GIT-VERSION-FILE
>>>GIT_VERSION = 2.38.GIT
>>>
>>>$ ./git version
>>>git version 2.38.GIT
>
>That is unexpected.
>
>>>This seems a bit different from past patches. Is this intended?
>>
>> I should point out that I used the 'main' branch for this build.
>
>Yes, you should.  You didn't build 2.38.1.
>
>If you built 'main' (which does not really exist, by the way---I push out
'master' to
>'master' and to 'main' when I publish for illusion), it has a lot of
development
>towards the next feature release plus whatever is in 'maint', and 2.38.GIT
is
>expected.
>
>"git checkout --detach v2.38.1" and build from there, and then you can say
"I built
>2.38.1".  "git checkout maint" and building it right now would also build
2.38.1 but
>that is only true until 'maint' gains more updates on top to prepare for
2.38.2.

I am going to change our build process to be specific in terms of tags
instead of using branch names from here on.

Thanks,
Randall

