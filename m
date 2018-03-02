Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520A61F576
	for <e@80x24.org>; Fri,  2 Mar 2018 11:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946436AbeCBLcM (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 06:32:12 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:28062 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427271AbeCBLbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 06:31:05 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id rityerauRXdHHrityeFm96; Fri, 02 Mar 2018 11:31:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519990263;
        bh=xOlAjKSvn8BvQSFkhjZhhf3X3Z1CsQwjxFf0qhOyifU=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Nw8hb7Lo8PdlWyuREoz3dIuwkiCy2aaKEUC0i7jd8j0PL1cqWhxXScIKe6eVWUWFP
         48INv6oRzwE1YRxoU+a1wq/rPFOVKdyjWH7imnS00Fo7RAn1I4IbLg9fLaEy1nmsEC
         cAZqDHP3wu8QNK5OjvoTQomgiLCfUKpfQulqP9Gw=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=JaySU3CV c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NEAV23lmAAAA:8 a=33R6H_In29s4AGViN7IA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6c8749ca-ec5d-b4b7-f1a0-50d9ad2949a5@talktalk.net>
Date:   Fri, 2 Mar 2018 11:31:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87a7vss6ax.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfK8bWrEXxpdUkJ/R1OwXljrxBNBnK/rc4KYeJ6PTUG51WmZw+AB74Jrwcge+9UsW8hnqTgYEsfAZgGebxNTv/nSG5Bx6Nb7OT9yfE+d9dzIonVwH5xul
 Edt+MbUhcRLGj+P+w32Wxyz4cu05mUlo3XNa9u9EfBvCbuJDuBrzF+MqCb4B06WHfc10bnHZoFTxD6beGwtd3WQvW8X/xxEDAHcxdsTxHWb7wEEq3NhHnwPo
 T2C0aKAKM7gVy8hkZ6SGzUc/vfJ7RCAoN5GpIwFIahGwESPqcE7zryp1GfajoWA5GLOEw6nBgkxkydyW3pbxkvXJm1Cj76ZIArWVZAelnJP0/6nqNDA/qdLQ
 nZcxdrAzj/2MLRqHpsDw8sYF2Z6oGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03/18 05:39, Sergey Organov wrote:
> 
> Hi Igor,
> 
> Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:
> 
>> Hi Sergey,
>>
>> On 28/02/2018 06:19, Sergey Organov wrote:
>>>
>>>>> (3) ---X1---o---o---o---o---o---X2
>>>>>        |\                       |\
>>>>>        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>>>>>        |             \          |
>>>>>        |              M         |
>>>>>        |             /          |
>>>>>        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
>>>>>
>>>>
>>>> Meh, I hope I`m rushing it now, but for example, if we had decided to 
>>>> drop commit A2 during an interactive rebase (so losing A2' from 
>>>> diagram above), wouldn`t U2' still introduce those changes back, once 
>>>> U1' and U2' are merged, being incorrect/unwanted behavior...? :/
>>>
>>> I think the method will handle this nicely.
>>
>> That`s what I thought as well. And then I made a test. And then the 
>> test broke... Now, might be the test was flawed in the first place, 
>> but thinking about it a bit more, it does seem to make sense not to 
>> handle this case nicely :/
> 
> Yeah, I now see it myself. I'm sorry for being lazy and not inspecting
> this more carefully in the first place.
> 
> [...]
> 
>> So while your original proposal currently seems like it could be 
>> working nicely for non-interactive rebase (and might be some simpler 
>> interactive ones), now hitting/acknowledging its first real use 
>> limit, my additional quick attempt[1] just tries to aid pretty 
>> interesting case of complicated interactive rebase, too, where we 
>> might be able to do better as well, still using you original proposal 
>> as a base idea :)
> 
> Yes, thank you for pushing me back to reality! :-) The work and thoughts
> you are putting into solving the puzzle are greatly appreciated!
> 
> Thinking about it overnight, I now suspect that original proposal had a
> mistake in the final merge step. I think that what you did is a way to
> fix it, and I want to try to figure what exactly was wrong in the
> original proposal and to find simpler way of doing it right.
> 
> The likely solution is to use original UM as a merge-base for final
> 3-way merge of U1' and U2', but I'm not sure yet. Sounds pretty natural
> though, as that's exactly UM from which both U1' and U2' have diverged
> due to rebasing and other history editing.

Hi Sergey, I've been following this discussion from the sidelines,
though I haven't had time to study all the posts in this thread in
detail. I wonder if it would be helpful to think of rebasing a merge as
merging the changes in the parents due to the rebase back into the
original merge. So for a merge M with parents A B C that are rebased to
A' B' C' the rebased merge M' would be constructed by (ignoring shell
quoting issues)

git checkout --detach M
git merge-recursive A -- M A'
tree=$(git write-tree)
git merge-recursive B -- $tree B'
tree=$(git write-tree)
git merge-recursive C -- $tree C'
tree=$(git write-tree)
M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB' -pC')

This should pull in all the changes from the parents while preserving
any evil conflict resolution in the original merge. It superficially
reminds me of incremental merging [1] but it's so long since I looked at
that I'm not sure if there are any significant similarities.

Best Wishes

Phillip

[1] https://github.com/mhagger/git-imerge

