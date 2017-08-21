Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D726A208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 22:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbdHUWh2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 18:37:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60460 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754035AbdHUWh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 18:37:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 818669ECCC;
        Mon, 21 Aug 2017 18:37:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=grTbCh1S6dP5
        lrTGj9YKLEXOulU=; b=u9/0s/J8LHaXgJk0UKqN3kbnwPYJ0G0hrV00XybXvq9H
        M5FZ1X3aUCmH55+RwTWgALzM0Hx3STWv9HiXFDZVa/q4qIDHIS4iBb8iyogaWSIb
        ZvSEkjLuvzVdfwWa/jgqG7C9m1lw/ShCOAw07tAOR2ospx7SkA8gYWvp8eU+zRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DXSi8F
        pNaPNbAjIYsARl/7P6GP+Dzbb/bxKF0x7YXlX7XwADjnbDF+cCY4L6sptWDyrARh
        BBP9kuq9NWVOfYIFoRE8tYdY0GyaB2rzDMCFdNIEJZ7iFCiqOJF6lP0+ouVIQXZL
        gjojfYEj9U4jVwtL/nwQqxFvKGP/qlLPtVB5c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77DE19ECCB;
        Mon, 21 Aug 2017 18:37:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB5BB9ECCA;
        Mon, 21 Aug 2017 18:37:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     STEVEN WHITE <stevencharleswhitevoices@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "Your branch is up-to-date ..." is incorrect English grammar
References: <CAJXxHvVzTrhJk6pFsOzUKBuU2VcW41-tMk5A7s+rxXsacXpppw@mail.gmail.com>
        <CAN0heSrh_+J=LQnGZtngxQbcHAjFhX9vPKKDa7_ORz4iDpXf=g@mail.gmail.com>
Date:   Mon, 21 Aug 2017 15:37:16 -0700
In-Reply-To: <CAN0heSrh_+J=LQnGZtngxQbcHAjFhX9vPKKDa7_ORz4iDpXf=g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 21 Aug 2017 11:37:39
 +0200")
Message-ID: <xmqqmv6s5yzn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4987BCF0-86C1-11E7-BF1C-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> But =E2=80=9Cyour branch is up-to-date=E2=80=9D is INCORRECT. And, bec=
ause it=E2=80=99s
>> incorrect, it conveys an odd and unsettling experience to native
>> English speakers whenever they read it.
>>
>> If you=E2=80=99re curious, you can find plenty of discussion of this p=
oint of
>> grammar. Here=E2=80=99s just one example:
>> https://english.stackexchange.com/questions/180611/do-i-keep-myself-up=
-to-date-or-up-to-date-on-something.
>
> There is also some previous discussion on this very list:
> https://public-inbox.org/git/CALFtnmeRxgetuCVbO8ZmVkCR302vQ2s4hTPoHxAe5=
NEfmjtXEg@mail.gmail.com/T/#u
>
> The code base contains a few instances of "up-to-date" and "up to date"=
.
> A tree wide sweep could be made to update user-visible strings in the
> code and in the documentation. Fixing source code comments seems like
> overkill.

It should be safe to update any message that is meant for human
consumption (i.e. those inside the _("... message ...")) i18n
marker).  As the use of "up-to-date" dates back to the days when
Linus was still doing much code for our project, I suspect there may
be some plumbing message that contains the phrase that scripts
expect to stay spelled that way, and it is not OK to "fix" them.

Thanks.
