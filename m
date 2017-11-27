Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AE6020A40
	for <e@80x24.org>; Mon, 27 Nov 2017 05:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbdK0FXE (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 00:23:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55425 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751055AbdK0FXD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 00:23:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67637B24E0;
        Mon, 27 Nov 2017 00:23:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=USMpIig04OCKID7xcTwCrFgxc/I=; b=ayhFIN
        FcN3JD39nxXvatIJ/TlCrlSCQ9nXlQQt5s0DghnG+iIu79H7ebWpg2RL9j/HJE5R
        SHHxsHi8Z/PDpqNWuz8KWCt9ooiB4sJmaW4iIqRk9KYF0uGECy0/3jBvHa4CIr4a
        LdZq0IvHWKi292V7hRY/+/3vIl1H48N+CuATc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=akIoys2wmnFRxltGbuc5/fewHBuTGFmd
        qE7ZKvd5eIzZpmj8Eur+F2n/uUjcW0MEncUHBl1VmCozaVvNyzld1PeSv2ObqUuV
        Q2YWNlZUs8Rfiz3KbjH3I9zGhUQznd016Gsk1wBZre8ut6JBUxA219LmeCugm/ek
        oaFGVD0fqHs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CF92B24DF;
        Mon, 27 Nov 2017 00:23:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD686B24DC;
        Mon, 27 Nov 2017 00:23:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com
Subject: Re: [PATCH 0/5] rebase -i: add config to abbreviate command names
References: <20171127045514.25647-1-liambeguin@gmail.com>
Date:   Mon, 27 Nov 2017 14:23:01 +0900
In-Reply-To: <20171127045514.25647-1-liambeguin@gmail.com> (Liam Beguin's
        message of "Sun, 26 Nov 2017 23:55:09 -0500")
Message-ID: <xmqqwp2ccn2i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A5A0132-D333-11E7-BBAD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Beguin <liambeguin@gmail.com> writes:

> Liam Beguin (5):
>   Documentation: move rebase.* configs to new file
>   Documentation: use preferred name for the 'todo list' script
>   rebase -i: add exec commands via the rebase--helper
>   rebase -i: learn to abbreviate command names
>   t3404: add test case for abbreviated commands

I didn't send any comment on [1&2/5] but they both looked good.
