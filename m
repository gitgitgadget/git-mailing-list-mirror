Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CE051F453
	for <e@80x24.org>; Mon,  1 Oct 2018 21:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbeJBER3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 00:17:29 -0400
Received: from mout.web.de ([212.227.17.11]:45911 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeJBER3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 00:17:29 -0400
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrJwm-1fjyQi0g5E-0135LI; Mon, 01
 Oct 2018 23:37:32 +0200
Received: from [192.168.178.36] ([91.20.58.167]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrJwm-1fjyQi0g5E-0135LI; Mon, 01
 Oct 2018 23:37:32 +0200
Subject: Re: What's cooking in git.git (Sep 2018, #04; Thu, 20)
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
 <c5f7009b-53b5-26b9-8a01-b8648ee33a15@web.de>
 <20181001201202.GA10234@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bf40fe3e-20f5-456b-b800-b655a2aadb4d@web.de>
Date:   Mon, 1 Oct 2018 23:37:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181001201202.GA10234@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hDnPhHu0AKBZEF8OC6Vz/IEVCHwDg0xBpNK2OzjQ0mJ0Xlt3g54
 9uK7JXTrVFcaMQo4uGN5/RAEzCTm5p4rfMdIbnmgO4QV8Ng3EkbcAxRm1pK78+NWg4MQnPE
 49KD6mDE61MwYLtwqDt242revFPb6JRN1C4rWjLeor5wHZeC04lg9PcXDqHjw9UYXOWFLSL
 6hJfd3hEK1AycQeDW4Z1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6ds+p3qV7co=:kabuqwgzWTkL/LWNsqGAw2
 YML6Amhc1SbtWDH1biAUVLbaVBnVcEH57AriLhcPjZStZoMbc0AHC8J9xkF4203uiiiLrpgHP
 zWR3+UIhMOpiEKw09u1WwNoKXRNaqevz5S+EBUaJr5mgu7xc/KmCY8SV1MVxh3ibTwiOnEAvO
 SuqbUqEawKICDUb2SPrFaGOn1dd2kvtIJNOvm0nSmjGcHuF0ZUZzl8oLer93BWWoCf0NXFPLF
 i6ICE4WEKOf+Lb+ueomwdrxR0zhttjHrNj8LRnwjpS+X4Iv5EY/gfq9vv2oNoUawZRHIGVIap
 EPxcN9ED9O3Zan8eVMZnkzu4WrQ4TJHHXUrcmofv2o8Sb0mQmjf8YXk7Op/wZYQG4hnNZS6GV
 1Y+fRRWU/Cg6xJmLYlB00nIwLb9h8aTdkJ2UxT4TQsZfs+42yLUKIVTnxncwv/VNNMuTzdue8
 5XUZ0xN4wizSx5lxc3NLDCHegxYssbhDsKrDlmoedgB2nk+Q8RIVo3tAsPtaaWg+qzEbJ505K
 qeXN+V41bSiFc1A9h0xkvJntw3FCSI5oQojbL+oH7VaMhYvELftx6jFIOf98bUMg1EBrEINRc
 uQskGwqcb7dePG74lrDcjWWPeq1pC+WGR/h2RM4viqg7hdWlfKapitm84HdE9gXZjFNsDdrMa
 bz9nWYG6whpr+oZVTpj3V6hH5pXzB3XxXi9QTL44Up2ZtK39o6SXNT80CQvG8cAX9pVFt+MJU
 43unqyEYav0Z54dDtEtpXtoJQGuLTBNzKuNsl8i4UIZhiUupvEFuR2pPG0mBJ8PlMy0vkKgE2
 0Vdew3E52A6poeqGD1Rhru4LcfaPzJQwx5UL582PmaExGSlAdE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.10.2018 um 22:12 schrieb Jeff King:
> On Mon, Oct 01, 2018 at 09:16:07PM +0200, René Scharfe wrote:
> 
>> Am 21.09.2018 um 07:22 schrieb Junio C Hamano:
>>> * cc/delta-islands (2018-08-16) 7 commits
>> [...]
>>> * jk/pack-delta-reuse-with-bitmap (2018-08-21) 6 commits
>>
>> Not sure if it's the interaction of the two topics or if only one of
>> them is to blame, but the result of the merge can dereference a NULL
>> pointer.  Found using Clang's UBSan and t5310.
>>
>> Here's a patch that avoids the issue, but I don't know if it's the
>> right thing to do -- should we rather treat a non-existing base as
>> "not from the same island" instead?
>>
>> And it's certainly ugly -- that condition is complicated enough
>> already.  Splitting it up in a nice way would probably help, but how?
> 
> Perhaps like in 2fa233a554 (pack-objects: handle island check for
> "external" delta base, 2018-09-18)?

Perhaps indeed. ;-)  That patch looks exactly like the fix I wished for,
and then some.  I'm just not fully sure about the added branch for the
combination of the two features, because I don't know either of them in
depth.

René
