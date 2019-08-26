Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94381F461
	for <e@80x24.org>; Mon, 26 Aug 2019 17:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbfHZRE6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 13:04:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61535 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfHZRE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 13:04:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8353817745E;
        Mon, 26 Aug 2019 13:04:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PyDFXUm7sd86KyTuHPAfaDtRlf4=; b=NsNkiD
        j26x2rqx0H/m/HEgaGET3mon5zvvJ8Uj96F1N3zeybQiXV+5I3ahjd/wzDgoez9W
        svCz/6S9nIpIMk3cAiuqn5A0ZjR+YI5fdHRUTongl/L/nUVe1KthN/BMksOK4vXh
        VQEhNLjsnsWyKw8QToal3UAD6ZEJ+wL9pcZpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UTlVOuS9WG7oyN0gf8wRL4ZFOxqAxG2p
        +UKHni0jzyK6wDzttlYXD5bBqqplIth8Pn/vOvk42pMFu4+klCMY3+9UBsBFsJyt
        eJSzLtUbnvc4pq24NqwXcTeUxRlO5UegR/NDtSo6AVyCe2GJmPKmKSSsMpe0i9n7
        IVWVeUZy4Xo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79F4317745D;
        Mon, 26 Aug 2019 13:04:55 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA68217745C;
        Mon, 26 Aug 2019 13:04:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Do use ALL_CFLAGS in hdr-check
References: <pull.129.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Aug 2019 10:04:53 -0700
In-Reply-To: <pull.129.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Sat, 24 Aug 2019 15:36:54 -0700 (PDT)")
Message-ID: <xmqqblwbj1sa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0304680-C823-11E9-929E-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> When I was playing with the Makefile target hdr-check, it looked as if it
> missed the correct CFLAGS. Without them, on Windows an attempt is made to
> include syslog.h, which does not make sense at all.

Makes sense.

Thanks.
