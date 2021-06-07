Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C429C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5294C6108C
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFGSuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:50:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52921 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhFGSuB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 14:50:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CF97C13E532;
        Mon,  7 Jun 2021 14:48:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YkGtIfjh9rLZZnb9EWdRGGM6BttlLTEh8xKLyL
        Cxu0U=; b=Dc6BmpymxXfW+0MsTd+NoFn0gPZxpZ8dbSU6a/lAYDLWn/XZIoNv/v
        V9aCy7XZp76T/Li3dIix0405RHU70w6c1g/EPSKwMLxwGYKOxe4faYRAy7mH2TMI
        VG0AdEgaRvkvr7Cr8glUVHMS9x4soa+NWUMbvisU3XoL82TaZlqbc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8D6813E531;
        Mon,  7 Jun 2021 14:48:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1ED9813E52D;
        Mon,  7 Jun 2021 14:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: fix whitespace around &&
References: <20210607131320.982362-1-rybak.a.v@gmail.com>
Date:   Tue, 08 Jun 2021 03:48:05 +0900
In-Reply-To: <20210607131320.982362-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Mon, 7 Jun 2021 15:13:20 +0200")
Message-ID: <xmqq8s3lv7dm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E6013482-C7C0-11EB-9C7D-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Add missing spaces before '&&' and switch tabs around '&&' to spaces.
>
> These issues were found using `git grep '[^ ]&&$'` and
> `git grep -P '&&\t'`.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 2 +-
>  contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh  | 4 ++--
>  t/t1092-sparse-checkout-compatibility.sh     | 2 +-
>  t/t3920-crlf-messages.sh                     | 2 +-
>  t/t4203-mailmap.sh                           | 2 +-
>  t/t4205-log-pretty-formats.sh                | 2 +-
>  t/t7800-difftool.sh                          | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)

Looks trivially correct, all of them.  Thanks.

> diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> index 4c39bda7bf..f08890d9e7 100755
> --- a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> +++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
> @@ -86,7 +86,7 @@ test_expect_success 'Git clone works with page added' '
>  test_expect_success 'Git clone works with an edited page ' '
>  	wiki_reset &&
>  	wiki_editpage foo "this page will be edited" \
> -		false -s "first edition of page foo"&&
> +		false -s "first edition of page foo" &&
>  	wiki_editpage foo "this page has been edited and must be on the clone " true &&
>  	git clone mediawiki::'"$WIKI_URL"' mw_dir_6 &&
>  	test_path_is_file mw_dir_6/Foo.mw &&
> diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
> index 6b0dbdac4d..526d92850f 100755
> --- a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
> +++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
> @@ -287,7 +287,7 @@ test_expect_success 'git push with \' '
>  		git add \\ko\\o.mw &&
>  		git commit -m " \\ko\\o added" &&
>  		git push
> -	)&&
> +	) &&
>  	wiki_page_exist \\ko\\o &&
>  	wiki_check_content mw_dir_18/\\ko\\o.mw \\ko\\o
>  
> @@ -311,7 +311,7 @@ test_expect_success 'git push with \ in format control' '
>  		git add \\fo\\o.mw &&
>  		git commit -m " \\fo\\o added" &&
>  		git push
> -	)&&
> +	) &&
>  	wiki_page_exist \\fo\\o &&
>  	wiki_check_content mw_dir_20/\\fo\\o.mw \\fo\\o
>  
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index e9a815ca7a..d028b73eba 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -268,7 +268,7 @@ test_expect_success 'diff with renames' '
>  	for branch in rename-out-to-out rename-out-to-in rename-in-to-out
>  	do
>  		test_all_match git checkout rename-base &&
> -		test_all_match git checkout $branch -- .&&
> +		test_all_match git checkout $branch -- . &&
>  		test_all_match git diff --staged --no-renames &&
>  		test_all_match git diff --staged --find-renames || return 1
>  	done
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index 70ddce3a2e..a8ad5462d9 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -64,7 +64,7 @@ test_crlf_subject_body_and_contents() {
>  	while test -n "${atoms}"
>  	do
>  		set ${atoms} && atom=$1 && shift && atoms="$*" &&
> -		set ${files} &&	file=$1 && shift && files="$*" &&
> +		set ${files} && file=$1 && shift && files="$*" &&
>  		test_expect_success "${command}: --format='%${atom}' works with messages using CRLF" "
>  			rm -f expect &&
>  			for ref in ${LIB_CRLF_BRANCHES}
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index d8e7374234..0b2d21ec55 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -959,7 +959,7 @@ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
>  	test_when_finished "rm .mailmap" &&
>  	ln -s map .mailmap &&
>  	git log -1 --format=%aE >actual &&
> -	echo "orig@example.com" >expect&&
> +	echo "orig@example.com" >expect &&
>  	test_cmp expect actual
>  '
>  
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index 8272d94ce6..5865daa8f8 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -988,7 +988,7 @@ test_expect_success '%(describe) vs git describe' '
>  
>  test_expect_success '%(describe:match=...) vs git describe --match ...' '
>  	test_when_finished "git tag -d tag-match" &&
> -	git tag -a -m tagged tag-match&&
> +	git tag -a -m tagged tag-match &&
>  	git describe --match "*-match" >expect &&
>  	git log -1 --format="%(describe:match=*-match)" >actual &&
>  	test_cmp expect actual
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index 3e041e83ae..a173f564bc 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -770,7 +770,7 @@ test_expect_success 'difftool --rotate-to' '
>  	echo 4 >4 &&
>  	git add 1 2 4 &&
>  	git commit -a -m "124" &&
> -	git difftool --no-prompt --extcmd=cat --rotate-to="2" HEAD^ >output&&
> +	git difftool --no-prompt --extcmd=cat --rotate-to="2" HEAD^ >output &&
>  	cat >expect <<-\EOF &&
>  	2
>  	4
