Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91377207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 19:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161531AbcIZT0T (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 15:26:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50887 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034564AbcIZT0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 15:26:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 990AD402D6;
        Mon, 26 Sep 2016 15:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C88tpNqS5wd+bpq3hiH1uaIdkaY=; b=FrBN4D
        wjw2nEVz6FeD3wlrculO7syTjdxmt1pnVVn3rXfxgIFHDpBkr2gQ+TnSA/ZE6SPJ
        Ra9tb8/sEbGAeXNItqTeyhbrW00cnkIsoa6CSdq2rXQXMOy5ae5CMJSximOKKNT8
        usgAOKY463vPIFNmg+5gf3tL0DcUoMRH/Qa8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Whz/rPWkU28PPkGGMfMTFeZICTm/Myp1
        L342v9bj3DoTrWv149DRRp+N5tMkFEpKiZyfCX5WzvjwLgBsalU2V1KdSIGiAotD
        MjcgJYG/xKXWa5UKFbpUBHbK+rcuZmFtBMxMnY4j5QTwP3uZc/gl5SdQCesjX4Mt
        O+34ARO9Zdc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B48A402D4;
        Mon, 26 Sep 2016 15:26:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0889C402D3;
        Mon, 26 Sep 2016 15:26:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] mailinfo: unescape quoted-pair in header fields
References: <20160919185440.18234-1-me@ikke.info>
        <20160925210808.26424-1-me@ikke.info>
        <20160925210808.26424-2-me@ikke.info>
        <xmqq4m52scg7.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 26 Sep 2016 12:26:13 -0700
In-Reply-To: <xmqq4m52scg7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 26 Sep 2016 12:11:52 -0700")
Message-ID: <xmqqzimuqx7u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17DB9DDE-841F-11E6-96E9-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Don't these also need to be downcased if you prefer $data over
> $DATA, though?

For now, I'll queue a SQUASH??? that reverts s/DATA/data/ you did to
1/2 between your 1/2 and 2/2.

Thanks.
