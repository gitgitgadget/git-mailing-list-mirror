Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22CA81F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 20:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbcI1UVS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 16:21:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54744 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753204AbcI1UVR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 16:21:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E9C740006;
        Wed, 28 Sep 2016 16:21:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MWCwix51+cb9wnKvrGep8eOVUg4=; b=E7lVUu
        bsK8dyq+Vhe/YH/r/42ZgxPTZd/1JKPFHiBmS2vMpLsUKldTYFtd8HosLZRN0Wb4
        dJ+AkU0qZjBrAjRlshoN8H5F22wuf678Wa9UVB52Ab3ICKQenym/xsGt1LCkLzyz
        Kjqqj67RHu+1q18CQiWsBueNqF7plkjlAQdqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MBRbmo8ppH2IUyDPRgk+JMTQX0E6lOWI
        RsnQvAknM8eBDUoJJcJY7cRFRowd3PJ8irSg03LnECTP8eb5iftANaO487IG0J59
        Y8D6uS2FAhup8X10+v9bIiNv1954axcai50thpufYL9pjf49hJYix7Zp/I3JvxAZ
        kA1w0HqI/Rg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 479DD40005;
        Wed, 28 Sep 2016 16:21:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C350540002;
        Wed, 28 Sep 2016 16:21:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] t5100-mailinfo: replace common path prefix with variable
References: <20160928194939.7706-1-me@ikke.info>
        <20160928195232.7843-1-me@ikke.info>
Date:   Wed, 28 Sep 2016 13:21:13 -0700
In-Reply-To: <20160928195232.7843-1-me@ikke.info> (Kevin Daudt's message of
        "Wed, 28 Sep 2016 21:52:31 +0200")
Message-ID: <xmqqoa37ixmu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B7F0A98-85B9-11E6-8E59-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Many tests need to store data in a file, and repeat the same pattern to
> refer to that path:
>
>     "$TEST_DIRECTORY"/t5100/
>
> Create a variable that contains this path, and use that instead.
>
> While we're making this change, make sure the quotes are not just around
> the variable, but around the entire string to not give the impression
> we want shell splitting to affect the other variables.

Wow.  I was half expecting that you'd say something like "1/2 plus
the SQUASH is OK by me", but you went extra mile to do it right.

Impressed, and very much appreciated.

