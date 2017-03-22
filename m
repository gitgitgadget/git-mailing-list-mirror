Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0806C20323
	for <e@80x24.org>; Wed, 22 Mar 2017 18:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965446AbdCVSPi (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 14:15:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64758 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934813AbdCVSPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 14:15:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE3A77DACD;
        Wed, 22 Mar 2017 14:15:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QXTVKhldTNQ/9R+4rXqQILRjnB0=; b=ZB8Oic
        0JU0s3F8o7Kpp1phPYGvigP/vNHEaWh0OSCQS2iVZo7HYiEk2UhDcJrjQdyo904y
        afCj6k7os5I4JtMCd74Dvu0x6PoOCs7V48VJ/O3gVb6N1sy2bT7L0pZWVz5yDIlY
        7BKVWXrsN3F+0+DtmAD3Mcap/xnABYS86oKzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s/3vsebbRjaH611xrxLRqODq74+7SJrd
        b1tHV2ayyk5RcSQNlI5zmPIty14WNNzCQCh4PchYa4YgazePPaju3J2EoWlV4SZe
        /pYhXm2wWOb56O4s1sTYYJSt8Yky8j35dtcZ5VwDm9Gbh5ynCprcpqsInyYLL89K
        UTTAxdbvGpI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B77CA7DACC;
        Wed, 22 Mar 2017 14:15:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 185A27DACB;
        Wed, 22 Mar 2017 14:15:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] t7504: document regression: reword no longer calls commit-msg
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
        <773531a3892fb78e8f70e540fc000bceb2c1bb7b.1490194846.git.johannes.schindelin@gmx.de>
        <CAHGBnuPL9CUincZkFR758KcZL3-Ra=n_fbsc1EQ=vio2scod5w@mail.gmail.com>
        <alpine.DEB.2.20.1703221704500.3767@virtualbox>
Date:   Wed, 22 Mar 2017 11:15:32 -0700
In-Reply-To: <alpine.DEB.2.20.1703221704500.3767@virtualbox> (Johannes
        Schindelin's message of "Wed, 22 Mar 2017 17:09:38 +0100 (CET)")
Message-ID: <xmqqefxpkwjf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A956F52-0F2B-11E7-B75E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In any case, this is *test* code. So I'd prefer to have the changes to the
> C code scrutinized a bit more, not the test code as long as it is obvious
> what it does.

I do not think the tone of this comment serves any productive
purpose.  People have strengths in different areas, and those who
can spot issues in tests better than the C code should not be
discouraged from suggesting improvements by getting scolded like
this.

Also remember what is "obvious" to you may not be obvious to others.

Thanks.
