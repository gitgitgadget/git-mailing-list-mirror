Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7090C1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752918AbcH2T2C (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:28:02 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:31090 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbcH2T2B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:28:01 -0400
Received: from PhilipOakley ([92.22.69.87])
        by smtp.talktalk.net with SMTP
        id eSDub8c4Q0KuveSDubSazh; Mon, 29 Aug 2016 20:27:59 +0100
X-Originating-IP: [92.22.69.87]
X-Spam: 0
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 a=k13/KP3EArOifh1i87jfLg==:117
 a=k13/KP3EArOifh1i87jfLg==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=tc7_YpkztbqjWWBHSuoA:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <CAF6B88428814389927F9639882BA481@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "GitList" <git@vger.kernel.org>,
        "Junio C Hamano" <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
References: <20160720211007.5520-1-philipoakley@iee.org> <20160812070749.2920-1-philipoakley@iee.org> <20160812070749.2920-10-philipoakley@iee.org> <494c1bd2-19c8-e2af-da1c-ff1331f91c4f@gmail.com> <EDA7BA88AB1D42C7B4228D71CC28145B@PhilipOakley> <557eb782-ee45-3e33-33bb-aa88817dcd82@gmail.com>
Subject: Re: [PATCH v5 09/12] doc: revisions - define `reachable`
Date:   Mon, 29 Aug 2016 20:27:58 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfLg7wvMER32COZxKclQe017VJk4Xa8ruTAMae3jBOKDBH5w1h/Jn1ph/gvzO7lVUHmCmtoEzZbkWDDc2KeHFfDAqRp7m8tiHHDI/EY09Wqexr2k+9hBM
 lOEf1d4lz2RH0aMIApLI6ADzFuvYYilEdg3+MusTIc85hOzD8tkIv+lzEl01bHRBXqarS10cE74IOmQsXrLuk/o+V1Fd5GlBGCsgWM/ZygOmhZJUZ/wo2pX8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jakub Narębski" <jnareb@gmail.com>
>W dniu 29.08.2016 o 15:21, Philip Oakley pisze:
>> From: "Jakub Narębski" <jnareb@gmail.com>
>> Sent: Sunday, August 28, 2016 2:01 PM
>>> W dniu 12.08.2016 o 09:07, Philip Oakley pisze:
> [...]
>
>>>> +For these commands,
>>>> +specifying a single revision, using the notation described in the
>>>> +previous section, means the set of commits `reachable` from the given
>>>> +commit.
> [...]
>>>> +
>>>> +A commit's reachable set is the commit itself and the commits in
>>>> +its ancestry chain.
>>>> +
>>>
>>> It is all right, but perhaps it would be better to just repeat:
>>>
>>>  +Set of commits reachable from given commit is the commit itself
>>>  +and all the commits in its ancestry chain.
>>
>> It's very easy to go around in circles here. The original issue was
>> the A..B notation for the case where A is a direct descendant of B,
>> such that new users, or users more familiar with range notations from
>> elsewhere, would expect that the A..B range is *inclusive*, rather
>> than an open / closed interval. It was the addressing of that problem
>> that lead to the updating of the 'reachability' definition.
>
> All right, I can see that.  It is a worthwhile goal.
>
>> The main part of my sentence formation was to make the 'reachable'
>> part the defining element, rather than being a feature of the set.
>> Maybe it's using the 'set' viewpoint that is distracting?>>
>
> One one hand, the "A commit's reachable set is ..." approach puts
> 'reachable' upfront.  On the other hand it introduces new terminology,
> namely 'reachable set' (or 'reachable set of a commit' to be more
> exact)...  it doesn't read that well to me, but I am not a native
> speaker.
>
> But as I wrote, this is quite all right anyway
> -- 
> Jakub Narębski
--
Thanks.

Philip 

