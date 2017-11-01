Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AF9920450
	for <e@80x24.org>; Wed,  1 Nov 2017 01:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbdKABVL (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 21:21:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62998 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752175AbdKABVK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 21:21:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B00D7B8EBB;
        Tue, 31 Oct 2017 21:21:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wIjaQPT1vPZsZ2jBgtRnTON+6Xg=; b=npOGcy
        +8xhTY4ZQrSquZxYMMbDJv/BmTkTh6Dnu+78DKXoXqtDesqKPE9c2FX2Vva8Lkx0
        4L5DZCTIK/jh/BFg630LPlMvniqDSiELPnEtZu/BA+3lB54M8xhXEAroGX7ZmIKe
        elvAtuo+qRWH3gy5F8qBMECLII7CKZerBRJnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gTUWbLuUptVYrgjbkMp9MZPXBAjJpz7r
        tiJMlIX6cb4II6c3/xPNiAoRaTCwCR41VALLV5DFoVv+gSlbcTtB1555sEWbHR0Y
        KFqituQUL121PnKuI3h2Hr/BBv2DEUrviKIv9+Z4w6573UWBZ+i3z4eeILMBiS0K
        s0kpoiMfh50=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8F83B8EBA;
        Tue, 31 Oct 2017 21:21:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C783B8EB9;
        Tue, 31 Oct 2017 21:21:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 7/7] t6120: fix typo in test name
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-8-sbeller@google.com>
Date:   Wed, 01 Nov 2017 10:21:07 +0900
In-Reply-To: <20171031003351.22341-8-sbeller@google.com> (Stefan Beller's
        message of "Mon, 30 Oct 2017 17:33:51 -0700")
Message-ID: <xmqqh8ueyet8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0CBCF42-BEA2-11E7-AAB6-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t6120-describe.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Good.  I am guessing that you are sending this as the last/optional
one because this was found _after_ you worked on other parts of the
series, but I think it is easier to reason about if this were marked
as a preliminary clean-up and moved to the front of the series.

Thanks.

>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 3be01316e8..fd329f173a 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -304,7 +304,7 @@ test_expect_success 'describe chokes on severely broken submodules' '
>  	mv .git/modules/sub1/ .git/modules/sub_moved &&
>  	test_must_fail git describe --dirty
>  '
> -test_expect_success 'describe ignoring a borken submodule' '
> +test_expect_success 'describe ignoring a broken submodule' '
>  	git describe --broken >out &&
>  	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
>  	grep broken out
