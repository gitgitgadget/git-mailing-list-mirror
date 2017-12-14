Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFC21F404
	for <e@80x24.org>; Thu, 14 Dec 2017 17:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbdLNRUl (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 12:20:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50925 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753376AbdLNRUk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 12:20:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D80B6C68AD;
        Thu, 14 Dec 2017 12:20:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hkogQpsbq9qCvVNhk5oB5j0/DPw=; b=CW2Xdx
        MWDbtoNX2xNP7PX9dzoKh/G3SEDVaRUr8yOkpT5YpaxgGqbvZf6zeTt5bvryzVM2
        sESgngTcT41tleXCXOZnQgPYII6JEmUlGLNCvLc5oTI/oZwJ6rawSmisnR9DddHc
        SlAFP4qOgJ+s+lzUrQgXrdDxJyC+dI2FJQBFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PagedqOF+xzYYAMPoC8shEu5UVSxnbCO
        0Oc67hSXq4t93z9eMzePYv/QxTbLB6sJf1z5taeFo6BbvGUU5FwQ+saxTKeYAmk7
        ok2XcGvVJMmy1ACDEmEPfS/8rioPqv4OZYxFYLsGdnec1xNkUUvKtlivuPO+Jg2K
        auSNsXaufVQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D047DC68AC;
        Thu, 14 Dec 2017 12:20:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43C78C68A9;
        Thu, 14 Dec 2017 12:20:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
        <1513255038.6351.2.camel@gmail.com>
Date:   Thu, 14 Dec 2017 09:20:38 -0800
In-Reply-To: <1513255038.6351.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Thu, 14 Dec 2017 18:07:18 +0530")
Message-ID: <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B02DFFE-E0F3-11E7-B48E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> It seems my series that fixes an error message in 'git-rebase'[1]
> (apart from a little cleanups) is missing. I guess I addressed the
> issue that was raised in 3/3 as a v3 for that patch[2]. Are any more
> changes needed?
>
> [1]: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
> [2]: <20171201060935.19749-1-kaartic.sivaraam@gmail.com>

I think you only sent 3/3 in newer rounds, which made it not to
apply to my tree.  If you meant to drop changes in 1/3 and 2/3,
perhaps because they were needless churn, then 3/3 needs to be
updated not to depend on the changes these two made.

Thanks.


