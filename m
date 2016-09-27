Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40FD20986
	for <e@80x24.org>; Tue, 27 Sep 2016 00:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbcI0Aff (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 20:35:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58069 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755416AbcI0Afe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 20:35:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0556942E62;
        Mon, 26 Sep 2016 20:35:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AGDC614T1soYkmyQscTRQ6xM+JE=; b=cQJc4I
        ck3Ef0yZZGpcWk6pEYV44fI49Or3PoMjdnDUyGuEmdHf3nX2d06ZymDIgGZ6cciO
        t7s2f2K16ubb7tEyVlLDI9ctw275B4ShHKDbcJbNNe29Nh4H10tPStVe32HRqI+l
        RybAp5z/U9xJrQ9WvZJXWobX1FD88FebKGjvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jlmpXKH3wqa77R+HtDlTx4/GlGiyG7hw
        NV1JkEEtgkfRg2UpuOzPPKm/9X6RVzUW05phJK05L3e962j9XnVbE6nhj7TTZiG3
        46MqzBAv3FrDw+TQMjNBVH4xF5g0SHAxMWsvOsSoXjGAKeVVYbwqufhllgss2lH1
        jVmnh65R2aE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E596542E61;
        Mon, 26 Sep 2016 20:35:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CEE442E5F;
        Mon, 26 Sep 2016 20:35:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu
Subject: Re: [PATCH 0/2] tree-walk improvements
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
        <xmqqshsmqwfr.fsf@gitster.mtv.corp.google.com>
        <1474921343.13374.1.camel@frank>
Date:   Mon, 26 Sep 2016 17:35:29 -0700
In-Reply-To: <1474921343.13374.1.camel@frank> (David Turner's message of "Mon,
        26 Sep 2016 16:22:23 -0400")
Message-ID: <xmqqy42enpri.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BAAFA1C-844A-11E6-BA36-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <novalis@novalis.org> writes:

> Because truncated, to me, means "something that has been cut off". Here,
> the recorded length is too short, so it's probably not the case that
> something was cut off -- it was never right to begin with.

That's perfectly sensible. Thanks.
