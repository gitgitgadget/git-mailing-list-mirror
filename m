Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB90C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C9A610C8
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242679AbhIWSZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:25:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51833 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242677AbhIWSZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 14:25:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3092EF0F0E;
        Thu, 23 Sep 2021 14:24:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZsdcamINYiTOo17kyZ16hKzO8QvI7eOFNLzijc
        ZQPFw=; b=cQ+BkAgc2XIA84BAiNkfesv/znzPUdG2pA+5y8DUpCqXKBf5NK52VZ
        Son8mKJUKobIuVqNdrjFg9BO0UOPU09qMKMp1U/BTMQTwCCsDfD03cNB6TjUK47U
        c5q+QrlPqPUVVCO+a+lNHAfKL6ZLBEmXlknhq1UZ8Lsa1zLwOi4/Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28A33F0F0D;
        Thu, 23 Sep 2021 14:24:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 77CFDF0F0C;
        Thu, 23 Sep 2021 14:24:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/3] difftool dir-diff symlink bug fix and cleanup
 patches
References: <20210923041252.52596-1-davvid@gmail.com>
Date:   Thu, 23 Sep 2021 11:24:05 -0700
In-Reply-To: <20210923041252.52596-1-davvid@gmail.com> (David Aguilar's
        message of "Wed, 22 Sep 2021 21:12:49 -0700")
Message-ID: <xmqqh7ebywu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71201220-1C9B-11EC-9A9E-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> This is a resend of previously submitted patches.

Very much appreciated.
Will queue.
