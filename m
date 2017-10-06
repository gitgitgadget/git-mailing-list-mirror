Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9821FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 05:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbdJFF0C (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 01:26:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56721 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750781AbdJFF0B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 01:26:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA5849C4B4;
        Fri,  6 Oct 2017 01:25:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jVhlE75i8RWzB26belvT/dgMB5E=; b=tkTYew
        5zYmNk1XyhGsr1CZm0NHqOQ1BraCx6prvCktpef5XO9KE+Ka5ZYv+pGOeZ+Gnyjm
        GAiFVHmA0Dghuc+Hfzc9MOIkjuGjNXZLjHtMKFNkYBiQtTAxh60BHEbQJPEs0g3F
        OpttB9xkBQu8H7XtvqNNAKoAy1W53MV+mrEUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hcv3Yld1L25tFuaHVv2SUHFKoxJXfRVn
        NEADcNCl/4iew6myuBwrEYl+cXQL3ZxqTdjjHg9TJKCYZnNpVUHTscMrW4dUWft2
        RSMd6sRJf+RqoLj2jCIW17nB+kCvEtKfyfxip5oldXS+NOWUZtCg3frNz/lJeI5Q
        WA0AVqNzWNA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF7CD9C4B3;
        Fri,  6 Oct 2017 01:25:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CFA99C4B1;
        Fri,  6 Oct 2017 01:25:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien =?utf-8?Q?Mari=C3=A9?= <damien@dam.io>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] run-command: add hint when a hook is ignored
References: <0102015ee1e41f17-927a8da1-ac14-4399-8424-fee8a82c2b0a-000000@eu-west-1.amazonses.com>
        <0102015eee503678-52126849-7580-4832-9d46-0f5ac7a52336-000000@eu-west-1.amazonses.com>
        <xmqq4lrcyj1p.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 06 Oct 2017 14:25:57 +0900
In-Reply-To: <xmqq4lrcyj1p.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 06 Oct 2017 13:52:34 +0900")
Message-ID: <xmqqr2ugx2xm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D56216A4-AA56-11E7-B929-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/t/t7519-ignored-hook-warning.sh b/t/t7519-ignored-hook-warning.sh
>> new file mode 100755

Another thing; t7519 is taken by another topic in flight.  Let's use
t7520 instead.
