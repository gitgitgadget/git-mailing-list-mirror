Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88918209B4
	for <e@80x24.org>; Thu,  1 Dec 2016 23:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbcLAXnZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 18:43:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62502 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750775AbcLAXnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 18:43:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8335E545EE;
        Thu,  1 Dec 2016 18:43:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fG/RctLoqoBRreKOTYwnyXzdM/w=; b=O/AnYZ
        3JBurCHqtsHp9LMBL4K7gnfHwNNtvc12gre/HJoiMwUjq7SXN/7JPj5q7bj3ws47
        aDWVYfUQBv8ocdqEXKJwt0V86KQA+/yvGbfn9KnPkAt0SdBav2GRvile5Xg5d5H+
        Yv0JFYHFLPK4oRg3hJQ0EU5DJOsCtbzpvxn18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hiwqrG9lLd0eP6uboUXgUsEhiBbIZgeH
        +LPehXTmf5lYWaNGk/xvxtCqJbz3QiCcdobcWEW+t38lYygpgcjubbCVdU30Ja+e
        nKBaXrfcrDkLHAoSEmraylQAxJSMawWl1zZHI1/8RKGwjiBkR8qyB30cOSO9rXNS
        8aI9gu09NlM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C0C1545ED;
        Thu,  1 Dec 2016 18:43:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF67B545EC;
        Thu,  1 Dec 2016 18:43:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Brandon Williams" <bmwill@google.com>,
        "Ramsay Jones" <ramsay@ramsayjones.plus.com>,
        "Jeff King" <peff@peff.net>, <git@vger.kernel.org>,
        "Jann Horn" <jannh@google.com>
Subject: Re: [PATCH 2/6] http: always update the base URL for redirects
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
        <20161201090414.zgz7pimgpctghbwu@sigill.intra.peff.net>
        <331124b5-aa2b-773c-23ac-975ad3f50dbf@ramsayjones.plus.com>
        <20161201225331.GH54082@google.com>
        <2297C36B9A1441748D7E68363A05F8C5@PhilipOakley>
Date:   Thu, 01 Dec 2016 15:43:21 -0800
In-Reply-To: <2297C36B9A1441748D7E68363A05F8C5@PhilipOakley> (Philip Oakley's
        message of "Thu, 1 Dec 2016 23:12:49 -0000")
Message-ID: <xmqq8trz6wrq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F252260C-B81F-11E6-8A1D-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> Depends, I only know Mallorys who are women so her seems appropriate.
>>
> In a British context "Mallory and Irvine" were two (male) climbers who
> died on Everest in 1924 (tales of daring...), so it's easy to expect
> (from this side of the pond) that 'Mallory' would be male. However he
> was really George Mallory.
>
> Meanwhile that search engine's images shows far more female Mallorys,
> so I've learnt something.

"baby name Mallory" in search engine gave me several sites, most of
them telling me that is a girl's name except for one.

Didn't think of doing image search, but that's a good way ;-)
