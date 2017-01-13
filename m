Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C712D20756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750914AbdAMSc5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:32:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63808 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750760AbdAMSc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:32:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 308945DB90;
        Fri, 13 Jan 2017 13:31:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q7asyTQPM8IXdwI/lDnUJCz/u0k=; b=m1iELJ
        kkRGzURsfU8XFHCD5K9Pdr0V7785pmAAurJjQ7oPaikmLX4KrzSfCjyOnaIvWMOB
        /vClJ5EsRyC+nafOc+w2eqN9nNfQNXtKywd1cpwgbI5XcoVeKlxjRCYkQXmZf+P8
        QOD2ABodf7uD5MwL08xrT/YLqudeXO5xMEUdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JBdFMvbUaTr6jGgWlMWXuHHXO1dLNSTv
        yxqH7HnAHZj0NmIglYDXE4GEmhpwdA0KtWn5MCgnV0cZY/U0Z1kNGfyqWjAFZfZD
        /Fq5W60M0T34s9meBG02EPSyl2z+iyi1eTyx6uKRl8JFWQ515VMwU8f4QyXtFoTx
        XSbmE4Jbmko=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27C6B5DB8E;
        Fri, 13 Jan 2017 13:31:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 605DF5DB8B;
        Fri, 13 Jan 2017 13:31:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?66eI64iE?= =?utf-8?B?7JeY?= <nalla@hamal.uberspace.de>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by `asciidoctor`
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
        <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
        <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
        <xmqqbmvi34ul.fsf@gitster.mtv.corp.google.com>
        <20170108032709.k43zmej5lxmcoj4o@sigill.intra.peff.net>
        <xmqqinpmpld0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701121130190.3469@virtualbox>
        <xmqq37gokrdj.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 13 Jan 2017 10:31:28 -0800
In-Reply-To: <xmqq37gokrdj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 12 Jan 2017 11:30:48 -0800")
Message-ID: <xmqqziiuhkvz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FE50506-D9BE-11E6-963F-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  Perhaps 1/2 posted as-is
> is the best we could do within that constraint.
>
> Let's queue it on 'pu' and see if somebody else comes up with an
> update that is more visually pleasing with both backends.

... and I noticed that I didn't get to actually queuing this
yesterday, even though I sent the message above.

Now I have, and the patch will be part of tonight's pushout.

Thanks.
