Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF298C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824766135B
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240445AbhERC7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 22:59:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57460 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhERC7B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 22:59:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BBFBDC1D50;
        Mon, 17 May 2021 22:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=fHt528KypulSyzDdzKFiMzQoAMo1rRn2kp29kHMz+iw=; b=KSdI
        dsbkLem+2RhfDYL1nvbJM2fvxvlDSJ7+nxvs2VsjTo8OJgaPqGoypT1A9GJZbFv4
        Z5uW5Yc/go3tiQMrIV8YqtMDQiwACFCpyVfp9kDTnoz3HhzlDxGbEKcaLlm9F068
        Bh3eK0wq1OgGal3Z8vWBFdyY2jQ7VITNdwD0rb4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3826C1D4F;
        Mon, 17 May 2021 22:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 46D67C1D4E;
        Mon, 17 May 2021 22:57:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>
Subject: Re: Re* [PATCH] doc: glossary: add entry for revision range
References: <20210516203736.1098072-1-felipe.contreras@gmail.com>
        <xmqqbl993irp.fsf@gitster.g> <60a245a927c62_126333208ea@natae.notmuch>
        <YKJZt4vFECoLZhc2@coredump.intra.peff.net>
        <xmqqpmxp6u13.fsf@gitster.g> <60a2daa57d8a6_13c370208f3@natae.notmuch>
        <YKMhqZNhamnKqWfi@coredump.intra.peff.net>
Date:   Tue, 18 May 2021 11:57:42 +0900
Message-ID: <xmqq1ra44ul5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0E35D38-B784-11EB-824A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> If you google for `git remote "set-head"` there's barely any
>> information. It's basically all online man pages.
>
> Why would people need to use "git remote set-head" most of the time?

I somehow thought Felipe wanted to say that there is nothing but
manual pages that mention the command and, "look how useful set-head
subcommand is, here is how you use it" blog posts are not seen
because nobody uses 'remote set-head'.

I do not quesiotn the frequency count of set-head, but I do not
think the lack of mention of set-head leads to the conclusion that
nobody uses "git log origin.."; there is a leap in logic.  As you
said below, "origin" is there without need for set-head, so the lack
of enthusiastic advocate for set-head does not mean anything wrt how
people find "origin" useful.

> The
> symlink is set up properly by git-clone, and has been for many years.
> For most people, using "origin" just works (the exception is people who
> "git init" and then "git remote add origin" themselves; since we're
> guessing at numbers, I would guess that _that_ population is less than
> 1% of users).
