Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 729EE1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 19:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbdLNTky (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 14:40:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51152 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751952AbdLNTkx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 14:40:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 10F0DC86E1;
        Thu, 14 Dec 2017 14:40:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XnKGvOF7KuWBFmufMfYfsk0N5lQ=; b=mKwaaZ
        BBopO7uk7Nq3uGbTxtu5+9wXKoSTsUE49+of31dWBZYivi4hapUW/bHtYd3XBt40
        cQLV+tY4HiO486tbA0WpcPnU9mdK898MUlDkGxyWeDeivd8G84FZup3bbGLGOw1j
        gyokm3yoksDQrCA/C3qV+Qh1LqDQxDmINsSaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VqlEtAza7FqntAvJ0BKFpd578D4Sp4q+
        HtIQnv62ckEbfmokPCBjLXPL10MWMrSEwrAmfAYknhdBp6f/KbShNV7LG/eQZKbp
        IBGT/V4RVOqO8e8dmsGFGfL+6/7uNyI6igF/Pf5djj4oDGmh54NkafgAw1+syyvO
        DvxsixLZLbI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0825AC86E0;
        Thu, 14 Dec 2017 14:40:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6468BC86DF;
        Thu, 14 Dec 2017 14:40:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "David A. Wheeler" <dwheeler@dwheeler.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Jacob Keller <jacob.keller@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox>
        <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
        <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com>
        <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com>
        <xmqq6099uqq9.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZeMVLesunBzW5hhN-snL8fBXdjPgy=Tt8JCDmhDePDZA@mail.gmail.com>
        <xmqqk1xpta93.fsf@gitster.mtv.corp.google.com>
        <6382776C-175A-4E27-8D7C-385FFF167535@dwheeler.com>
Date:   Thu, 14 Dec 2017 11:40:51 -0800
In-Reply-To: <6382776C-175A-4E27-8D7C-385FFF167535@dwheeler.com> (David
        A. Wheeler's message of "Thu, 14 Dec 2017 14:05:21 -0500")
Message-ID: <xmqqfu8dt7wc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1AB953C-E106-11E7-8985-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"David A. Wheeler" <dwheeler@dwheeler.com> writes:

> On December 14, 2017 1:50:00 PM EST, Junio C Hamano <gitster@pobox.com> wrote:
>>I agree with that.  I do not consider the proposed change "good".
>
> Why is "index" better? It is a confusing name, one that has many
> other unrelated meanings.  In particular, many projects managed by
> git also have an index, but few have a staging area.

That's an absurd argument.  A database product that wants to be used
in library systems are forbidden to have "index" because that may be
confused with library index cards?

> Also, the phrase "staging area" is already in use, so this is not
> a new term (e.g., git-staging).

That gets us back to the "'X acts like Y' is different from 'X is
Y'".  

Besides, the phrase "staging area" is a near-sighted and narrow
minded term.  It focuses too much on working towards the next
commit, and ignores there are other aspects that are equally
important.  When you check out historical revisions (without any
intention of making new commits, just sightseeing), for example, the
index does not act as "staging area" for creating a new commit.  But
it still serves Git users by keeping track of the list of paths that
came from the HEAD, and recording their contents and the cached stat
info for the working tree files (all using the pathnames as keys
into these data items).

