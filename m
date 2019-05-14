Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B072F1F461
	for <e@80x24.org>; Tue, 14 May 2019 02:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfENCuY (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 22:50:24 -0400
Received: from mout.web.de ([212.227.15.3]:49031 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfENCuX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 22:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557802215;
        bh=F3+lklOIRClWX1y4yUSX6vnqntBTGgJwA/d0RahkTdY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ChTktddI0zbCZjK118Otef4lhE1Z5FiwcOK5PxhxyLLaFRnGIhWBYeIUsAWA8wdCb
         M51nggc8oc9RZxUrT3roEwyZu/kGyuZTs7AYtn7d3mwACZ1UdqL2RpkPkaMKEFoKJA
         J08Tp39X/BEi25m7mwaHXsKtoo/R+B8reuT9OadY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8zRF-1hYJ473vcj-00CPw1; Tue, 14
 May 2019 04:50:15 +0200
Date:   Tue, 14 May 2019 04:50:13 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 1/5] t9350: fix encoding test to actually test
 reencoding
Message-ID: <20190514025013.jg7zya7w5qypzxca@tb-raspi4>
References: <20190513164722.31534-1-newren@gmail.com>
 <20190513231726.16218-1-newren@gmail.com>
 <20190513231726.16218-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190513231726.16218-2-newren@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:qGsO5w8typKl8TF+tMaqIwB78AibBNIv/lUihRZIrPlo0yOh6wr
 xfV47Xur+PEYd+IlbzsD4sC8LMaYRW189vlexQrncZ4CiajDgTx0mCQGuRimnEz4CKHsjX4
 yixFhU68+P5gy4tFkNjuKwzmvMQ0V4LWUbfPSip7boIohBEj0TqIFoPxKafa569o8OWTEtd
 IRro9l01sgjvkus3UpXEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/h9gCIRp0Ho=:f+eIi6/H+f5zjH+BoSK9rz
 IKHch11Lokwy2h2UqAEOibYsyJ14+hhU8bwSYM0TBPORlJC3a/37DspBT4uJL6U2zhMIVboPZ
 HE1cA5pLNxrJnGiLOllXQcnXmcIH/bs+S3mKcI5xoyqufHMFSzewsYwvHPdI+EZjNBwyq+rGN
 HYsjLgVu3CsciiNNapmTvw4kSEdkG+pc7zsUISKhZf2l21MkrHLpZzY973+ERzzotWeibjPgk
 TTOntD/QAiiajCNaj7I21sGvJIYwHBJ5pY+JHT2NmFNwvEcJMrzI1tiTmGB8k88HJXWMBgs1u
 rQfQKdkIE9PQb3rZbrfGbIlYID5GE/3BV/EFvAnOY/VqhgnS9/dDVfMCaMt7W1hh2VWmP7RGw
 xgIGRSvf4MzI0N7qxXgf/E+tPykuK6nFJ94YiQh+C3aB/9fu2BbxC2AjWAzWWXv1G/bU8SX9O
 Dub+BvO0tl9AJnm8OznFD+HeaZkC0d7EYLihtF5OTWXwiyuIy8mAS5Bzy2BjBwVyaztophHi0
 xtueDgkGNKgjOKZUL/fltrz0iungwBPLVY5Ywz9hd4q1RqKRnn3TzuaTb9WGbJVCxhxpbiewO
 XnGg8m7aEhxWKey4kL67YXLGKsRvGuEaE+V+JLDqJDfKjJN9gEMKY7AUOzISiWWuXM6sE4U/j
 7R5BYaeh7cRJHRkz+ShWZUg+B0FIwM5HO3eKpzAEQMlNIDnmiWb4ewqKXfZk3uXEORpAy9IZg
 48sH4JWmcjB7A+/JEZHd8h7jMgepTevNQLT4GerN8Ooov2ttB+n8sfByNCqnKIyfzuBXrFaV+
 p7vpEO7MNmYb4Bx0O13/ulhKyGKcPk2hLGG1ROCIFpfPuXT9hZH1WfmiLTsjM6vko/CSaq0u/
 YgjynI/D8h/ZH/ZlpuzBHyr/lgEMNcXj1lqf6NuLUXeMzEJTWUifwPrGtLZ1R0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 04:17:22PM -0700, Elijah Newren wrote:
> This test used an author with non-ascii characters in the name, but
> no special commit message.  It then grep'ed for those non-ascii
> characters, but those are guaranteed to exist regardless of the
> reencoding process since the reencoding only affects the commit message,
> not the author or committer names.  As such, the test would work even if
> the re-encoding process simply stripped the commit message entirely.
> Modify the test to actually check that the reencoding in utf-8 worked.

(Not a native english speaker here): Should that be
"...reencoding into utf-8 worked" ?

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t9350-fast-export.sh                       | 27 ++++++++++++--------
>  t/t9350/simple-iso-8859-7-commit-message.txt |  1 +
>  2 files changed, 18 insertions(+), 10 deletions(-)
>  create mode 100644 t/t9350/simple-iso-8859-7-commit-message.txt
>
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 5690fe2810..c721026260 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -94,22 +94,30 @@ test_expect_success 'fast-export --show-original-ids=
 | git fast-import' '
>  	test $MUSS =3D $(git rev-parse --verify refs/tags/muss)
>  '
>
> -test_expect_success 'iso-8859-1' '
> +test_expect_success 'iso-8859-7' '
>
> -	git config i18n.commitencoding ISO8859-1 &&
> -	# use author and committer name in ISO-8859-1 to match it.
> -	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
> +	test_when_finished "git reset --hard HEAD~1" &&
> +	test_config i18n.commitencoding iso-8859-7 &&
>  	test_tick &&
>  	echo rosten >file &&
> -	git commit -s -m den file &&
> -	git fast-export wer^..wer >iso8859-1.fi &&
> -	sed "s/wer/i18n/" iso8859-1.fi |
> +	git commit -s -F "$TEST_DIRECTORY/t9350/simple-iso-8859-7-commit-messa=
ge.txt" file &&
> +	git fast-export wer^..wer >iso-8859-7.fi &&
> +	sed "s/wer/i18n/" iso-8859-7.fi |
>  		(cd new &&
>  		 git fast-import &&
> +		 # The commit object, if not re-encoded, would be 240 bytes.
> +		 # Removing the "encoding iso-8859-7\n" header drops 20 bytes.
> +		 # Re-encoding the Pi character from \xF0 (\360) in iso-8859-7
> +		 # to \xCF\x80 (\317\200) in utf-8 adds a byte.  Check for
> +		 # the expected size.
> +		 test 221 -eq "$(git cat-file -s i18n)" &&
> +		 # ...and for the expected translation of bytes.
>  		 git cat-file commit i18n >actual &&
> -		 grep "=C1=E9=ED =F3=FA" actual)
> -
> +		 grep $(printf "\317\200") actual &&
> +		 # Also make sure the commit does not have the "encoding" header
> +		 ! grep ^encoding actual)
>  '
> +
>  test_expect_success 'import/export-marks' '
>
>  	git checkout -b marks master &&
> @@ -224,7 +232,6 @@ GIT_COMMITTER_NAME=3D'C O Mitter'; export GIT_COMMIT=
TER_NAME
>
>  test_expect_success 'setup copies' '
>
> -	git config --unset i18n.commitencoding &&
>  	git checkout -b copy rein &&
>  	git mv file file3 &&
>  	git commit -m move1 &&
> diff --git a/t/t9350/simple-iso-8859-7-commit-message.txt b/t/t9350/simp=
le-iso-8859-7-commit-message.txt
> new file mode 100644
> index 0000000000..8b3f0c3dba
> --- /dev/null
> +++ b/t/t9350/simple-iso-8859-7-commit-message.txt
> @@ -0,0 +1 @@
> +Pi: ?
> \ No newline at end of file
> --
> 2.21.0.782.gd8be4ee826
>
