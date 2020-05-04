Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA98C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DCB20705
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C7mWHJhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgEDP4j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:56:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55704 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgEDP4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 11:56:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A44A5BA11C;
        Mon,  4 May 2020 11:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z9721/1QBOvFN0kQNuUEvG8KD7g=; b=C7mWHJ
        hvnVDfNbmGYULaqBl9ehnDezO8JOKo4EjhaKarLDRFbw5cR6shD8rgmtmS6xU+kT
        voc3su4MkzSN0/EAFehKs9HlF2b6D/95pEXtp6KDB/2bvFAEU0VWgVwJAHtVVFwW
        m++jeMkRfKQmO9MTxeemmC31vXmpC7JXWdpFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gOPWNqf1RiWwHsr+fZ90AqI5VlkpsGr6
        IFfDOayb1iSD09cfH6aTpBSdKVFdnBr2tPEAKOwbiNZNM3T20QvxymUFJk7U2uef
        HkQQPuPwrObyaEbfWKxxxNai3tdLpiO+A6B0BBTQfWe9dnJFzbFWhE8qo45hLtc3
        ySaAIyq8hbo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C50BBA11B;
        Mon,  4 May 2020 11:56:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D69D3BA11A;
        Mon,  4 May 2020 11:56:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Minimal patch series to fix the CI runs of hn/reftable
References: <pull.623.git.1588599086.gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 08:56:33 -0700
In-Reply-To: <pull.623.git.1588599086.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 04 May 2020 13:31:20
        +0000")
Message-ID: <xmqq8si7ithq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D486A984-8E1F-11EA-972A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> These patches are not intended to be complete, not by any stretch of
> imagination. They are just enough to get the CI run to pass, even in the
> Windows-specific parts.

Thanks.  Now I know at least somebody has been paying attention to
call for help in the past few issues of the "What's cooking" report ;-) 

