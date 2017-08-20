Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E56720899
	for <e@80x24.org>; Sun, 20 Aug 2017 23:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbdHTX5B (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 19:57:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56782 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753394AbdHTX5A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 19:57:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90F55A9791;
        Sun, 20 Aug 2017 19:56:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=maGtufCxQWKbOmrJCQP7ODbcGxU=; b=SKGfpW
        K8Lt7UIs7xH4aDjvgVxOR+3RAzl9tBWMPRoDHPnF7qUvWzzKo1RwL/4/IEQEqvIY
        iC/nVH4kwKpSI30D1YVf9M6TJWxlIcAB9IVZgNonY3RTbhbvifw7X06hjqRBjwv0
        wfnLTq0v7I4Tmw7VqXxWx3TaTeSZIuZfbj0/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IO9YGbWv+ptqxw6sj84Zm7eSEIhh8WMn
        EDVOUVqBSk1Qib+loszwTqSMOEW8AJE/l0z0n1KMeU2BGh/J/ddaAIfn9bRJTW3t
        2RnyQINgPRkUKTCqvTzuGHpsxyeZZHYkE/cJ36B7aTDnBEK4RxgD0dzMizf31bns
        h0OMiMShvZU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8766FA9790;
        Sun, 20 Aug 2017 19:56:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5FCCA978E;
        Sun, 20 Aug 2017 19:56:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     Anatolii Borodin <anatoly.borodin@gmail.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Please fix the useless email prompts
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
        <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com>
        <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
        <20170820091807.l23h44gnjajfv5bn@sigill.intra.peff.net>
        <CAH5451m58n8mYvt=BC_t2=EAv0HOOdAWrCHCNEPQ3NVjT174nQ@mail.gmail.com>
        <CACNzp2kao+hu6a2nO=gVaLctzoDauB+xyj=cfQLUdNOXTNKQfQ@mail.gmail.com>
        <CAH5451kcb0Y4mm2U804ruqBewB2AV991Hm0_-8ExdEoDTF8DJw@mail.gmail.com>
Date:   Sun, 20 Aug 2017 16:56:50 -0700
In-Reply-To: <CAH5451kcb0Y4mm2U804ruqBewB2AV991Hm0_-8ExdEoDTF8DJw@mail.gmail.com>
        (Andrew Ardill's message of "Mon, 21 Aug 2017 09:32:24 +1000")
Message-ID: <xmqqinhh7pz1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CB3ED78-8603-11E7-B051-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Ardill <andrew.ardill@gmail.com> writes:

> Is there any reason `git pull` can't delay that check until the point
> where it actually tries to create a new commit? It's fair enough to
> error if a new commit needs to be made, and there is no user
> configured, but for the use cases discussed here it seems a little
> eager to error on the chance that the user will be needed.

I personally do not think it is a good trade-off.

In theory [*1*], it _is_ possible to delay the "the given identity
looks bogus" check so that the underlying "git fetch" is done
without it, and bypass the check when "pull" fast-forwards, as there
is no need for an extra merge commit in such a case as you noticed.
We still do record the bogus identity in the reflog of the HEAD ref,
but IIRC, we do not trigger a severe error when a bogus identity is
only needed for reflogs.

But before running "fetch", you cannot tell if the "pull" will
fast-forward, so such an "optimization" may actually be a net loss
for end users, who have to wait for network delay only to be told
that you'd end up with a history with bogus identity and need to
redo the operation after fixing your identity.  Then after that,
they are likely to do another "git pull", which will avoid the cost
of retransmission of objects if (and only if) the initial "git pull"
uses remote-tracking branches.


[Footnote]

*1* We actually might already do such an "optimization"; I didn't
    check.
