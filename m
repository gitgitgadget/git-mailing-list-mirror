Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BABEC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2542F610FC
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhJ1QoX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:44:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57566 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhJ1QoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:44:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B97AF7B20;
        Thu, 28 Oct 2021 12:41:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D2vAHUi/KWyRMg4tPQ1kFw9EXDy7tTyy5uumbp
        /jASo=; b=PgrLwgSEY/cnf8CdRSO/b0VWe/+Nmt1eybIzClUEtucuzNWNMUfBOJ
        cuPmhBViYq5y85IgcrbJtzHDMhvrfYTQUeaOihpZMtubvY66J0aXKn51K/BPGC2g
        8is/K6gCYte+pJ93G69388iQgJI064DLrc+KwPqnaxcHpGPm3dY5U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 521CEF7B1E;
        Thu, 28 Oct 2021 12:41:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B5D8FF7B1B;
        Thu, 28 Oct 2021 12:41:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Estelle <robertestelle@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] color: support "default" to restore fg/bg color
References: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>
        <504da32a95bd4a1e4368aca68b609387316ea671.1635201156.git.gitgitgadget@gmail.com>
        <YXcyJBmRvIEVSiaM@camp.crustytoothpaste.net>
        <xmqqr1c8zpmw.fsf@gitster.g>
        <CAMmwyQor1AekB9cCUE3osLJeb2r_w0q0T1JqUcNFk6L=7O2-Jg@mail.gmail.com>
Date:   Thu, 28 Oct 2021 09:41:51 -0700
In-Reply-To: <CAMmwyQor1AekB9cCUE3osLJeb2r_w0q0T1JqUcNFk6L=7O2-Jg@mail.gmail.com>
        (Robert Estelle's message of "Mon, 25 Oct 2021 17:54:50 -0700")
Message-ID: <xmqq4k91t834.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4647E72-380D-11EC-9A6A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Estelle <robertestelle@gmail.com> writes:

> Those are good examples. Note that this applies to more cases than
> those relying on transparency or patterns: color terms often have
> defaults that are not identical to their ANSI palette. I suspect
> *most* themes are probably this way, based on a quick sampling.
>
> You can see a bunch of examples here:
> https://github.com/mbadolato/iTerm2-Color-Schemes#screenshots in all
> the themes where the background color in the "40m" column isn't the
> same as the unset column before it. (All of Terminal.app's built-in
> themes are that way; I know xterm defaults to black on white vs white
> on black; and so on).

I think you are wasting your time giving these to _us_ on the list
who happen to already understand what the issue you are attempting
to fix with these patches.  The suggestion was that you would help
future readers of "git log" if you wrote even just one or a few of
them in your proposed log message.  Those who will be digging the
history, perhaps they want to fix something in near-by code, may not
be aware of this discussion but the log message is a good place to
leave a note for them.

Thanks.

