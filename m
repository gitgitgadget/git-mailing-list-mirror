Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F1B1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 23:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754987AbeCGXeS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 18:34:18 -0500
Received: from mail.netzguerilla.net ([217.11.57.120]:53113 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754983AbeCGXeR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 18:34:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 6FEF9100019;
        Thu,  8 Mar 2018 00:34:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netzguerilla.net
Received: from mail.netzguerilla.net ([IPv6:2a00:1828:2000:612::25])
        by localhost (sal.netzguerilla.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id hajAy-ff9ZtO; Thu,  8 Mar 2018 00:34:15 +0100 (CET)
Received: from [IPv6:2003:dd:ff29:a301:1c94:69ca:ad13:165a] (p200300DDFF29A3011C9469CAAD13165A.dip0.t-ipconnect.de [IPv6:2003:dd:ff29:a301:1c94:69ca:ad13:165a])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id D4705100012;
        Thu,  8 Mar 2018 00:34:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=projektwerkstatt.de;
        s=fckp; t=1520465654;
        bh=PU3r2kIAmul/wYAemF6Jn60Ph83qfyxwiCznZEcQF64=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aSgL5gYaK5cBgRSrKudqU7LCmHtRCeIrNJgI3i1uudpYDM8a+x7wCJBIs8HNYLIbU
         savkfNBmHftvljiP5PjVjwkehYjjfZJz0u/3H+Mg3ve+HGo2rqyNL0hyh0KYPbbJEq
         M68YVOr+MhW/idm6i0fKsu8eCINBD3hSfNxrinKJys/qQbjMkBSdTWGunomxv30YTd
         KjYvHrOU6hy5eRC7MLn59fdwQc/o+KE8navL6cEiNxDsG2d5VBn3nQRsmBiLU5F7AJ
         yJV/UEFAXB3NgXhXQcxkiXHZh/+zbX7Z+j4oBkG0BSvpRS7yR2PG81UEPeU9le2AyT
         I7Hou7wU1QsZA==
Subject: Re: git help clone: questions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <6ea2b41f-37c3-8540-4763-7688f56fe202@projektwerkstatt.de>
 <xmqqinaa6l3b.fsf@gitster-ct.c.googlers.com>
 <81c78c4f-b690-d06c-bb7d-9c65e33777b5@projektwerkstatt.de>
 <xmqq4llrzer5.fsf@gitster-ct.c.googlers.com>
From:   kalle <kalle@projektwerkstatt.de>
Message-ID: <725671ac-0a36-cd9e-c605-6ffdcb7e9a33@projektwerkstatt.de>
Date:   Thu, 8 Mar 2018 00:34:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqq4llrzer5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Am 07.03.2018 um 23:45 schrieb Junio C Hamano:
> kalle <kalle@projektwerkstatt.de> writes:
> 
>> Am 06.03.2018 um 02:36 schrieb Junio C Hamano:
>>> kalle <kalle@projektwerkstatt.de> writes:
>>>
>>>> -In the explanation of the option --reference: shouldn't there be
>>>> written '<repository>' instead of  'reference repository'?
>>>
>>> "Shouldn't X be Y?" is not an effective way to communicate; it
>>> solicits a "no, the current one is fine." without any explanation.
>>>
>>> If you think X should be Y for some reason, please say "I think X
>>> should be Y BECAUSE Z" instead.  Without stating why you think
>>> differently from what those who wrote the current text, it is hard
>>> for people to respond either with "Yeah, you're right---I agree
>>> with Z" or with "No, Z does not hold because..."
>>>
>> I wrote this, because when it is written about 'reference repository', I
>> consider it not totally clear, which repository is meant, as the option
>> '--reference <repository>' only names one as <repository>.
>> For reasons of clearness, I now propose writing "reference repository
>> <repository>".
> 
> I do not have particularly a strong opinion, but I think it is very
> sensible to call the value given to the option "--reference" with a
> phrase that is not just "repository".
i agree and didn't state this. i proposed to add <repository>.
<repository> could also be named <reference-repository>.
> 
> As the command line of "clone" must name one repository (i.e. the
> one which we clone from), and its "--reference" option must name
> another repository as its value (i.e. the one that we borrow from in
> order to reduce the object transfer), calling both <repository>
> makes it easier to confuse readers

you made my point

 unless the writer carefully makes
> sure that <repository> in the desription is unambiguous and it is
> clear which one of these two repositories is being discussed by the
> context.>
> I just re-read the existing Documentation/git-clone.txt and looked
> for "reference".  All uses of "reference repository" in the prose
> made sense and I found it would not be an improvement if any of them
> is replaced with just "repository". 

This was never my proposal, though.

 It may be helpful to add
> something like:
> 
> 	 --reference[-if-able] <repository>::
> 	+	Define a repository (reference repository) to borrow
> 	+	objects from.  
> 		If the reference repository is on the local machine,
> 		...
> 
> to define which repository we mean by that term, though.
> 

in all, it was just meant as a quite small proposal for me. i also don't
have any strong opinion about it.
greetings,
kalle
