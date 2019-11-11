Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 052C71F454
	for <e@80x24.org>; Mon, 11 Nov 2019 09:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKJII (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 04:08:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61064 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJIH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 04:08:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2E1B39507;
        Mon, 11 Nov 2019 04:08:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y87P2QXCdh11mfeXc4X0RZnfR/8=; b=dFh+O7
        7tiSeBwtA3xyJjxnpVDqaJxQfFleIGWaq1RChvlcnB4UUkhSIoqBrNrDAwKe623o
        cVmtl9py0g+VxjVyKme7/gRchAkvRQYPALcRGmFP7kC461QQvwAyh8DW/MDuOBUk
        xPsr0rznWo+Hm3M57HyDVY4e97mvbwRJnj454=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s+3uXp3wa1V+omircFayQi1vqurB7aU9
        OxCGGKKIfkAuRq6MgeMKFXaO7G0VGXM4DQ6+7uRXRVi/cxntTGLNRNqaxitPkUs+
        NpgrMAGIZDATY5v/2jv1ZOuCCo8u9BiZl9N8SrNagCbf/gKkA9fMJfZADHu9yMmn
        wTCJK8G3vxs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AD8139506;
        Mon, 11 Nov 2019 04:08:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC27339505;
        Mon, 11 Nov 2019 04:08:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Naveen Nathan <naveen@lastninja.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: improve readability of --rebase-merges in git-rebase
References: <20191110095942.GB6071@a.local>
Date:   Mon, 11 Nov 2019 18:08:03 +0900
In-Reply-To: <20191110095942.GB6071@a.local> (Naveen Nathan's message of "Sun,
        10 Nov 2019 20:59:42 +1100")
Message-ID: <xmqqr22ehjbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C526F120-0462-11EA-9F3D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Naveen Nathan <naveen@lastninja.net> writes:

> When --rebase-merges was introduced in 427c3bd28a the sentence
> describing the difference between --rebase-merges and --preserve-merges
> is a little unclear and difficult to parse. This patch improves readability
> while retaining original meaning.
>
> ...
> -The `--rebase-merges` mode is similar in spirit to the deprecated
> -`--preserve-merges`, but in contrast to that option works well in interactive
> -rebases: commits can be reordered, inserted and dropped at will.
> +The `--rebase-merges` mode is similar in spirit to `--preserve-merges`
> +(deprecated) but actually works with interactive rebases, where commits
> +can be reordered, inserted and dropped at will.

I think the original "to the deprecated `--preserve-merges`" is
mildly easier to follow than "to `--preserve-merges` (deprecated)".

The later part of the sentence with this patch does read smoother
and is a definite improvement.

Thanks.

