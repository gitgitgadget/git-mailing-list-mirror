Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B1620756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbdAQVcU (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:32:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58167 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751007AbdAQVcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:32:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E411E611EB;
        Tue, 17 Jan 2017 16:31:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nBnTTiAFDqZBIaPbCEeMjs3Iims=; b=xYpjZO
        b8GH+Ynyorgatswq+rfQfdBDccxfTD7vCxYXqGTqN57xSJ0aRfm/y/EyZzu8RcWl
        gBnJ+RLde0rr+0m35YMKxlInNCqfNYU/nMqlBmb43u0oLlnfz534P76ipnoio3E1
        LQN28epJzvBPjdzfpeMmY77NxaULWuuRjY0wM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jDh4RL27HRNiVHZ+3DelPJe8aep8p/za
        shwtV34ZZIyXOsBPoNvGMK/s6qwu+9uvjoQtqDPfMQN/VadOtFc97AVRxZc6q4w4
        wwPyyiQG+MjRmv7ELS6MHYkVJW4pz9Cebb0pI4Snxs4DyhndZ2WXAKorY6+XuGtm
        7ejv8CO1ZlE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DADA4611EA;
        Tue, 17 Jan 2017 16:31:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34E65611E9;
        Tue, 17 Jan 2017 16:31:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v5 0/3] Turn the difftool into a builtin
References: <cover.1483373635.git.johannes.schindelin@gmx.de>
        <cover.1484668473.git.johannes.schindelin@gmx.de>
Date:   Tue, 17 Jan 2017 13:31:57 -0800
In-Reply-To: <cover.1484668473.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Tue, 17 Jan 2017 16:54:53 +0100 (CET)")
Message-ID: <xmqqwpdtcr02.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60A9093A-DCFC-11E6-AB6E-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> - replaced the cross-validation with the Perl script by a patch that
>   retires the Perl script instead.

Yup.  That makes things a lot simpler.  While we try to be careful
during major rewrite, we usually do not go extra careful to leave
two competing implementations in-tree.

Will replace js/difftool-builtin topic.  Thanks.
