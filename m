Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100F01F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 04:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKOEsd (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 23:48:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62890 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfKOEsd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 23:48:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 67F7F8F2BA;
        Thu, 14 Nov 2019 23:48:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RSDzKVHDAJylEonjtUWsaqksqC0=; b=l+PyPj
        KTKXikAxLPHcT55Mdym8GrOTBQN2SGB5xv7M83yrkioNIuh5PPXcJz9mO26TvJwW
        xLFdWaFOfKKt+Pd30ZcvpVMBhoRB8UTdc/YFMPVpIQDcItQ/0Xwfg6FlGucuFoSH
        sI4lzaOFe/TJ5hjoSMqxDEIwafsCNs/p2jviA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BbYkvbn88RcpfNsYm8IzUTPyW4PxYcul
        mmD4Fr0XCx5rL7bnGSYgEj+pqFlzCvAZK7xAAFlAHFTeKGpnyKe5Hg4vLiJkDKKP
        EavPepxI8l6Y9rJdpVEYaZQQYQB7t0Qnf3jgH9iBGgSGdpk2gIkzAfInWUYsWbgk
        ZQob7CDlt7U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 615528F2B9;
        Thu, 14 Nov 2019 23:48:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 80C5F8F2B6;
        Thu, 14 Nov 2019 23:48:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Garima Singh <garimasigit@gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
        <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
        <20191112184547.GA38770@google.com>
        <nycvar.QRO.7.76.6.1911122100220.46@tvgsbejvaqbjf.bet>
        <CAP8UFD2qjUa=y81YPVSMcuEcDkrkrV=j912qySmG83pig=dFDg@mail.gmail.com>
        <20191113150624.GC3047@cat> <20191114023100.GD22855@google.com>
        <20191114060650.GC10643@sigill.intra.peff.net>
Date:   Fri, 15 Nov 2019 13:48:26 +0900
In-Reply-To: <20191114060650.GC10643@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 14 Nov 2019 01:06:50 -0500")
Message-ID: <xmqqlfsh923p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A901C28-0763-11EA-BFD1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it makes sense to stay closed for now. One of the reasons to
> have a separate group is to make it less daunting to post to. Having a
> public archive may work against that.

Yup.  For the same reason, I presume that the list members are not
disclosed to the public.  Or perhaps even to the list members?  It
might be nice to see who are participating as mentors, though.

As long as it is easy to point an already-asked-and-answered topic
to a new mentee, I think that is a sensible thing to do.  We would
find it to be inconvenient that we cannot use such an old exchange
to non-list members, though.

>>  - Post: Group members only. (My thinking is that once you're asking for
>>    someone's time and effort to help mentor you, you can volunteer the
>>    time and effort needed to push the join button and optionally filter
>>    your inbox ;) )
>
> It also cuts down on spam (I moderate the git-security google group, and
> the spam-blocking is far from perfect).

I noticed that, too.  Interestingly, GMail catches these spam that
come via the group just fine, so the filter over there may probably
be set to be more generous.
