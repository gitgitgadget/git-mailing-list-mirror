Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7653C43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 18:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiGNSst (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGNSs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 14:48:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822FE6B766
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:48:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17DA5195DF7;
        Thu, 14 Jul 2022 14:48:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mOGWmWp50toyMy4CG4QKkQV+kQRW+1PmC62ixH
        YjSm4=; b=fsLX9QU8XpRR6JJde/8qty3DOrqPguQ/B9tjYC4TS9008d9ampIHHd
        5n/SoAngLvad/QVZELCM5SJ8WBUzITmBoY/0NZZ1hu7AfNpKvH92ZZZ7WkJupx1a
        LAcWs0hMNPfU7pgxDmjMECLALbKbHHIQlGWNOowUWXKCbd6tkIlz4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1047C195DF6;
        Thu, 14 Jul 2022 14:48:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B7406195DF4;
        Thu, 14 Jul 2022 14:48:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] doc: apply: unify configuration variables definitions
References: <cover.1657819649.git.matheus.bernardino@usp.br>
        <a25a6d89647638ffd682fb24ef0b5b6c9bed0941.1657819649.git.matheus.bernardino@usp.br>
Date:   Thu, 14 Jul 2022 11:48:21 -0700
In-Reply-To: <a25a6d89647638ffd682fb24ef0b5b6c9bed0941.1657819649.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Thu, 14 Jul 2022 14:44:03 -0300")
Message-ID: <xmqqbktr5y4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8960548E-03A5-11ED-AE4B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> +ifndef::git-apply[]
>  	See linkgit:git-apply[1].
> +endif::git-apply[]
>  
>  apply.whitespace::
>  	Tells 'git apply' how to handle whitespaces, in the same way
> -	as the `--whitespace` option. See linkgit:git-apply[1].
> +	as the `--whitespace` option.
> +ifndef::git-apply[]
> +	See linkgit:git-apply[1].
> +endif::git-apply[]

Makes sense.
