Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CA7C4332F
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F35260527
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhJYWxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:53:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56199 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbhJYWvy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:51:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B3A7C16C629;
        Mon, 25 Oct 2021 18:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xWAZ6/iCa3eGUIITeiqWu0nbAIBsa48DA8OMSq
        rZuJs=; b=RK4t7bdj7U/5xkucq9g+2bF77SKMP4qHBivHBj2dhlSc77DgWw4HkQ
        S6qV9Kle07K/PeJJEw9lTxDqM2In78uiyFjfy6aU03bg6+Gd7r7N8qpP4gw9YLUq
        OByALBIlvG7I45Wbp0bJTtbrXFKeONV6Ct1CjMOK7OL150+oF1S1E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB25B16C628;
        Mon, 25 Oct 2021 18:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1D75116C627;
        Mon, 25 Oct 2021 18:49:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Subject: Re: [PATCH 2/2] color: support "default" to restore fg/bg color
References: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>
        <504da32a95bd4a1e4368aca68b609387316ea671.1635201156.git.gitgitgadget@gmail.com>
        <YXcyJBmRvIEVSiaM@camp.crustytoothpaste.net>
Date:   Mon, 25 Oct 2021 15:49:27 -0700
In-Reply-To: <YXcyJBmRvIEVSiaM@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 25 Oct 2021 22:39:32 +0000")
Message-ID: <xmqqr1c8zpmw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CFC6EC6E-35E5-11EC-A939-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> For an example of why this differs from white on black, let me mention
> that I use a semi-transparent terminal, where a black background is
> opaque black, and the default is semi-transparent.  I assume other
> possibilities include patterned backgrounds (Enlightenment, anyone?).
> Whether you want to include something to this effect in the commit
> message is up to you, but I provide it for the interested reader.

It would help support the description of the cause, I would think.

I am also OK with these changes.  [1/2] is good for completeness,
and being able to say "go back to the default" without having to
know what the default is with [2/2] is also a good change.

Thanks, both.
