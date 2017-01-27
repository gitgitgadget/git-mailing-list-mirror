Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20F61F6DC
	for <e@80x24.org>; Fri, 27 Jan 2017 10:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932711AbdA0Ktc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 27 Jan 2017 05:49:32 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:14436 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932718AbdA0Kta (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 05:49:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 6A85A1E1877;
        Fri, 27 Jan 2017 11:49:27 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CaVuWQO-SW1T; Fri, 27 Jan 2017 11:49:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 053541E2E13;
        Fri, 27 Jan 2017 11:49:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZlFvDTAtYqqz; Fri, 27 Jan 2017 11:49:26 +0100 (CET)
Received: from [192.168.178.64] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 924711E1877;
        Fri, 27 Jan 2017 11:49:26 +0100 (CET)
Subject: Re: SubmittingPatches: drop temporal reference for PGP signing
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
References: <923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com>
 <20170125002116.22111-1-sbeller@google.com>
 <33E354BCDB9A4192B69B9B399381659E@PhilipOakley>
 <CAGZ79kaRdtKD7DNJRWXsyg07GbTM4OsKUmHHcFczEMJA1YK2KA@mail.gmail.com>
 <baff65ba-1e98-d5a7-5b5a-a50a7fc723ee@tngtech.com>
 <xmqqpoj965yf.fsf@gitster.mtv.corp.google.com>
 <4B89512D54614F09817EA9901A8B625D@PhilipOakley>
Cc:     Stefan Beller <sbeller@google.com>, Johannes Sixt <j6t@kdbg.org>,
        bitte.keine.werbung.einwerfen@googlemail.com, git@vger.kernel.org
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <60e9abdf-cc37-33d8-e7eb-8a3370ffe1cc@tngtech.com>
Date:   Fri, 27 Jan 2017 11:49:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <4B89512D54614F09817EA9901A8B625D@PhilipOakley>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/26/2017 09:58 PM, Philip Oakley wrote:
> From: "Junio C Hamano" <gitster@pobox.com>
>> Cornelius Weig <cornelius.weig@tngtech.com> writes:
>>
>>> How about something along these lines? Does the forward reference
>>> break the main line of thought too severly?
>>
>> I find it a bit distracting for those who know PGP signing has
>> nothing to do with signing off your patch, but I think that is OK
>> because they are not the primary target audience of this part of the
>> document.
> 
> Agreed. I this case the target audience was those weren't aware of that.

Yes, maybe the forward reference does give a wrong hint about a
connection between sign-off and pgp-signing. However, I would still vote
for the following change suggested by sbeller@google.com:

-Do not PGP sign your patch, -at least for now-. Most likely, your (...)
+Do not PGP sign your patch. Most likely, your maintainer or other (...)


> 
> Maybe even s/by signing off/by adding your Signed-off-by:/ to be sure
> that the reader knows that it is _their certification_ that is being
> sought. Even if it does double up on the 'your'.
> 

I don't think doubling on the 'your' will make the heading clearer. The
main intention of this change is to avoid mixups with pgp-signing and
that would IMHO not improve by that.
Besides, I find the colon in the heading a bit awkward. Is the following
version as expressive as with the colon?

-(5) Sign your work
+(5) Certify your work by adding Signed-off-by
