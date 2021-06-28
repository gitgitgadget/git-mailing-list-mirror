Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC3EC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB42F61C31
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 18:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhF1StX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Jun 2021 14:49:23 -0400
Received: from elephants.elehost.com ([216.66.27.132]:32309 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhF1StW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 14:49:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 15SIklvp025416
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Jun 2021 14:46:48 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Jeff King'" <peff@peff.net>
References: <60bfadc0aca09_1abb8f208fd@natae.notmuch> <60da10df509f0_1b95d2089c@natae.notmuch>
In-Reply-To: <60da10df509f0_1b95d2089c@natae.notmuch>
Subject: RE: How dow we educate our users to configure less?
Date:   Mon, 28 Jun 2021 14:46:42 -0400
Message-ID: <029001d76c4d$f3277550$d9765ff0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLK5VbO1QXZ22LbQIM9Dq3E2wuv8AGhat+SqTXETrA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 28, 2021 2:12 PM, Felipe Contreras wrote:
>Felipe Contreras wrote:
>> It has been suggested that we "educate our users" to configure less in
>> the right way, instead of colorizing man pages ourselves [1].
>>
>> The question is *how*? Nobody has answered that.
>>
>> This is a continuation of the thread below.
>
>> I am still waiting for an explanation.
>>
>> How does the user properly colorize man pages for both man and git in
>> a way that works in all distributions?
>
>No response.

I think you're looking for something does not exist because it is platform and environment dependent. There are two ways to configure git to work with 'less' on NonStop and neither is identical to Ubuntu or Windows. Don't even get me started on what less does in a TSO/ISPF environment where everything is some single colour on black unless your emulator supports 3279 emulation.

>It's safe to say at this point that nobody knows what that configuration would look like.

Nobody, perhaps, knows how to do this on every platform in the known universe 😊. There is no "one way" to do this consistently everywhere.

In addition, there are many different terminal emulators that end up interacting with git and many do not support vt220 colours. So again, I'm not really sure what can be done.

-Randall


