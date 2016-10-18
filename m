Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3238020988
	for <e@80x24.org>; Tue, 18 Oct 2016 15:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030328AbcJRPzF (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 11:55:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56746 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964865AbcJRPyt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 11:54:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B0B447683;
        Tue, 18 Oct 2016 11:54:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yZQO94/mlvuUPuyJTCGWtXLHP6Y=; b=tPRETd
        2fXimpo17Gd6VQFgiiOdg3MVhUr7rsoYTpp1WKU4VmZJeZSYi+23JX4G2ZYGr5o4
        Vb5G5qCTyeS9V9DR1pWis2v084p930XFr9BulQ6FdpHgrkdHgr1hj0fYBjJNmb1D
        yaJlS/CIgS5a1N+/Z8EAck22getrDaSiuEciY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CvZnqFQJU5iqWwl9P184gZLIp9brGRmG
        SALacs+Z+i/B8a1EwwagaBODrIzBR2/qvk7ZAZfnM9O1gBPDU7c//D1viU5r07D3
        4I2ilMQebXvwQ55MaEtoNVsHkLQzedJKP4vPBnvzYT5sIcmybTk0KSKsw777vgc5
        XAD9iroCTlc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0300D47682;
        Tue, 18 Oct 2016 11:54:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D6B847681;
        Tue, 18 Oct 2016 11:54:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 14/25] sequencer: introduce a helper to read files written by scripts
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <b554346c600fafa71d2a3461fda8402e377b596e.1476120229.git.johannes.schindelin@gmx.de>
        <xmqqr37ex5ck.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610181339550.197091@virtualbox>
Date:   Tue, 18 Oct 2016 08:54:45 -0700
In-Reply-To: <alpine.DEB.2.20.1610181339550.197091@virtualbox> (Johannes
        Schindelin's message of "Tue, 18 Oct 2016 13:42:36 +0200 (CEST)")
Message-ID: <xmqqpomxr6t6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31FFB910-954B-11E6-93CB-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In the meantime, I'd be happy to just add a comment that this function is
> intended for oneliners, but that it will also read multi-line files and
> only strip off the EOL marker from the last line.
>
> Would that work for you?

That would be ideal, I would think.
