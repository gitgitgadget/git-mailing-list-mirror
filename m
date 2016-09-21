Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699281F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756929AbcIURZP (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:25:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56360 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758084AbcIURZM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:25:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 652C43EAFA;
        Wed, 21 Sep 2016 13:25:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xpCmfmLuns/HdbCeN8e9t2bNJXs=; b=rcTT8v
        HTaLDtxRiNCA4fDJeaB+ZfjKiTNOGh0+z+G/FqZ64XZNfou2q4MPwj/lTQINPPmo
        Af0Vy/sz4roHmOoFJZ/TuvmeXQYOOgGGzrLEUm8tL//y1jQX6r6SF1oel3x4p6jJ
        9BjFPV/5UXRRzRoq1G/2KLN7t29j5nHhWo28o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RDEwWyTbLbWEcQFnSyQZPK+xnP2HsFdh
        VLNvgiygBPw3TOoWQuYj3hbQ0DNo6hhXr96094cncCeNuf/w+J631JgVxKf7YqmN
        hbPtTCc9UruMXeBRyJwS80BFJHJ7/gMTlSLquSK0CXe4lRx/17t3gdJb1F6OiZif
        PQfC64kK7ao=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DABB3EAF9;
        Wed, 21 Sep 2016 13:25:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BAE53EAF1;
        Wed, 21 Sep 2016 13:25:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] handle multiline in-body headers
References: <cover.1474319086.git.jonathantanmy@google.com>
        <cover.1474391594.git.jonathantanmy@google.com>
Date:   Wed, 21 Sep 2016 10:24:47 -0700
In-Reply-To: <cover.1474391594.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 20 Sep 2016 10:17:50 -0700")
Message-ID: <xmqqbmzh9nds.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5768F2C4-8020-11E6-AFB8-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> With the above change, it is actually no longer necessary to make
> is_scissors_line take plain char * (the second patch) - I think that
> that patch still improves the code, but let me know if you want me to
> remove it from this patch set.

I agree with you that it is an independently good change.  Let's
keep it.

Overall looked very good.  Thanks, will queue.
