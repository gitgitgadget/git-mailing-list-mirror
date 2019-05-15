Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 862401F461
	for <e@80x24.org>; Wed, 15 May 2019 00:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEOAst (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 20:48:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63335 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOAst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 20:48:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E8B414274F;
        Tue, 14 May 2019 20:48:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9jGRd+YEZ+eI
        l/pWd5eGFHDpVK0=; b=e0IhrWxE3waoQ6Vhl6gHncqaKk/xgio+oWXtvEQXNNX6
        f7+Vcb23JgUD+493sOz3L2JUJM6qJYfr6qD4UvJY6KpwKOA+T7A8xX/EVm1lBb1r
        M7fGvv1jdFKxyxzlGhpuUyYuXcy3WWyd3LzBcMHK2OJSFPrKx7GQZ/g8oDUZu6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ktFeUm
        EevWAUS4cb/JD+sxiHuH9aHXCpD8PSEPM1uH7TE1sE4frrgPSlf6BqK6pXGERJaN
        29vHR8qxeS9KiKYwieL0yY3AmFGNlxMIxBRil+1wEw2HL+NrNsldzmsJRa+UfKA5
        IxpqJpJnC2BjQvFppom8Zq12IR3Q/1NcbJNRg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25EDE14274E;
        Tue, 14 May 2019 20:48:47 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DD4914274D;
        Tue, 14 May 2019 20:48:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] status: add an empty line when there is no hint
References: <20190430060210.79610-1-johnlinp@gmail.com>
        <ae1332b8-a227-e83a-8862-8811b6a81251@gmail.com>
        <20190501234512.GD202237@genre.crustytoothpaste.net>
        <CAKO26MvXmOMHgqWSoVrmdwyDFyqDrChkMOHq6iuJAX8pvHzZoA@mail.gmail.com>
        <20190502231537.GE202237@genre.crustytoothpaste.net>
        <CAKO26MuisScMPp0SxRo896y7waEgR3HjU3A8+VM73eS0xgU8RQ@mail.gmail.com>
        <CAKO26Mtn+KDnkHWsKf8mAyTmeaCYK0gjdNad5bxJe-qxjKs=xw@mail.gmail.com>
        <xmqqh89ydhqu.fsf@gitster-ct.c.googlers.com>
        <20190514020416.GH7458@genre.crustytoothpaste.net>
        <xmqqftpha3tb.fsf@gitster-ct.c.googlers.com>
        <CAKO26Msqj93hwKVduB0op=sMXs3egM2zvyfcJgpoqTWn4ywHHw@mail.gmail.com>
Date:   Wed, 15 May 2019 09:48:45 +0900
In-Reply-To: <CAKO26Msqj93hwKVduB0op=sMXs3egM2zvyfcJgpoqTWn4ywHHw@mail.gmail.com>
        (=?utf-8?B?Iuael+iHquWdhyIncw==?= message of "Tue, 14 May 2019 17:43:45
 +0800")
Message-ID: <xmqq4l5wa6fm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3234E646-76AB-11E9-A7FD-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E6=9E=97=E8=87=AA=E5=9D=87 <johnlinp@gmail.com> writes:

> I was not talking about the messages in the editor session. I was
> talking about "git commit" without "git add" anything.
>
> For example:
>
> ```
> $ touch newfile.txt
> $ git commit
> On branch master
> Untracked files:
>         newfile.txt
>
> nothing added to commit but untracked files present
> ```
>
> My current patch is trying to add an empty line between
> "Untracked files:" and "newfile.txt".

I do not think that one is paged, so if you ask me, I'd say we
shouldn't add an extra blank there.  Is that message also reused in
the editor session, or do two different codepaths produce a similar
looking message, one for the above case direct to the terminal and
the other for the editor session?

But again...

>> At the same time, I think I've been happy enough with the current
>> output from both commands, so if you let me bikeshed freely, I'd
>> probably pick "let's not change anything then" ;-)

