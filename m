Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3CB61F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 03:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbfJ2Djr (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 23:39:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55412 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbfJ2Djr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 23:39:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8EF22E1C0;
        Mon, 28 Oct 2019 23:39:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IYAhEGnAXxdXaCPP2qOWIuV48m8=; b=rX5EKj
        eebLI5y1LnsBrvzbwZzYCHmNOWm2p4Jp4I8swzrNu7jpuXplzRE5c7QWlGyJcbAU
        WaswalfCAHoMUT+6K3ro5F5ybtFc1aEgD8Nl89jTtCBoZpn+b4cy6DTpOlvkxYTh
        +y0LZXFnyFVzHPYujyaf9Hl70U1f2yIbGdZ9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KJwm/uEyajlOvpdQD+Y37SQeoR4dWNmP
        /GPAObOsIhxrSv4jboElDHBS7dgsg3DXDmNgOxRAnRQP89PlnwvT1luDCTJk6DN+
        h8QqiaWm0hp9lFqhiQSQ50LsAolhM4ShW3UvQSlOiX/zn3XPyYrhim49kzWzWZNL
        ulvONnQV/LI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE8D32E1BF;
        Mon, 28 Oct 2019 23:39:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AD1B2E1BE;
        Mon, 28 Oct 2019 23:39:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/2] Handle git_path() with lock files correctly in worktrees
References: <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
        <pull.401.v4.git.1572267438.gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 12:39:44 +0900
In-Reply-To: <pull.401.v4.git.1572267438.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 28 Oct 2019 12:57:16
        +0000")
Message-ID: <xmqqy2x45if3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C06D7ECA-F9FD-11E9-80F7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v3:
>
>  * Instead of duplicating the path when it has a .lock suffix, we now use 
>    strbuf manipulation to strip the suffix temporarily.
>  * The test case in t1500 was scrapped in favor of a much simpler pair of
>    test cases in t0060.

Makes sense.  Will replace.

Thanks.
