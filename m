Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB49A20193
	for <e@80x24.org>; Mon, 24 Oct 2016 21:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936248AbcJXVOq (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 17:14:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55801 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752186AbcJXVOq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 17:14:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F36AF481E0;
        Mon, 24 Oct 2016 17:14:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LHvMQwEtpJcA8OekaSDLY0Mn5aI=; b=RYYsph
        UB4hhf1J7dKBEQXvidnkkpySl9WShYHoeLvGtYcKmqaLwjW57R9Zb0qi9KRL2idY
        jq31nxsGN7KGDzLWa/9+INY4HAS+Ai/Mmuyng3NRDKDwK0CMeIl4E4Fgg5Cm3qIt
        HE7AL3xLKibonaWBfvro8TWenhOpAHjbqtwZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NWRVc+VaYXAElLFc+HgmKvTbRUF6kCCq
        LQR8jJ7lSssJLY601F106mzChlR7rT0hD2RdBWFYsklpXx+cCESNAWuTyC4KlcZC
        xYC178PkyleFU7HaZuVWamdaWKEplSkNl9X1PbKVnL8sYpD4aVwHQLvKI2Q/0cfc
        nA8yjkuwlZY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EACDA481DE;
        Mon, 24 Oct 2016 17:14:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5FB11481DB;
        Mon, 24 Oct 2016 17:14:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Yash Jain <yashjain.lnm@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reporting Bug in Git Version Control System
References: <CAN8fUZe4iWJCZYqBBDbNyPq1Dz7f4xvTNRVEZgg5AYN2NrKCbg@mail.gmail.com>
        <CAGZ79ka+_CUxQjB2R-EEk2nKmc_rbj_m7884fLvU9+NgJ5gUug@mail.gmail.com>
        <xmqqzilt61jo.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 24 Oct 2016 14:14:41 -0700
In-Reply-To: <xmqqzilt61jo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 24 Oct 2016 11:32:11 -0700")
Message-ID: <xmqqh98130vy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2B50EB2-9A2E-11E6-9CAE-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> On Mon, Oct 24, 2016 at 7:28 AM, Yash Jain <yashjain.lnm@gmail.com> wrote:
>>> Hello,
>>> I have two accounts on github("yj291197" and "yaki29").
>>> Both the accounts have different gmail IDs("yj291197@gmail.com" and
>>> "yashjain.lnm@gmail.com" respectively) but same passwords.
>>> I used to use git for "yj291197" account and a few days earlier I made
>>> this new account and used git commit to commit on "yaki29" but it
>>> appeared as "yj291197" committed on "yaki29's" repo.
>>> Then I pulled a request of that commit then it appeared "yaki29"
>>> pulled a request with a commit of "yj291197".
>>>
>>> And during this whole session I was signed in as "yaki29" on github.com .
>>>
>>
>> This is a Github issue, so ask Github support.
>>
>> Or read up on .mailmap files.
>
> I am (obviously) not a GitHub support, but I think the confusion is
> coming from not understanding who the committer and the author of a
> commit are and where they are coming from.  They are both recorded
> locally, taken from user.name and user.email configuration variables
> when the commits are made.  "git push" to propagate them to GitHub
> will NOT change these values of a commit, once a commit is created.
>
> The story described looks quite consistent if the user has
> yj291197@gmail.com configured as user.email and kept making commits
> in the local repository, and pushed them to either yj291197 or yaki29
> accounts at GitHub, without ever changing the local configuration to
> use the other e-mail address.  All commits would record the user and
> e-mail address yj291197, and the only one that may be attributed to
> the new one yaki29 would be the automerge created at GitHub when a
> pull request is responded on-site without first fetching and making
> a merge locally.

IOW, this sounds like Pebkac to me.  There is no a thing that needs
fixing in Git, and I do not immediately see there is anything GitHub
needs to fix, either.  The user may need fixing, though ;-).


