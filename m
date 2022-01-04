Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A763C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 02:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiADCgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 21:36:50 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62475 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiADCgt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 21:36:49 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1A7BF3A69;
        Mon,  3 Jan 2022 21:36:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9Bm5pQ0K62v/GGQKP1/hosXJkSVHJ9n9RhotPSNquXA=; b=tUEi
        +2UW+mMZjK/97br1cwcibqYejDeFGGIIOPlbOcFaKVEQN/Ew/ZpZNkSpG6Jly9CG
        BnpeDjMFL8ngTv1IniYr3bgcpTFMVe7eFo8nr0wr1izZCZkJEGyyf1XKy6hoMROS
        oyyRyVot8Ie1euaNv3tJCuW0hKcbzruzc25tiuc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D67A3F3A68;
        Mon,  3 Jan 2022 21:36:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 42CF1F3A67;
        Mon,  3 Jan 2022 21:36:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 1/2] name-rev: deprecate --stdin in favor of
 --annotate-text
References: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
        <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
        <55ec2a5fa3e748b7e5f9ef871214563ba2b28adf.1641221261.git.gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 18:36:46 -0800
Message-ID: <xmqqa6gcfcqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29AAA70E-6D07-11EC-B619-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +--annotate-stdin::
>  	Transform stdin by substituting all the 40-character SHA-1
>  	hexes (say $hex) with "$hex ($rev_name)".  When used with
>  	--name-only, substitute with "$rev_name", omitting $hex
> -	altogether.  Intended for the scripter's use.
> +	altogether.
> +
> +	For example:
> ++

I wonder if you also need the "There is no paragraph break,
concluding the bulleted item" marker that is a sole plus sign on a
line before the "For example:" thing.

Other than that, looking good.

Thanks.
