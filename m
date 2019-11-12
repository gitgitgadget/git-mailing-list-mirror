Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D59A81F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 07:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKLHCk (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 02:02:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53908 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfKLHCk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 02:02:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D108D1A7B5;
        Tue, 12 Nov 2019 02:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bo7FormY57+Y8WQlnR0jhLqzXZw=; b=IOVaa2
        9lRmD36eAiZAIisncWAYTbFy/XZzDUp57Z+YmkBoEfe2AUZXs8rXvo19KYTrGbBQ
        Vw8d1X/UvWiuGifB767GWnWkCgDMMH00w3VpoXSyr3pumtUAPa/IjFQhjNE8NjYd
        Xhf17SxKfT1721F8F8tB6rGisPuUs1XNfmMNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rNIPSwhRkWmIRpw1szq0T3/xQJvIoXM+
        0fxQvrYUmjck1YkRU9z5P8WnT3DMLAdFQFc2faHBgUQ5jz+DCoHUqYS9EvXDcFv3
        tVsTTlPjqryACOlDp5eO7QGwoWrSvI3uJTV1JW28Ob5YWm+upU8Hlzg/FB7oBeqU
        fYGZlGgek+g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8C7D1A7B4;
        Tue, 12 Nov 2019 02:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35C0C1A7B3;
        Tue, 12 Nov 2019 02:02:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v3 20/21] trace2: move doc to trace2.h
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <a337f88a55ddaafd5754492ae0399137966738a8.1573507684.git.gitgitgadget@gmail.com>
Date:   Tue, 12 Nov 2019 16:02:38 +0900
In-Reply-To: <a337f88a55ddaafd5754492ae0399137966738a8.1573507684.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Mon, 11 Nov 2019 21:28:03
        +0000")
Message-ID: <xmqqv9rpefw1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69E8A2E6-051A-11EA-A77B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -182,267 +182,7 @@ All Trace2 API functions send a messsage to all of the active
>  Trace2 Targets.  This section describes the set of available
>  messages.
>  

We said "this section describes..." and then ...

> +Refer to trace2.h for details about trace2 functions.

... say this?
