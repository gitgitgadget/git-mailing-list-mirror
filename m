Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81362021E
	for <e@80x24.org>; Sat, 29 Oct 2016 01:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935767AbcJ2BNC (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 21:13:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57617 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934339AbcJ2BNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 21:13:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4938E4BDD0;
        Fri, 28 Oct 2016 21:13:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XA8/aJAL8ni7vAT46e55S+NP2Gc=; b=hwTZ6e
        nLZo/+JLD4LOkN54FSwaWoAH5zBQlcQ2ZsnDRUdS6opdPePJzd1gKUn2hA5lgzu6
        sbDdUU5wr0Ecru045+SReiZvUn8W0dACbsp8+r9iI5psmdW1DSye2I8CGIs38gZH
        2gvHRW2hFTMcgKLepdVINypSjPdDg6AnwTz3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lYncn4MgrXkdcyDWYuZYqI57aS0fRjGF
        31zlYr2cXaher61ZU/k7dcXIP2lq9/zFN7k0Pkcetyw0smKS6lfbgZZ5wVVUiBDC
        VrPVNQL0I0FgUWjsQ15mzZfvlS4qmQK24WSryr7ZOPTMwm8HwPPzke32RpQJH9yq
        sTZHe8PH8dA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3ABD24BDCF;
        Fri, 28 Oct 2016 21:13:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 95E1A4BDCE;
        Fri, 28 Oct 2016 21:12:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4] Make other git commands use trailer layout
References: <cover.1477698917.git.jonathantanmy@google.com>
Date:   Fri, 28 Oct 2016 18:12:57 -0700
In-Reply-To: <cover.1477698917.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 28 Oct 2016 17:05:07 -0700")
Message-ID: <xmqqzilovtye.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4F9A64A-9D74-11E6-82E4-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This is built off jt/trailer-with-cruft (commit 60ef86a).
>
> This patch set makes "commit -s", "cherry-pick -x", and
> "format-patch --signoff" use the new trailer definition implemented in
> jt/trailer-with-cruft, with some refactoring along the way. With this
> patch set, the aforementioned commands would now handle trailers like
> those described in [1].
>
> [1] <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>

Ooooh.  Looks delicious ;-)
