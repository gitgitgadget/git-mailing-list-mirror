Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0271F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfIERoe (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:44:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58748 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729101AbfIERod (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:44:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D47288415F;
        Thu,  5 Sep 2019 13:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tKMjo8g8odMJoCORN6OwEvavbr4=; b=FeOaoO
        /n9KIhLOOyusHFHz2BiJBFY87kAE8r3vKiXH3k2uDx/15uNLJcEg8IuBrx7sUiC4
        /XniNBjua3wQ1m7vX40nAhMBnX54CumYEm/NJ5B0XOFEPlfVBufhwyB98oCHiDmk
        tszJdBxH3pIeW4dX5otSKg0G5MdBOTbtRacQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x2UGkT1vyEaaJTHUabEtR0teftZNFtcZ
        GUg4NNzBB7GfCbYzIdpISftnKSycZFgc7vLYpGlEKo7nRYa1MAvxPZO/l+MHRCX7
        2bEroO+L+YhkcWL8xBVEsywDo9kDHXzjcJTyOy5T9C3otVDk9r64UOW+kPe+OYK8
        rJgfpuPP7K8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC7D18415E;
        Thu,  5 Sep 2019 13:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 03A418415D;
        Thu,  5 Sep 2019 13:44:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] .gitignore: stop ignoring `.manifest` files
References: <pull.332.git.gitgitgadget@gmail.com>
        <05b341661b7e14868af0eaa9179816b28c40b8bf.1567682191.git.gitgitgadget@gmail.com>
Date:   Thu, 05 Sep 2019 10:44:26 -0700
In-Reply-To: <05b341661b7e14868af0eaa9179816b28c40b8bf.1567682191.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 05 Sep 2019
        04:16:33 -0700 (PDT)")
Message-ID: <xmqqh85qr62t.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF726D86-D004-11E9-8BB5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> ...
> Further reading on auto-generated `.manifest` files:
> https://docs.microsoft.com/en-us/cpp/build/manifest-generation-in-visual-studio
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .gitignore | 1 -
>  1 file changed, 1 deletion(-)

Thanks.

> diff --git a/.gitignore b/.gitignore
> index 521d8f4fb4..fc445edea9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -231,7 +231,6 @@
>  *.ipdb
>  *.dll
>  .vs/
> -*.manifest
>  Debug/
>  Release/
>  /UpgradeLog*.htm
