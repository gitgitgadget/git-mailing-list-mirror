Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ACF5202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 18:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbdKTSTL (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 13:19:11 -0500
Received: from e1i183.smtp2go.com ([103.36.108.183]:33512 "EHLO
        e1i183.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbdKTSTK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 13:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1511202850; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Subject:To:From:Reply-To:Message-ID:Sender:
        List-Unsubscribe; bh=eCQj1g6g5JN9tG3ofQ/CaTT1acGKb/AP4CQBCisGopo=; b=R2BZwKAn
        MIMHLj8ruYtkfIg/0/YzQw9581gM+GyHbSd6fMYKIN03msqa0kpWp5b/sWxghZXNroMahFdacuKy4
        ZnfhzRYwq+ZmWwRja5ngiEAfa9mC4HISpzQgiGYnTKZ3LtWWtSBRw0lnztgEopnurGvrDWaA3Uzk+
        z+yJjHC73ppoX58hzf6B7ipHnS1s98xUyNUSLH0WQIiYXJHfBQRpea62PjYR+g1PgheoNPqAIMX9K
        R8i0hY3MOIZs7f9vEa/xKiYCDvQadVEjb67cjOaa/CWgUiJyKDfVqL58jbGWFRA2OC0sWBKijPYOR
        GHsSJ30E3CSSOPrPiGIubjbPSA==;
Message-ID: <B89FAB6895F940EBA45554F20184302F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Philip Oakley" <philipoakley@iee.org>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     "Stefan Beller" <sbeller@google.com>, "git" <git@vger.kernel.org>,
        "Kevin Daudt" <me@ikke.info>,
        "Jacob Keller" <jacob.keller@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <20171028004419.10139-1-sbeller@google.com><20171031003351.22341-1-sbeller@google.com><20171031003351.22341-7-sbeller@google.com><xmqqinevzvel.fsf@gitster.mtv.corp.google.com><CAGZ79kYO=4SWzfKY6bU8Spn5Ubw39ghOH6wanFhFEsKD8q9vrA@mail.gmail.com><xmqq4lqewu2b.fsf@gitster.mtv.corp.google.com><CAGZ79kYC4=rDSWC7WCGVL4n4OC8BpvMJFwxx+LV9GqoGnSHFSA@mail.gmail.com><xmqqinetsayr.fsf@gitster.mtv.corp.google.com><xmqq375xs3zr.fsf@gitster.mtv.corp.google.com><BFE987312194406AAAEA8DAC7EC5BFF5@PhilipOakley><xmqqlgjlkzmm.fsf@gitster.mtv.corp.google.com><D199FB1260C4462ABFC1F0F77D26EF06@PhilipOakley><CAGZ79kYRunzS9vDO=Zk1jQk1BvwJomN5+=1gQi0aDau_qbamew@mail.gmail.com><54073F7B0C9E49C4BA55CA97A605A724@PhilipOakley> <xmqqo9obhqo0.fsf@gitster.mtv.corp.google.com> <205BDB5638F64690AF6BE91360CE155E@PhilipOakley>
Subject: Re: [PATCH 6/7] builtin/describe.c: describe a blob
Date:   Mon, 20 Nov 2017 18:18:51 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Smtpcorp-Track: 1-Gq-i9EFQiS9y.EzymrxhL1
Feedback-ID: 66524m:66524aMf6O2Y:66524sajhSw-HGc:SMTPCORP
X-Report-Abuse: Please forward a copy of this message, including all
 headers, to <abuse-contact@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Philip Oakley" <philipoakley@iee.org>

s/with/without/  ...

> From: "Junio C Hamano" <gitster@pobox.com>
> : Friday, November 10, 2017 1:24 AM
> [catch up]
>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> From: "Stefan Beller" <sbeller@google.com>
>>>> Rereading this discussion, there is currently no urgent thing to 
>>>> address?
>>>
>>> True.
>>>
>>>> Then the state as announced by the last cooking email, to just cook
>>>> it, seems
>>>> about right and we'll wait for further feedback.
>>
>> A shiny new toy that is not a fix for a grave bug is rarely urgent,
>> so with that criterion, we'd end up with hundreds of topics not in
>> 'next' but in 'pu' waiting for the original contributor to get out
>> of his or her procrastination, which certainly is not what I want to
>> see, as I'd have to throw them into the Stalled bin and then
>> eventually discard them, while having to worry about possible
>> mismerges with remaining good topics caused by these topics
>> appearing and disappearing from 'pu'.
>>
>> I'd rather see any topic that consumed reviewers' time to be
>> polished enough to get into 'next' while we all recall the issues
>> raised during previous reviews.  I consider the process to further
>> incrementally polish it after that happens a true "cooking".
>>
>> For this topic, aside from "known issues" that we decided to punt
>> for now, my impression was that the code is in good enough shape,
>> and we need a bit of documentation polishes before I can mark it
>> as "Will merge to 'next'".
>>
>>> Possibly only checking the documenation aspects, so folks don't fall
>>> into the same trap as me.. ;-)
>>
>> Yup, so let's resolve that documentation thing while we remember
>> that the topic has that issue, and what part of the documentation
>> we find needs improvement.
>>
>> I am not sure what "trap: you fell into, though.  Are you saying
>> that giving
>>
>> git describe [<option to describe a commit>...] <commit-ish>
>> git describe [<option to describe a blob>...] <blob>
>>
>> in the synopsis is not helpful, because the user may not know what
>> kind of object s/he has, and cannot decide from which set of options
>> to pick?  Then an alternative would be to list
>
> (If I remember correctly) My nit pick was roughly along the lines you 
> suggest, and that the two option lists (for commit-ish and blob) were 
> shown in different ways, which could lead to the scenarion that, with 
> knowing the

s/with/without/  ...

> oid object type (or knowing how to get it), the user could give an invalid 
> option, and think the command failure was because the oid was invalid, not 
> that the option was not appropriate, along with variations on that theme.
>
> The newer synopsis (v5) looks Ok in that it avoids digging the hole by not 
> mentioning the blob options. Personally I'm more for manuals that tend 
> toward instructional, rather than being expert references. I'd sneak in a 
> line saying "The object type can be determined using `git cat-file`.", but 
> maybe that's my work environment...
>
>>
>> git describe [<option>...] <object>
>>
>> in the synopsis, say upfront that most options are applicable only
>> when describing a commit-ish, and when describing a blob, we do
>> quite different thing and a separate set of options apply, perhaps?
>>
> --
> Philip 

