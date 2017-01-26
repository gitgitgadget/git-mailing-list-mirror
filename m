Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2493A1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbdAZU7A (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 15:59:00 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:57982 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbdAZU65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 15:58:57 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id Wr7Ocvq8jcpskWr7Oc5agv; Thu, 26 Jan 2017 20:58:07 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=WYy5dHOzAAAA:8 a=VwQbUJbxAAAA:8 a=Dmbubk7ILZzpxoy0dFQA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=W1gAy31swDSgSs5wg-Y8:22 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <4B89512D54614F09817EA9901A8B625D@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Cornelius Weig" <cornelius.weig@tngtech.com>
Cc:     "Stefan Beller" <sbeller@google.com>,
        "Johannes Sixt" <j6t@kdbg.org>,
        <bitte.keine.werbung.einwerfen@googlemail.com>,
        <git@vger.kernel.org>, <thomas.braun@virtuell-zuhause.de>,
        "John Keeping" <john@keeping.me.uk>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>        <20170125002116.22111-1-sbeller@google.com>        <33E354BCDB9A4192B69B9B399381659E@PhilipOakley>        <CAGZ79kaRdtKD7DNJRWXsyg07GbTM4OsKUmHHcFczEMJA1YK2KA@mail.gmail.com>        <baff65ba-1e98-d5a7-5b5a-a50a7fc723ee@tngtech.com> <xmqqpoj965yf.fsf@gitster.mtv.corp.google.com>
Subject: Re: SubmittingPatches: drop temporal reference for PGP signing
Date:   Thu, 26 Jan 2017 20:58:07 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfFpfVwJtweEGmDhYWRHkKEtpayN5bSXl4lu1P1xqfeBarwpglVPxliWwJ6dDxCOK/N3gsHnl8QMhsxJ3CZ3nZnjA02+X5a65lSJ2S+2N7kdW464vAN6s
 B5WqPK/J2nFXjKtJft1zWhLvUVLhv1KPG/4IM9GBjuKxcBI/s9XB78JSyThuunjPlIJjuIVKDdvoyOycgOeuMMNGEkoB+Cx1QTSTQjR0n+aFOL32Mn9ulu5T
 kG3OW16NO6K9lWryun+iyDJ753FDMqB+u5SVYYp0K3Q8rT3uEOEaqRpqrTJf7dApN1Foa1l/htHz4aAV6g7bP2Jwj6c8lbdoLnnZnNzjLew2ZHcebU8J53HR
 smkgcobLGllkLsurBmcKf+2Q0f57wqcMFyWTp6QPxW+crlhDmj6996fh5itUPcz8Chmg+14y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Cornelius Weig <cornelius.weig@tngtech.com> writes:
>
>> How about something along these lines? Does the forward reference
>> break the main line of thought too severly?
>
> I find it a bit distracting for those who know PGP signing has
> nothing to do with signing off your patch, but I think that is OK
> because they are not the primary target audience of this part of the
> document.

Agreed. I this case the target audience was those weren't aware of that.
>
> I however am more worried that it may be misleading to mention these
> two in the same sentence.  Those who skim these paragraphs without
> knowing the difference between the two may get a false impression
> that these two may somehow be related because they are mentioned in
> the same sentence.
>
> The retitling of section (5) you did, without any other change,
> might be sufficient.  It may also help to be even more explicit in
> the updated title, i.e. s/by signing off/by adding Signed-off-by:/

Maybe even s/by signing off/by adding your Signed-off-by:/ to be sure that 
the reader knows that it is _their certification_ that is being sought. Even 
if it does double up on the 'your'.

>
> Thanks.
>
>> diff --git a/Documentation/SubmittingPatches 
>> b/Documentation/SubmittingPatches
>> index 08352de..c2b0cbe 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -216,12 +216,12 @@ that it will be postponed.
>>  Exception:  If your mailer is mangling patches then someone may ask
>>  you to re-send them using MIME, that is OK.
>>
>> -Do not PGP sign your patch, at least for now.  Most likely, your
>> -maintainer or other people on the list would not have your PGP
>> -key and would not bother obtaining it anyway.  Your patch is not
>> -judged by who you are; a good patch from an unknown origin has a
>> -far better chance of being accepted than a patch from a known,
>> -respected origin that is done poorly or does incorrect things.
>> +Do not PGP sign your patch, but do sign-off your work as explained in 
>> (5).
>> +Most likely, your maintainer or other people on the list would not have 
>> your
>> +PGP key and would not bother obtaining it anyway. Your patch is not 
>> judged by
>> +who you are; a good patch from an unknown origin has a far better chance 
>> of
>> +being accepted than a patch from a known, respected origin that is done 
>> poorly
>> +or does incorrect things.
>>
>>  If you really really really really want to do a PGP signed
>>  patch, format it as "multipart/signed", not a text/plain message
>> @@ -246,7 +246,7 @@ patch.
>>       *2* The mailing list: git@vger.kernel.org
>>
>>
>> -(5) Sign your work
>> +(5) Certify your work by signing off
>>
>>  To improve tracking of who did what, we've borrowed the
>>  "sign-off" procedure from the Linux kernel project on patches
> 

