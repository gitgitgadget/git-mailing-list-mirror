Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF884C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8D6661164
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 19:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbhJOTa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:30:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56755 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhJOTax (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 15:30:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8555315FCD3;
        Fri, 15 Oct 2021 15:28:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GCIkOqMfETdxDp7Ea5fB4aA+Xroc/opIbhjZJW
        1yEQw=; b=wUkAk7BTDMZDz8W+xWu8ZqUc1bl6PRmcVk++nSUpFzgBkLy8TFGiXT
        CV21wyxOWQUgLepoFxh9hvJwl9XVcQSu5Y3UZBN3vTSTgFPe82HuPw6S+9RVYrX8
        XFO1Jt+AeL/77tKj6W4gDMtwjD3+xfXp2S2LBwrLyRgzrK4Y0DhDc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DB3B15FCD2;
        Fri, 15 Oct 2021 15:28:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC0C015FCD1;
        Fri, 15 Oct 2021 15:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v13 1/3] grep: refactor next_match() and
 match_one_pattern() for external use
References: <20211015161356.3372-1-someguy@effective-light.com>
        <K4711R.RVTNDQG3R0UQ3@effective-light.com>
Date:   Fri, 15 Oct 2021 12:28:42 -0700
In-Reply-To: <K4711R.RVTNDQG3R0UQ3@effective-light.com> (Hamza Mahfooz's
        message of "Fri, 15 Oct 2021 14:24:20 -0400")
Message-ID: <xmqqk0ie5bpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C22B70A-2DEE-11EC-B64D-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hamza Mahfooz <someguy@effective-light.com> writes:

> On Fri, Oct 15 2021 at 11:05:24 AM -0700, Junio C Hamano
> <gitster@pobox.com> wrote:
>> Makes readers curious what happend in v11 and later...
>
> It was my understanding that no comment means nothing changed since
> then, or is something to the effect of "no changes" preferable?

Usually people do not want to spam the list with a multi-patch
series when they have nothing new to show, unless there are other
reasons to do so, like "there is no change, but I am sending it
again because nobody seemed to have time reviewing the series the
last time", in which case that would make a good explanation to put
there.
