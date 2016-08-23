Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6933B1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 14:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933350AbcHWOsO (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 10:48:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51437 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933335AbcHWOsM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 10:48:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5CBC620AB7;
        Tue, 23 Aug 2016 10:41:09 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 23 Aug 2016 10:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=QjMpAqpYuOwni9o8pdI72TzwUW8=; b=lu6KUZ
        g12ykJ/aY/2kO8yPS/5QpEzMMp7+u4+K/6XHvWEbhP5+edivcGfJLJVYNQ/li2C8
        TFGCGPc3OTIM2+ABjqP0srn8oyPAPnytlyXlJ1f6+bYydS9QqFbtNcaGzROhWZVH
        HHd6G+7k9dUNzxWWI6bu0yFmbk5RP8yXZyGys=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=QjMpAqpYuOwni9o
        8pdI72TzwUW8=; b=G7tdCSGuOynIic8zTLRdFzgOpJFp8pYSWqfE0kL7LC27gMl
        +1u+pSiOziyEUxuJ+ROdo6KCkHHwEwILl/3ss2/XXVujVRROnMoFUFn5siZaVqiw
        xXarGiBXuOZdeXM8qdTofEgeXWuFu4Ov5EUtB883ZwDHaoas2OmLky4nrE2k=
X-Sasl-enc: kBCy4ewh3YlPeuDFjWFhuz8QHVjeJ937ed5bcooCO8GI 1471963269
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 931A1CC07A;
        Tue, 23 Aug 2016 10:41:08 -0400 (EDT)
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
 <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608171507530.4924@virtualbox>
 <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com>
 <alpine.DEB.2.20.1608231553030.4924@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net>
Date:   Tue, 23 Aug 2016 16:41:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608231553030.4924@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin venit, vidit, dixit 23.08.2016 15:54:
> Hi Duy,
> 
> On Mon, 22 Aug 2016, Duy Nguyen wrote:
> 
>> On Thu, Aug 18, 2016 at 3:37 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> Hi Junio,
>>>
>>> On Wed, 17 Aug 2016, Junio C Hamano wrote:
>>>
>>>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>>
>>>>>> And then your "git cat-file" patch can be upstreamed with the option
>>>>>> renamed to (or with an additional synonym) "--filters", which would make
>>>>>> things consistent.
>>>>>
>>>>> Right. I would like to ask for a `--smudge` synonym nevertheless, just
>>>>> because I already use this. On the other hand, it is early enough to tell
>>>>> everybody who knows about this feature to change their invocation (anybody
>>>>> who would know about `--smudge` would be in that 1% of users that have
>>>>> read the release notes, so most likely would read the next release notes,
>>>>> too).
>>>>
>>>> It is OK if it were your private edition, but you end up hurting
>>>> your users if you need to redo the feature differently.
>>>
>>> Unfortunately, this is the situation of Git for Windows from its
>>> beginning: there has not been a single time that Git for Windows could
>>> live with unpatched upstream Git's source code.
>>>
>>> Business as usual, though.
>>
>> Bug fixes is one thing, features is completely different.
> 
> Oh? Completely?
> 
> So the core.hideDotFiles feature should have forced me to rename Git for
> Windows to, say, DschoGit on Windows?
> 
> Let's just stop here. This is getting too silly.

I see more truth than silliness in Duy's suggestion. Maybe you want to
re-read what you wrote to trigger his response, and consider adjusting
your attitude ("I want this now so I'll release it in Git4Win") rather
than the downstream name.

Michael

