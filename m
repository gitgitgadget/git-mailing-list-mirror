Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743F21FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 01:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbdJLBVX (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 21:21:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50747 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751782AbdJLBVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 21:21:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A558B5725;
        Wed, 11 Oct 2017 21:21:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MdCtH3aXE8d2KSd1XFYehVn9M4Q=; b=V15+ql
        BlFzuZPYSF3FXUQ00tP8mP1DvucA/2abtw1i4dnkV7IYa8CqtRyyfxy6YMM6mEhW
        Vbnh0+z8qBd6Mr5BrSta9v72d1WB3uEXOYuXCsNyaKx6w5YHLIsdpK/RR2HIOk0w
        mooNP1ICfHwj2Z3HGcNapHeHpBwdiHrd2fMPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sO/kEZbKbzdSLWv4LPD0iLP40y81oJdI
        i1Frhdm5UfPkNmGU0r8WkrmTjRG7iZgW0io1dUEInJKMlMq1OGsl3eTZGQq9cj3m
        Q8sN+IhyYW5+RKOfxLyr7jPbkYCBtBrEzxV2QB0W3Uhy7e9p8wIWxjUkyQ+jAuK1
        nLL58p3zrBY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10B85B5722;
        Wed, 11 Oct 2017 21:21:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61D32B5720;
        Wed, 11 Oct 2017 21:21:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Thais D. Braz" <thais.dinizbraz@gmail.com>
Cc:     marius.paliga@gmail.com, git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH][Outreachy] New git config variable to specify string that will be automatically  passed as --push-option
References: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
        <20171011202505.10113-1-thais.dinizbraz@gmail.com>
        <20171011202505.10113-2-thais.dinizbraz@gmail.com>
Date:   Thu, 12 Oct 2017 10:21:19 +0900
In-Reply-To: <20171011202505.10113-2-thais.dinizbraz@gmail.com> (Thais
        D. Braz's message of "Wed, 11 Oct 2017 17:25:05 -0300")
Message-ID: <xmqqa80x2mb4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A74328DC-AEEB-11E7-B78B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Thais D. Braz" <thais.dinizbraz@gmail.com> writes:

> ---
>  Documentation/git-push.txt | 3 +++
>  builtin/push.c             | 9 ++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

Can somebody explain what is going on?  

I am guessing that Thais and marius are different people (judging by
the fact that one CC's a message to the other).  Are you two
collaborating on this change, or something?

It puzzles me to see almost identical change sent to the list
without much explanation from multiple parties, with no apparent
inter-developer coordination.

Thanks.
