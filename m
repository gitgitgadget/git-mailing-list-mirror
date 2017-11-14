Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D541F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 16:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755821AbdKNQDk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 11:03:40 -0500
Received: from smtp74.iad3a.emailsrvr.com ([173.203.187.74]:37304 "EHLO
        smtp74.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755865AbdKNQDc (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2017 11:03:32 -0500
Received: from smtp18.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp18.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 932E6251B1;
        Tue, 14 Nov 2017 11:03:31 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp18.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 5B9EF25490;
        Tue, 14 Nov 2017 11:03:31 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 14 Nov 2017 11:03:31 -0500
Subject: Re: [PATCH V2] config: add --expiry-date
To:     Christian Couder <christian.couder@gmail.com>, hsed@unimetic.com
References: <20171112145535.gb4nafdhhdslknex@sigill.intra.peff.net>
 <1510625073-8842-1-git-send-email-hsed@unimetic.com>
 <CAP8UFD3TbmZ3bRwg-fRoSJWAFaa=UDxVsZphn_3Nt4wMz1N2=A@mail.gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <efc9cace-343a-4475-714c-85b499b9f9c9@xiplink.com>
Date:   Tue, 14 Nov 2017 11:03:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3TbmZ3bRwg-fRoSJWAFaa=UDxVsZphn_3Nt4wMz1N2=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-14 01:21 AM, Christian Couder wrote:
> On Tue, Nov 14, 2017 at 3:04 AM,  <hsed@unimetic.com> wrote:
>> From: Haaris <hsed@unimetic.com>
>>
>> Description:
>> This patch adds a new option to the config command.
>>
>> Uses flag --expiry-date as a data-type to covert date-strings to
>> timestamps when reading from config files (GET).
>> This flag is ignored on write (SET) because the date-string is stored in
>> config without performing any normalization.
>>
>> Creates a few test cases and documentation since its a new feature.
>>
>> Motivation:
>> A parse_expiry_date() function already existed for api calls,
>> this patch simply allows the function to be used from the command line.
>>
>> Signed-off-by: Haaris <hsed@unimetic.com>
> 
> Documentation/SubmittingPatches contains the following:
> 
> "Also notice that a real name is used in the Signed-off-by: line. Please
> don't hide your real name."
> 
> And there is the following example before that:
> 
>          Signed-off-by: Random J Developer <random@developer.example.org>
> 
> So it looks like "a real name" actually means "a real firstname and a
> real surname".
> 
> It would be nice if your "Signed-off-by:" could match this format.

It might already match that format if Haaris lives in a society that 
only uses single names.

Still, such names are unusual enough that it's good to check that new 
contributors are following the guidelines properly.

		M.


> Also if you have a "From:" line at the beginning of the patch, please
> make sure that the name there is tha same as on the "Signed-off-by:".
> 
> Thanks for working on this,
> Christian.
> 
