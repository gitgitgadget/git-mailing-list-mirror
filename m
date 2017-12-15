Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A061F419
	for <e@80x24.org>; Fri, 15 Dec 2017 19:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755596AbdLOTfe (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 14:35:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53218 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755406AbdLOTfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 14:35:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4ED75BA7C9;
        Fri, 15 Dec 2017 14:35:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C14+Vz07w2a7lru7QdyOjwf9+nA=; b=ZgJBwZ
        NWNe7w92lWGqPvLgY5zMVq2YJ04TQIO9H7xkHOhBR8jbqQ8ni8mysh67uGglg3uw
        /0Gr2INCSXU/Ti+Kb+ZDh6Mxb4PrYIaj/T/Jj5b6mzjM07FmijuqRvgU20yCMUuS
        +UsLEW8Tko7ZjUn2sBe63GaCodZaJuO4wzNdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ogsgYkqigh9qPpDXc6JiGMQwnuBxN/Bq
        N4lW/MUo9ZNxAqD1rrb0HKcLoSvBTE6zItpZFUN/Fd1ZxnUjQ3AsjnyIQKLLGipN
        JVwwJk5d9OIJA8UtnHsh8zlUbRdUKOkcMXZvE7T6uCcOMakJVWh7kdKfM6NC/j/d
        E8XZ/dJeck0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45142BA7C7;
        Fri, 15 Dec 2017 14:35:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAD3FBA7C6;
        Fri, 15 Dec 2017 14:35:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Bennett\, Brian" <Brian.Bennett@Transamerica.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Eric Wong <e@80x24.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-svn: convert CRLF to LF in commit message to SVN
References: <BL2PR05MB2179DEBF7123ACD090E60F2685340@BL2PR05MB2179.namprd05.prod.outlook.com>
        <20171214002050.GA32734@whir>
        <BL2PR05MB217980546899C5B8EFDE06FF850A0@BL2PR05MB2179.namprd05.prod.outlook.com>
        <20171214234943.GF3693@zaya.teonanacatl.net>
        <BL2PR05MB2179566C1EAE01C2ED34E7CC850B0@BL2PR05MB2179.namprd05.prod.outlook.com>
Date:   Fri, 15 Dec 2017 11:35:31 -0800
In-Reply-To: <BL2PR05MB2179566C1EAE01C2ED34E7CC850B0@BL2PR05MB2179.namprd05.prod.outlook.com>
        (Brian Bennett's message of "Fri, 15 Dec 2017 14:11:25 +0000")
Message-ID: <xmqqshcbpyws.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D84BE96-E1CF-11E7-82A1-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Bennett, Brian" <Brian.Bennett@Transamerica.com> writes:

> Thank you all for your guidance,
>
> I have completed my test this morning with the patch and the 'git
> svn dcommit' is now SUCCESSFUl!

Thanks, all.
