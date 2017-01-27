Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 755301F437
	for <e@80x24.org>; Fri, 27 Jan 2017 21:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbdA0Vn4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 16:43:56 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:4175 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdA0Vnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 16:43:53 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id XEDrcxUJA46SJXEDrclD7p; Fri, 27 Jan 2017 21:38:20 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=WYy5dHOzAAAA:8 a=ybZZDoGAAAAA:8 a=xtxXYLxNAAAA:8 a=VwQbUJbxAAAA:8
 a=lOwrrXfSciMw4G46FVQA:9 a=QEXdDO2ut3YA:10 a=nJcEw6yWrPvoIXZ49MH8:22
 a=W1gAy31swDSgSs5wg-Y8:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <F290D7175C2C4E728A7A3C767F5B80BF@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>,
        "Cornelius Weig" <cornelius.weig@tngtech.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
References: <20170127200136.29949-1-cornelius.weig@tngtech.com> <CAGZ79kb29usw4WyMdy3c5-rGH1nEcQ1gUabzdAtGgOW9zfTCDA@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify distinction between sign-off and pgp-signing
Date:   Fri, 27 Jan 2017 21:38:19 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOT+zuWOYnHYOMSo1MX0osWu9eNhvRLvTQ69r+GNqsb+yzrNn0Ygq6sq/sqtnZ5Sxq3fPbP92qiReTv9schMCpJtRj8PFOrRhj3wCByCOp8QtIRE332s
 7c8INXek7hLpM/OOoNC/r0kQT4VJ5lmMsZ2gzz7HpmJBuyKjdepUlQXwKOUT3pcN8R0Dio7/PAMrFSb2aQ57JAV11o9qTUSmi489yesOrKqjvM0Cch37wT+U
 0ER2shbZNnaXTCGhSvSkvX16ADB42l9kk4MyDtrTeO8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
> On Fri, Jan 27, 2017 at 12:01 PM,  <cornelius.weig@tngtech.com> wrote:
>> From: Cornelius Weig <cornelius.weig@tngtech.com>
>>
>> The documentation for submission discourages pgp-signing, but demands
>> a proper sign-off by contributors. However, when skimming the headings,
>> the wording of the section for sign-off could mistakenly be understood
>> as concerning pgp-signing. Thus, new contributors could oversee the
>> necessary sign-off.
>>
>> This commit improves the wording such that the section about sign-off
>> cannot be misunderstood as pgp-signing. In addition, the paragraph about
>> pgp-signing is changed such that it avoids the impression that
>> pgp-signing could be relevant at later stages of the submission.
>>
>> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>     This patch summarizes the suggested changes.
>>
>>     As I don't know what is appropriate, I took the liberty to add 
>> everybody's
>>     sign-off who was involved in the discussion in alphabetic order.
>
> Heh, my first though was to conclude you haven't read the
> sign off part, yet apart from the changed header.
> /me goes back and actually reads the DCO again.
> And actually these sign offs were there in other patches in this area,
> so you'd claim (a) that yours was just created partly by you and having
> other patches that were also signed off (b), whose sign offs you
> merely copy over to here.
>
> And then after reading I realized I slightly confused the signing
> myself as the sign offs are also used to track the flow of a patch.
> These sign offs suggest that you made the patch initially, then
> passed it to Junio, then to Philip and then to me.
> And Junio will sign it again when applying the patch.
>
> So maybe s/signed-off-by/helped-by/?

Helped-by: Philip Oakley <philipoakley@iee.org>

is sufficient for me (if that).
>
> The patch with the aggregation looks good to me.
>
> Thanks,
> Stefan
>
>>
>>  Documentation/SubmittingPatches | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/SubmittingPatches 
>> b/Documentation/SubmittingPatches
>> index 08352de..3faf7eb 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -216,12 +216,11 @@ that it will be postponed.
>>  Exception:  If your mailer is mangling patches then someone may ask
>>  you to re-send them using MIME, that is OK.
>>
>> -Do not PGP sign your patch, at least for now.  Most likely, your
>> -maintainer or other people on the list would not have your PGP
>> -key and would not bother obtaining it anyway.  Your patch is not
>> -judged by who you are; a good patch from an unknown origin has a
>> -far better chance of being accepted than a patch from a known,
>> -respected origin that is done poorly or does incorrect things.
>> +Do not PGP sign your patch. Most likely, your maintainer or other people 
>> on the
>> +list would not have your PGP key and would not bother obtaining it 
>> anyway.
>> +Your patch is not judged by who you are; a good patch from an unknown 
>> origin
>> +has a far better chance of being accepted than a patch from a known, 
>> respected
>> +origin that is done poorly or does incorrect things.
>>
>>  If you really really really really want to do a PGP signed
>>  patch, format it as "multipart/signed", not a text/plain message
>> @@ -246,7 +245,7 @@ patch.
>>       *2* The mailing list: git@vger.kernel.org
>>
>>
>> -(5) Sign your work
>> +(5) Certify your work by adding your "Signed-off-by: " line
>>
>>  To improve tracking of who did what, we've borrowed the
>>  "sign-off" procedure from the Linux kernel project on patches
>> --
>> 2.10.2
>>
> 

