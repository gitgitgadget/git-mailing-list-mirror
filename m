Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2067220437
	for <e@80x24.org>; Tue, 31 Oct 2017 01:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbdJaBhr (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 21:37:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61126 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752132AbdJaBhc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 21:37:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7D76A8434;
        Mon, 30 Oct 2017 21:37:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4l94lUtLIAsEHdv0hED18G3bxN0=; b=pvbsTv
        tSRMqDys3lZXmEI/fxFcc4TuUS7DQPXAhmAPx9D83QD4LPzAybVciikT3XZOXZua
        ergRNTIFUBt/Lrmn407uqfM84vMGTnlIUZtVaH6E2poG6EbG0ZQP4ht7jCds/zId
        msbvXH1CEYlCSXN1xx72e27631TenlsA1Rq9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PYNDi0WQcMhspnmfYTY2S+Bnbw4abMpD
        toTWhhWrOuVMruoGCJUa6uCGA7lOO4GLF3iZ9Ym0XA+yOWlVcWGnT8M9rpYYxli+
        Qsd/RTHJaaG+xWzoDHHYEj4t3nEiQArIntasg/8CihzknjXN4qyo+WLBNFcN5sue
        CDfRBCH/hkk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E8FEA8433;
        Mon, 30 Oct 2017 21:37:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11CD6A8432;
        Mon, 30 Oct 2017 21:37:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        git@vger.kernel.org
Subject: Re: future of the mediawiki extension?
References: <87vaix731f.fsf@curie.anarc.at>
        <q7h9o9opyllo.fsf@orange.lip.ens-lyon.fr>
Date:   Tue, 31 Oct 2017 10:37:29 +0900
In-Reply-To: <q7h9o9opyllo.fsf@orange.lip.ens-lyon.fr> (Matthieu Moy's message
        of "Mon, 30 Oct 2017 11:29:55 +0100")
Message-ID: <xmqqh8ug3xnq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FA3A678-BDDC-11E7-B358-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <git@matthieu-moy.fr> writes:

> So, my conclusion is that a simpler submission mechanism (GitHub's
> pull-requests) and a less picky code review would help Git-Mediawiki.
>
> From previous discussions, I think Junio will agree with that: he's
> reluctant to keeping too much stuff in contrib/ and usally prefers
> external projects.
>
> Note that being a separate project doesn't mean there can't be any
> interaction with this list. Requests for reviews for separate projects
> are usually welcome even though they don't happen often here.

I would say that Git and its ecosystem has become mature enough that
any add-on project that aims to make life more pleasant for those
who use Git and $X together for any value of $X can now stand on its
own, without being under Git umbrella like back in the days when the
number of people who know and/or use Git were small.  The world is
no longer constrained by small number of people with Git expertise,
and it has become practical to discuss their project among those who
are familiar with (and motivated to learn) *both* Git and $X without
necessarily involving Git 'core' people.

Participants of this list will continue to strive to keep this list
the place for people to come for Git expertise.  But this list may
no longer be the best place to find those who are experts on *both*
Git and $X.  And that is why I think an external project standing on
its own would be more preferrable these days.

> There's also a hybrid solution used by git-multimail: have a copy of the
> code in git.git, but do the development separately. I'm not sure it'd be
> a good idea for Git-Mediawiki, but I'm mentionning it for completeness.

I think the plan was to make code drop from time to time at major
release points of git-multimail, but I do not think we've seen many
updates recently.
