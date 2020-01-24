Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CA6C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7292075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uQuIXKbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbgAXVSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:18:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56537 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387448AbgAXVSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:18:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8F50421D6;
        Fri, 24 Jan 2020 16:18:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lCHDUbqkTsWHXCG/03MLYWeRxZU=; b=uQuIXK
        bNYSqvtpPQoB0rcO/7IcK6iVfb/OvAz9KIuiwrKiwRD46g6IR7hCXniFmfrrVlkE
        qTub4+8Pu9fP7V6aeLwMzP1K3MD1/O7qYrzA8w6OYG+VmwRLaNbs4ejTBwZLeaGT
        Yep8kn/f5YDsez1GWhRQxg58xXW9rXF13sh2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KB1noh3p9p69T+wf2PeBQ+FZuwA5KEgu
        b9DdkUxWmVzL0YfvssYP1t8VrPNw7ZxMQUrcDd7H4ARAXLiRVAt8sRyvry0hLX/s
        foK7N3i7qLTGRjBQr5AZlWQAArGS6en4F4P/tsR1jQDpMWsCnu4QyrTKis2AQqx/
        vEFaIneBVS0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E08EA421D5;
        Fri, 24 Jan 2020 16:18:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F669421D4;
        Fri, 24 Jan 2020 16:18:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6] MyFirstContribution: add avenues for getting help
References: <20200124210148.220007-1-emilyshaffer@google.com>
Date:   Fri, 24 Jan 2020 13:18:36 -0800
In-Reply-To: <20200124210148.220007-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 24 Jan 2020 13:01:48 -0800")
Message-ID: <xmqqtv4ky2mr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15E105F8-3EEF-11EA-B311-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +This is the main Git project mailing list where code reviews, version
> +announcements, design discussions, and more take place. The Git list
> +requires plain-text-only emails and prefers inline and bottom-posting when
> +replying to mail; you will be CC'd in all replies to you. Optionally, you can
> +subscribe to the list by sending an email to majordomo@vger.kernel.org with
> +"subscribe git" in the body. You can also browse the
> +https://lore.kernel.org/git[archives] in your browser.

Let's not place a stress on non essential part (i.e. viewable in
browser) over a more important stuff (i.e. this is where archive is
available).  How about this as a replacement of the last sentence?

	The archive of this mailing list is available at
	https://lore.kernel.org/git[archives] to view in a browser.

