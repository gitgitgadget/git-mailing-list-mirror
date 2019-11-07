Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6EC11F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfKGGVT (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:21:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60576 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfKGGVT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:21:19 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 16F5691AD0;
        Thu,  7 Nov 2019 01:21:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8D77q/e//UordkhwYuNeF3p6L/w=; b=fU6qP7
        kt/26z2IoAC+HRC88ogo5tshN77wG8QThf8pSCG4kyPvp/wvFp+/vAotv3A0KUY2
        xj1uII7Qj1fI8tYpMtoWrOWyh+m45Q2nHbnCMg4+h8nTmxpOOC3L/kf05gdKswNd
        QHhPRrmNjtfVczqWC1Al/tTygaeRZEgILDP68=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EMXMa469GgEcAs3DVJCYpFimQBbzQOWS
        HLFAZAjukYUCnMtlOa0zobSD7z3bthVet+Qrjz8uIMOsI37EAcGM8aHgsIIFUGNo
        i5ngzTX6qYqmjrjLaEaDR1bshqS8VxscgDIf2KBXKGqL4zTdjuMazq2hWF70MUNz
        jYYRUv3klEY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFCF391ACF;
        Thu,  7 Nov 2019 01:21:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0F95091ACA;
        Thu,  7 Nov 2019 01:21:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 0/1] [Outreachy] doc: remove api-index
References: <pull.456.git.1573044509.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 15:21:13 +0900
In-Reply-To: <pull.456.git.1573044509.gitgitgadget@gmail.com> (Heba Waly via
        GitGitGadget's message of "Wed, 06 Nov 2019 12:48:28 +0000")
Message-ID: <xmqq7e4cqk9y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDC448C6-0126-11EA-B3AE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Remove both api-index.txt and api-index-skel.txt as the API documentation is
> being moved to the header files, so the index is not needed anymore because
> the doc files (Documentation/technical/api-*.txt) will be gone.
>
> Make changes to Documentation/Makefile accordingly.

Why is this not part of the other series?  Without any of them this
step does not make sense, no?
