Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759FB1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbdKHAQH (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:16:07 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59435 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750735AbdKHAQG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 19:16:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28CD8AF225;
        Tue,  7 Nov 2017 19:16:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XuWGXFa/UOndkYXe809NrK3DgXs=; b=EFotLs
        6gVKxCT30zqL1O5QwJHHXd256MLLDS4n8kApYBYpewgkzA+mHnYihGtyCqrgKqSK
        Q/o/y3sQpyG52UeeYSvjSaiT613RcdjD45C/7bMU6w5urQAU5xppwyDsu+k1err/
        +MiFFEgusZZkbeaKkHKY8GR+OX8STiUNpurOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D1tuSTlGL8cQ+jLAWIWR2Zbn3ZVx9fvp
        Y7Su2OoLC4UcLmHmh+w5p7j9JQHbs79arTUQkJK2ksm6eaZEWXvxRqIRVzrePENz
        SPea0hSfjVrQZAy6oun+t+jdnVEaygEjwokhq3sX+MkgAsQunWrP73fLW1ler8mN
        IcR9ANuse5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F3F2AF223;
        Tue,  7 Nov 2017 19:16:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 936ECAF221;
        Tue,  7 Nov 2017 19:16:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/early-config, was Re: What's cooking in git.git (Nov 2017, #02; Mon, 6)
References: <xmqqfu9rizwc.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711071311330.6482@virtualbox>
Date:   Wed, 08 Nov 2017 09:16:04 +0900
In-Reply-To: <alpine.DEB.2.21.1.1711071311330.6482@virtualbox> (Johannes
        Schindelin's message of "Tue, 7 Nov 2017 13:13:36 +0100 (CET)")
Message-ID: <xmqqbmkdpquz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02F92C42-C41A-11E7-B58B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * js/early-config (2017-11-03) 1 commit
>>  - setup: avoid double slashes when looking for HEAD
>> 
>>  Correct start-up sequence so that a repository could hang
>>  immediately under the root directory again (which was broken at
>>  around Git 2.13).
>
> Maybe change that description to avoid the word "hang"?

I agree that the verb does allow too many different interpretations
and not suitable one to use in these descriptions.  I'll replace it
in "What's cooking", so the topic merge to 'master' that will happen
later (it already is in 'next') will pick it up.

Thanks for being a careful reader.

