Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3B420374
	for <e@80x24.org>; Mon, 22 Apr 2019 01:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfDVBdE (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 21:33:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45117 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbfDVBdE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Apr 2019 21:33:04 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 249D921B5A;
        Sun, 21 Apr 2019 21:33:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 21 Apr 2019 21:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=qwhU+b6tPyfE2SQtb2vzJkTe2noWZgWdeP2IGP9Zv
        /8=; b=XSMcoO1MDrf+ibMmzXz1v1qV1JSxbPqvd1BTmS2xwu2mkPIx2bN35kCJY
        RbQmCSuikggEL2Dz/HH10OZffZ2OiKe76lDlw1lZX0OTuCANiX0yZDF8/g6JQRWK
        bvrBL8o9J5gyj1I+La5DVYfVcTqaq03j0NbyJC6k6oaSSdean9BmGh3ojb+ye6V7
        VB0NBi2Cawbb1J+nI/YiE71VGaSHsQRjSY69VS/3etq/LgBwuxuKl54VuwxOPzLQ
        IgkdPvQUoXkE5UqgMoWY9o2ylO1NfbfMLaXP7HhVqTiUXqacjgrmYQkBr0BCvPvp
        pAzqxkJNbsXLqpFx7CQ8c6tzNQX9w==
X-ME-Sender: <xms:zhm9XB_RIU6x5n3o68X_NyC5cjbM7vP1WU2V_C7isv9XV_0Xn7Dx9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeehgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuhffvfhfkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeetnhgurhgv
    ficulfgrnhhkvgcuoehflhhoshhssegrphhjrghnkhgvrdhnvghtqeenucffohhmrghinh
    epghhithhhuhgsrdgtohhmpdhpuhgslhhitgdqihhnsghogidrohhrghenucfkphepieej
    rddvgeehrddvvdeirdeffeenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesrg
    hpjhgrnhhkvgdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:zhm9XDPHycqvXdom8cJugUYIJx56Swsrt95lrH6yqqxaV3SULsVuvQ>
    <xmx:zhm9XBqWqxstZFr5pd1tOP7BXi7xWw3M1AvRr5AIQOJ3WZZHavDemw>
    <xmx:zhm9XK6SWaQ9P_sQdYPb07-W-XX9IiQ-g9aLR2JJPPqaqqu0T2kwig>
    <xmx:zxm9XIVGRwQDffm6Zf4qXS_P5nK4RJDacRU3rCCWnpkREQ7SIexXCQ>
Received: from angharad.local (cpe-67-245-226-33.nyc.res.rr.com [67.245.226.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C2F6E4382;
        Sun, 21 Apr 2019 21:33:02 -0400 (EDT)
Subject: Re: gettext, multiple Preferred languages, and English
From:   Andrew Janke <floss@apjanke.net>
To:     Philip Oakley <philipoakley@talktalk.net>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>
References: <d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net>
 <bd5ee770-a213-b663-208c-c9980a738fe9@talktalk.net>
 <ffac5d4b-190c-16d6-497c-4b0f1f12115c@apjanke.net>
Openpgp: preference=signencrypt
Autocrypt: addr=floss@apjanke.net; prefer-encrypt=mutual;
 keydata= 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
Message-ID: <56e1db44-cc87-ec0c-6466-826c633ff103@apjanke.net>
Date:   Sun, 21 Apr 2019 21:33:01 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ffac5d4b-190c-16d6-497c-4b0f1f12115c@apjanke.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/21/19 9:27 AM, Andrew Janke wrote:
> 
> On 4/21/19 8:59 AM, Philip Oakley wrote:
>> Hi Andrew,
>>
>> On 21/04/2019 12:08, Andrew Janke wrote:
>> https://public-inbox.org/git/d001a2b5-57c3-1eb3-70fd-679919bb2eb6@apjanke.net/
>>
>>> I don't think it would even have
>>> to be actively maintained, because for new message strings that aren't
>>> included in the .po file, it would fall back to the non-translated input
>>> strings, which are in English anyway, which is the desired behavior.
>> Given the above comment, could the en.po file
>> (https://github.com/apjanke/git/blob/english-dummy-translation/po/en.po)
>> be some very very short version with only one 'translated' string?
> 
> Yes, I believe so. I only provided a full translation file because it
> was trivial for me to create using the "msginit" instructions I found in
> po/README. Since all the translations are just identity relationships, I
> believe that is effectively the same as their not being there in the
> first place.
> 
> I tested your approach locally, and it seems to work for me.

BTW, here's a branch with just the "stub" translation file:

https://github.com/apjanke/git/tree/english-dummy-translation-stub

Cheers,
Andrew
