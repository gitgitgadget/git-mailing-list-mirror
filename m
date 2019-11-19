Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14E91F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 01:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfKSBpw (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 20:45:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60515 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSBpv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 20:45:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3B481E8F3;
        Mon, 18 Nov 2019 20:45:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sds36UAOoQX5nqJrbgp2OSOgcAo=; b=tJ+fJ2
        8wqq5JFpdZtiEON4pVX1LfsWW0jxiXaSiMS1N86Q+qRVvvAOYSY6waBb/dm4hbVF
        tChaXMOLWpOex5rY9MFl6cm8m9xhkhJUgPq3oP0n2P7DsElgX96itOd+9rpU1gWK
        mwXHU43/EByKcHNUIMGXbMZeo/WyIV2brAuRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RHMYk3Jp30vjIrSqgbKmm9yXpKWUIQAk
        INHk5dhVZ6I7eGRikzMX5/y1xM2BhmjM3j/EUtHGwvAgXpUYqGMWQ1x/smXZ6QIu
        DMwNMpcjoUvumd1lkRjZ1dh4saeALm/mbISK7xQegFJS45fgS26HmlurmrKDLjO0
        M+HIKex3Sws=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD1D91E8F2;
        Mon, 18 Nov 2019 20:45:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33A9F1E8F1;
        Mon, 18 Nov 2019 20:45:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] MyFirstContribution: add avenues for getting help
References: <20191115230637.76877-1-emilyshaffer@google.com>
        <xmqqv9rk4j1y.fsf@gitster-ct.c.googlers.com>
        <20191118214519.GH22855@google.com>
Date:   Tue, 19 Nov 2019 10:45:45 +0900
In-Reply-To: <20191118214519.GH22855@google.com> (Emily Shaffer's message of
        "Mon, 18 Nov 2019 13:45:19 -0800")
Message-ID: <xmqqy2wczliu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E2A14E6-0A6E-11EA-BD89-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> I am (implicitly) assuming that it is the former, but I think it is
>> better to clarify what this "list of places" is meant to be.
>
> I'll try to fudge the language so that it implies these are official
> channels for getting help.

Sounds good.

>> I notice that stack overflow is missing in this list.  Intended?
>> Not that I visit there at all nor I would recommend it, but I recall
>> seeing questions asked by more than a few people after getting bad
>> pieces of advice there.
>
> Hm. SO for getting help contributing to a specific project? ...
> I suppose the kinds of questions I expect to see on StackOverflow
> include "How do I write a mutex lock in C" or "How do I generate patches
> with a cover letter", not "I'm stuck on this Git tutorial" or "Would the
> Git project welcome X change". To me, this doesn't seem like the place
> to bring it up one way or another.

I am glad I brought this up, because "How do I force git ignore
changes I make to an already tracked file?" was a question I thought
a reader of this document might want to ask to these "avenues for
getting help", and I wouldn't be surprised to see such a question
asked on stack overflow.

After re-reading the title of the document, I am reminded that the
intended audience is aspiring Git developers, and I now know that it
is silly for an aspiring Git _developer_ to be asking such a
question---I am guessing you meant that these "avenues" are only
about getting help on _developing_ code to be included in git-core,
and in that context, yes, I agree that SO is a poor place for that.

I'll re-read the patch to see if what is written in the document is
prone to this kind of misunderstanding, or it was just my fault to
have failed to notice a clear description on what kind of help the
section is talking about.

> I envision an exchange sort of like this:
>
> Newbie to git@vger.kernel.org: "I'm having trouble compiling Git and I
> want to write a patch, I'm getting X error"
>
> Veteran to Newbie, cc git-mentoring, bcc git@vger.kernel.org:
> "Please build with blah flag and paste console output, plus let us know
> system information blah blah blah"
>
> I don't mind the idea of pushing folks to ask on the mentoring list
> first. It's pretty well attended already - just now I count 16 list
> members, a pretty significant majority of which are project veterans. I
> have no problem suggesting newbies ask their questions, which others
> probably had and solved before them, in a space separate from the main
> mailing list.

OK.  I understand and agree with the direction.

I wonder how well the "CC: git-mentoring" part would work, though.

A response to "plus let us know" by the Newbie will most likely keep
the list on CC, which would bounce with "you must be subscribed"?
It may appear rather rude to tell somebody they need to subscribe to
another list in order to obtain the help.

Thanks.
