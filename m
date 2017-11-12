Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB30F1F43C
	for <e@80x24.org>; Sun, 12 Nov 2017 05:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbdKLF6X (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 00:58:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51432 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750903AbdKLF6W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 00:58:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2C5BB6EA3;
        Sun, 12 Nov 2017 00:58:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uFYEQrOBnRUhOLNxg04aW/0mGzk=; b=N91xEl
        m9RZfGBsufBtWrErn+lRPHQiQ+nHDL87LXaBbVFz2kz+ZVdqSFkHI6p1J+Nyqr+9
        M/Wa4wC4E1977tODWn54SttCm6f1S9MkiQIwWp5DhN4Ygt8s5Iig7rHQEWnkYQv+
        RpTfIpUaM3CTYo+DxAt6BiPUIkRP+rkNVyxrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qpVCK8nmmL/gLIgNpfl9/oRtLYdzrYH3
        o8p6bUimNv25rjibJGZ0U8ruW8pu5XR28Lw9Utd2ZXpVL8kukgxoqG6dYHbltcMt
        ezkG5mKjaCmXjhdOdH6vA+cPm59zpeVOEzbE2fRqbHD9r9f6z6ywiKqeHvSvULNt
        HgF18r6qGN4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA35DB6EA2;
        Sun, 12 Nov 2017 00:58:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2D3BCB6EA1;
        Sun, 12 Nov 2017 00:58:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerzy Kozera <jerzy.kozera@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: Strip CR chars for Windows gpg2
References: <20171111160657.11016-1-jerzy.kozera@gmail.com>
Date:   Sun, 12 Nov 2017 14:58:19 +0900
In-Reply-To: <20171111160657.11016-1-jerzy.kozera@gmail.com> (Jerzy Kozera's
        message of "Sat, 11 Nov 2017 16:06:57 +0000")
Message-ID: <xmqqa7zsca2s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CC92C28-C76E-11E7-97C2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerzy Kozera <jerzy.kozera@gmail.com> writes:

> This fixes the issue with newlines reported at
> https://github.com/git-for-windows/git/issues/1249

Do not omit the description of what you wanted to do completely and
force readers of "git log" to visit an external website.  You are
already bothering to write "issue with newlines"; it shouldn't be
too much to complete the description by saying what issues around
newlines you are solving, before saying "reported at".

Thanks.
