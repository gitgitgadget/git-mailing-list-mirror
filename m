Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC056C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC88206DF
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 20:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgKCUHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 15:07:09 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:50310 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCUHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 15:07:09 -0500
Received: from client3368.fritz.box (i5C745802.versanet.de [92.116.88.2])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 46B8D3C04C2;
        Tue,  3 Nov 2020 21:07:05 +0100 (CET)
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20190621223107.8022-1-felipe.contreras@gmail.com>
 <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
 <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
 <xmqqk0vbbep5.fsf@gitster.c.googlers.com>
 <CAMP44s13nip2_Z1OOFb9iVcrSxQbyJW4cH86J3Ah1p4SmTQWQQ@mail.gmail.com>
 <xmqqr1pj9rf0.fsf@gitster.c.googlers.com>
 <CAMP44s0nxQ8jxxw7wSPOMv9Nx1P7ww3S6dGv27xNVQ_aHTaPng@mail.gmail.com>
 <0ec43318-bf83-25c4-a817-a150e2e47546@haller-berlin.de>
 <CAMP44s0+TMhmPYM7omoFhcebMLhZyh6v77WUFNrscRtPNEDNHQ@mail.gmail.com>
 <xmqqeelh7y23.fsf@gitster.c.googlers.com>
 <010c6222-4365-7446-a666-333ac7b4d415@haller-berlin.de>
 <xmqqh7qb3a3r.fsf@gitster.c.googlers.com>
 <e2b59b69-7fd2-f52c-eb06-6b97e3de557a@haller-berlin.de>
 <xmqqlffis6u0.fsf@gitster.c.googlers.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <1815f1ab-b293-e948-9624-76fc83d66d99@haller-berlin.de>
Date:   Tue, 3 Nov 2020 21:07:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqlffis6u0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.11.20 18:12, Junio C Hamano wrote:
> Stefan Haller <lists@haller-berlin.de> writes:
> 
>> Using stuff from oh-my-zsh is not an option for me. I'm not using
>> oh-my-zsh, and I don't want to begin using it just for this one package.
>>
>> I could use Felipe's version from
>> <https://github.com/felipec/git-completion> (and in fact, that's what
>> I'm doing right now, for testing. Works great. :-)  However, I'd have to
>> remember to manually update it every so often.
>>
>> So yes, I prefer to use the one from git's distribution, because it is
>> automatically kept up to date whenever I update git (as long as I
>> symlink to it rather than copy it.)
> 
> Thanks for another data point.  
> 
> You'd need to add to another "as long as", which is "as long as it
> keeps up with felipec/git-completion".  If we fall bahind, you'd be
> better off getting updates directly from there, not from us.  

Yes, that's true of course. That's why I'm happy that Felipe contributes
his version here, and that you are accepting it quickly.

> And I suspect that not many Zsh users want to care about the
> distinction between the two.  If it were as easy to grab the latest
> version of Felipe's as an update of Git from your distro, wouldn't
> most people rather choose to do so?
> 
> If we are not doing much reviews on Zsh completion on this list, due
> to lack of interest and expertise, then we will either fall behind,
> or blindly copy, Felipe's repository and republish as a small part
> of our project, without adding much value ourselves.
> 
> Which is not a very happy place for us to be in.  I dunno.

I still think it's valuable to do this. And I think the fact that it's
in contrib makes it less likely that we fall behind, because you can
just choose to merge updates without very thorough reviews (like with
the current patch series), which you probably wouldn't feel comfortable
doing if it had "graduated" out of contrib, as Felipe requests.

-Stefan
