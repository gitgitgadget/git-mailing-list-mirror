Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0609AC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 11:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347914AbiCOLQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347482AbiCOLQf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 07:16:35 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6984F4B425
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 04:15:23 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nU596-0007qa-3g;
        Tue, 15 Mar 2022 11:15:20 +0000
Message-ID: <eecab055-94bc-2174-0490-28b76cf48b0e@iee.email>
Date:   Tue, 15 Mar 2022 11:15:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Dealing with corporate email recycling
Content-Language: en-GB
To:     Sean Allred <allred.sean@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
        git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
 <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>
 <01f201d836e5$89247c30$9b6d7490$@nexbridge.com> <87v8whap0b.fsf@gmail.com>
 <01f301d836eb$5c7a6810$156f3830$@nexbridge.com> <87r175amw2.fsf@gmail.com>
 <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email> <87ilsha2b7.fsf@gmail.com>
 <xmqqtuc1tpdj.fsf@gitster.g> <697d8717-bd3f-0871-d5b3-e6303c4ed726@iee.email>
 <87y21c2ehl.fsf@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <87y21c2ehl.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/03/2022 01:23, Sean Allred wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>> A broader issue for the corporate email mailbox systems is those that
>> are allocated to roles. So you may have Traning1@corp.com thru
>> Training9@corp.com (we had) and if that training includes practical low
>> hanging fruit examples from a project, it's difficult to disambiguate
>> those commits. More likely is say, having TestPC1 - TestPC9 that
>> included debug commits, perhaps even with pair programming test & debug
>> sessions, so allocation to individuals (rather than mailbox) becomes a
>> real problem. Hopefully that's rare in Sean's case.
> Yep, this wouldn't happen for us.  Lots of other processes depend on
> there being an individual making the commit.
>
> I'd also be surprised if this didn't cause process problems for other
> folks, too.
I was in equipment engineering where independent dedicated test
equipment was more common, rather than pure software, so the potential
for  role based commits from TestPC1 - TestPC9 was far more likely (for
cases where it's the hardware that needs to be understood, not the
engineers' choice of code ;-)
