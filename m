Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B5B020954
	for <e@80x24.org>; Wed, 29 Nov 2017 02:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbdK2CTF (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 21:19:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55781 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751565AbdK2CTE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 21:19:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00ED8B06AF;
        Tue, 28 Nov 2017 21:19:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UiF1P1u3uZ0EIv3wTPZIewqCYO0=; b=ctfav3
        vQTzVURsuCq9Rl3nJ9TUxSOnYd04kBocE8VqRIBilVsQ78Mp98+Az1CGz64+8c1n
        J8x8kYeiSGqu4xBgWamro80fmzL5pYTeFJEEfuRMjoLSxhzveRmoCIOXk1dsa8fJ
        dx0qROkL1/3eW60znXA61uqJY4FotCBl9lMUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nrMlkUEaIbTMbZIMRmY6Qq238i1+yfUl
        9IgRdpIfn5Rv5kJt+YwP86/CwfNND1RfUN/+strsAfeqKFMZaDpPvMDdU5pHQDkJ
        Fk6xGvqI7ZffO5nLU/eKWpEqC+e9nEgNYzh1m9FQEYcvPyNIVBZLiVPxh929mzd3
        jis3DASBMgs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECB09B06AE;
        Tue, 28 Nov 2017 21:19:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44948B06AC;
        Tue, 28 Nov 2017 21:19:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: Question regarding "next" merge
References: <xmqq374z83p8.fsf@gitster.mtv.corp.google.com>
        <20171129013848.37208-1-dnj@google.com>
Date:   Wed, 29 Nov 2017 11:18:59 +0900
In-Reply-To: <20171129013848.37208-1-dnj@google.com> (Dan Jacques's message of
        "Tue, 28 Nov 2017 20:38:48 -0500")
Message-ID: <xmqqwp294yjw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9EEFB34-D4AB-11E7-A358-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

> I read the "what's cooking in Git" notes and saw that you were intending to
> introduce this patch set into "next". Johannes pointed out some quoting errors
> that break Windows builds, and I have incorporated fixes in my working copy.
>
> I was going to hold off on publishing v4 in case some of the other reviewers
> had additional comments, but if you would prefer, I can publish them now
> before you merge, so "next" doesn't break on Windows.

Please do so.  Even though I try to, I cannot follow and remember
all discussions on each and every topic, and noticing your own topic
getting mislabeled in "What's cooking" summary and yelling loudly at
me is the best way to help the project overall by preventing me from
mistakenly merging a topic that needs still an update.

And if you are *not* ready and need a bit more time to send in an
update, I'd prefer that you do *not* rush.  I can easily make a note
to wait for an update without merging the latest round of the topic
I have in my tree.  Also, I'll go offline towards the end of this
week, so even if you rushed, the updated one may not hit my tree
anyway.

Thanks for stopping me.

