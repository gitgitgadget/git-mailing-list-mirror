Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044FC388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 16:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C636D20663
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 16:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OaJEwmX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgJaQ4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 12:56:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59920 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgJaQ4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 12:56:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1B35911B5;
        Sat, 31 Oct 2020 12:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xu7Xog6QqrCoFBlrKobjpYihsHU=; b=OaJEwm
        X/cwuJC60fyHfXD8eVy5BW6Aav2uHhfWUYg0OoXiuCK9scCw3YD0NAqCMUNKtWY1
        83hCRjtAeDQW6Nds6LOXYWyMtLyPoVJovjAf5P7KnCopGIOacfQBJbgorLHhzwxf
        rlWoB2Mdq2+S7tWRQgBq0fSdcMcUIiq24QkoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gu8VCO8BFoV86wyCkch2qRHWqR5l2sHt
        ld9mqgzq4lz3bKKf14eJzE4Zk9f/LiCmobPgm12CwEvDVKKiLmWc/NFdAruBo3sb
        73nmBU/UX6TR/EkAcOu26Vaft1LveYUNTKoz2lpLf7G55q+svMNEovv3ZErykG/7
        RWj8+AwVmVU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9877D911B3;
        Sat, 31 Oct 2020 12:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E7EA911B2;
        Sat, 31 Oct 2020 12:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     izabela.bakollari@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9363: Cleanup old version of code
References: <20201031151434.36400-1-izabela.bakollari@gmail.com>
Date:   Sat, 31 Oct 2020 09:56:21 -0700
In-Reply-To: <20201031151434.36400-1-izabela.bakollari@gmail.com> (izabela
        bakollari's message of "Sat, 31 Oct 2020 16:14:34 +0100")
Message-ID: <xmqqr1pe49my.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 010C292C-1B9A-11EB-B5FC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

izabela.bakollari@gmail.com writes:

> From: Izabela Bakollari <izabela.bakollari@gmail.com>

> Subject: [PATCH] t9363: Cleanup old version of code

Micronit.  As you can see from "git shortlog --no-merges --since=9.weeks",
the convention here is not capitalize the word after "<area>:", i.e.

    Subject: [PATCH] t9363: clean up old version of code

> Change style for `cd` in subshell.
>
> Signed-off-by: Izabela Bakollari <izabela.bakollari@gmail.com>
> ---
>  contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
> index 6187ec67fa..f09a7ed034 100755
> --- a/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
> +++ b/contrib/mw-to-git/t/t9363-mw-to-git-export-import.sh
> @@ -53,8 +53,12 @@ test_expect_failure 'git clone works on previously created wiki with media files
>  	git clone -c remote.origin.mediaimport=true \
>  		mediawiki::'"$WIKI_URL"' mw_dir_clone &&
>  	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt &&
> -	(cd mw_dir_clone && git checkout HEAD^) &&
> -	(cd mw_dir && git checkout HEAD^) &&
> +	(
> +		cd mw_dir_clone && git checkout HEAD^
> +	) &&
> +	(
> +		cd mw_dir && git checkout HEAD^
> +	) &&

This is not wrong per-se, but I do not think it is too ambitious a
clean-up to declare

	(cd there && git any-single-git-command-with-args)

is an obsolete style and recommend it to be rewritten to

	git -C there any-single-git-command-with-args

In other words, I think

>  	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt &&
> -	(cd mw_dir_clone && git checkout HEAD^) &&
> -	(cd mw_dir && git checkout HEAD^) &&
> +	git -C mw_dir_clone checkout HEAD^ &&
> +	git -C mw_dir checkout HEAD^ &&

would be more preferrable.

>  	test_path_is_file mw_dir_clone/Foo.txt &&
>  	test_cmp mw_dir_clone/Foo.txt mw_dir/Foo.txt
>  '

Thanks.
