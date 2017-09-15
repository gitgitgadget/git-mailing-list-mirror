Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E3F20281
	for <e@80x24.org>; Fri, 15 Sep 2017 21:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbdIOVWd (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 17:22:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51273 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751673AbdIOVWc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 17:22:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC3519AD3B;
        Fri, 15 Sep 2017 17:22:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fkDq1b8Bg23PXiA3zh8tLt+zvcI=; b=yh07C+
        XYY9NPBeIiM5sYN10qLsseOFAfFSBSM6ebdiIDGyIofG63C0s4Nk9LF/RCIrt7i8
        r1GwikKLj4Np5aZLpExqS+6J+9a3wYFwmix+8neB9mqofa387i0XxuGxKntBWJz0
        I7OAJAQrmHNYijo6KE9wD8DGYDX0pJFDcQYrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QwI7dqScAbYzEySy1xVqbzsWyEESH5Qr
        vYtfGeXMobwbnnusPnwU+I+NcV2J8emWpLguZe2HccpQ74+aUpLe/hXGQbzdkz9d
        gUy/FrgOFJ5W5wCMx78/O3sVw6YeFmmgXlxFFi00M0UcvcVJIUftjCqo5+yThXTB
        G4FlcQogpvk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E221E9AD3A;
        Fri, 15 Sep 2017 17:22:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37D6F9AD39;
        Fri, 15 Sep 2017 17:22:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
        <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com>
        <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709151816390.219280@virtualbox>
        <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709152214100.219280@virtualbox>
Date:   Sat, 16 Sep 2017 06:22:29 +0900
In-Reply-To: <alpine.DEB.2.21.1.1709152214100.219280@virtualbox> (Johannes
        Schindelin's message of "Fri, 15 Sep 2017 22:15:08 +0200 (CEST)")
Message-ID: <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBA0FF02-9A5B-11E7-81AA-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 16 Sep 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > If you want *contributors* to ping the thread themselves, how about
>> > *posting your updates there, too*?
>> 
>> I do not understand this comment at all.  That is what I and others
>> already and always do by responding to the patches, and when trying
>> to see if a topic is still alive, with thread-specific responses and
>> pings.
>> 
>> If you are demanding that "What's cooking" report to be sent as a
>> response to all the topics, that will *NOT* going to happen.  It is
>> meant to give a summary of the current state to help contributors
>> and reviewers be aware of what is happening across the entire tree
>> and not limited to a specific topic.
>
> If that is the case, you will have to be okay with others responding to
> your "What's cooking" mails instead of the original threads.

Yes and no.  When I say "This topic waits for a reroll" and somebody
(not necessarily the author of the topic) wants to remind me that a
reroll has already been posted (or worse--I queued the updated
version but forgot to update the message), I do appreciate that the
reply is made to the "What's cooking" report.  When there is "This
topic waits for a response to a review comment" and the responder
wants to respond to the review comment, the reply should be made in
response to that review comment.  Otherwise, the discussion will
lose the continuity.

And as you alluded to, we may need to see if we can help making it
easier to do the latter when needed.

> That's what
> you are buying into by having these "What's cooking" mails that are in no
> usable way connected to the original threads.

For the above reason, I do not think this is a particularly useful
stance to take.  Do you have a concrete suggestion to make these
individual entries more helpful for people who may want go back to
the original thread in doing so?  In-reply-to: or References: fields
of the "What's cooking" report would not help.  I often have the
message IDs that made/helped me make these individual comments in
the description; they alone would not react to mouse clicks, though.

Having said that, I'd expect that individual contributors have past
messages pertaining to the smaller numbers of their own topics in
flight in their mailbox than the project wide "What's cooking"
report covers, so perhaps an affort to devise such a mechanism may
result in an over-engineering waste nobody finds useful.  I dunno.


