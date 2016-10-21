Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A0F20229
	for <e@80x24.org>; Fri, 21 Oct 2016 16:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932467AbcJUQsZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 12:48:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54739 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932372AbcJUQsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 12:48:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27CAC47822;
        Fri, 21 Oct 2016 12:48:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aJekUglr+7M3wHKdwpVhlZUsjEE=; b=pEJAo5
        HdAyHvdVU2H72khnED5dSSwFi9olwKl0F9qrvQXLdyVfWSEwC1q+DixT/3pYu897
        g9CNCQxaymomRSfYa41ldMN5tmLCptmZTcgqd8lftmt5ZgS/2CLu+mveh7J/1Ljz
        FR089d3g4cxfcLy9ed8Li+Qk0Lo/cp1LtWXho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DZ/GMCp3tn6Hn5wxwE7Ywkyphoz9gsBi
        tjdOaIY/p2MASdtMdRLTAwUrvvw1c1VLWV2371q1/gbk1zXEU1qdRTucMK+j9tpC
        DdTP1FsJfeqgmOEgRQhpEuVLglmWWhC7aLcjGRncdm4ANDx6lt451DyYyCx7D0VC
        mhJxwi5Tbzw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E08047821;
        Fri, 21 Oct 2016 12:48:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 910864781F;
        Fri, 21 Oct 2016 12:48:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/2] t9000-addresses: update expected results after fix
References: <xmqq1szaeda9.fsf@gitster.mtv.corp.google.com>
        <20161021092024.15861-1-Matthieu.Moy@imag.fr>
Date:   Fri, 21 Oct 2016 09:48:20 -0700
In-Reply-To: <20161021092024.15861-1-Matthieu.Moy@imag.fr> (Matthieu Moy's
        message of "Fri, 21 Oct 2016 11:20:23 +0200")
Message-ID: <xmqqh985d4x7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D932E1A-97AE-11E6-9E47-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> e3fdbcc8e1 (parse_mailboxes: accept extra text after <...> address,
> 2016-10-13) improved our in-house address parser and made it closer to
> Mail::Address. As a consequence, some tests comparing it to
> Mail::Address now pass, but e3fdbcc8e1 forgot to update the test.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

Thanks.
