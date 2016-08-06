Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0AE01F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbcHFUK0 (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:10:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751000AbcHFUKR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:10:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D38A42F5CB;
	Sat,  6 Aug 2016 12:51:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g7P/gdzyztQtp0IEvHkYad52Arc=; b=M63Q5O
	DM/+TbSw3MSEzd3mNTuEyWgjlBmZ8/XnU+VqQWMu1zuRBwaCSLWIxds0s4K9w2Qh
	cDYVMVJW7cMuZMol6MV90NWD1PTwrjEM/pohkOMqPf2W1t13buFu88dLh1Ucjlx1
	jBU99WXvsQeHpJj/CAl/OdEPKrjVp0KFfw0PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uOfFiS+8eB+UaxErUSllmtmYRzU2qUAe
	FPdd2YbsPz4+3Tnb+MQmoip0buonGfahOUcoe1j9AewjnCQg9JES8qWblnsfInFN
	ZjjUEy0Rqj+Q73E3hq4T8MFTHEdl3ySFCx99VsbXqrKSmyhwZg7tgKIQIGlKrtOQ
	32jQaYJJJAk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C319A2F5CA;
	Sat,  6 Aug 2016 12:51:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B6DF2F5C9;
	Sat,  6 Aug 2016 12:51:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Martin Fick <mfick@codeaurora.org>
Cc:	"Michael S. Tsirkin" <mst@redhat.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
Subject: Re: storing cover letter of a patch series?
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
	<20160804234920.GA27250@redhat.com>
	<xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
	<10752620.2J2dEZLIGc@mfick1-lnx>
	<CAPc5daV51cwPs-8uc_SYLaod7RB7aDGYbjt-x-JsY1qNL81QRA@mail.gmail.com>
Date:	Sat, 06 Aug 2016 09:51:33 -0700
In-Reply-To: <CAPc5daV51cwPs-8uc_SYLaod7RB7aDGYbjt-x-JsY1qNL81QRA@mail.gmail.com>
	(Junio C. Hamano's message of "Fri, 5 Aug 2016 14:23:42 -0700")
Message-ID: <xmqqziopj0x6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08F79300-5BF6-11E6-837E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> On Fri, Aug 5, 2016 at 2:20 PM, Martin Fick <mfick@codeaurora.org> wrote:
>> On Friday, August 05, 2016 08:39:58 AM you wrote:
>>>  * A new topic, when you merge it to the "lit" branch, you
>>> describe the cover as the merge commit message.
>>>
>>>  * When you updated an existing topic, you tell a tool
>>> like "rebase -i -p" to recreate "lit" branch on top of
>>> the mainline.  This would give you an opportunity to
>>> update the cover.
>>
>> This is a neat idea.  How would this work if there is no
>> merge commit (mainline hasn't moved)?
>
> Sorry, I do not understand your question. You always
> merge into your own "lit", which is based on (some)
> version of the mainline. If a topic builds on top of the
> mainline, you "merge --no-ff" it into "lit". Because no
> merges on "lit" will be part of the future mainline anyway,
> even the project frowns upon a "no-ff" merge, that will
> not be a problem.

In any case, the "if you want to say more than what the individual
commits say about the topic as a whole, say it in the merge that
brings them all into an integration branch" is not just "a neat
idea".  

Recent versions of Git actively _encourages_ you to describe what it
is about by opening your editor when you create a merge, and the
cover letter material is something you would want the merge of your
topic into the upstream to say when your topic finally lands there.
And as the author of a topic, the person who writes the cover letter
is well qualified to describe what the topic as a whole is about,
how it relates to the state of the entire project before that merge
happens.  That is what you want to write in the cover letter.

So "write it in a merge log message yourself, and somehow find a way
to propagate it to the maintainer's tree" is the natural consequence
of thinking and working backwards from what we want to have in the
final history; not any novel (or neat) idea.

What follows is that at the receiving end (i.e. "git am") it may be
suboptimal to create an empty commit to record the cover letter
material.  Storing at the bottom of the received pile of commits is
out of question.  It _might_ be acceptable to queue it as the tip,
and then teach "git merge $topic" to notice that $topic^0 is such a
"cover letter commit", and turn itself into "git merge $topic^1 &&
git commit --amend -C $topic", though.
