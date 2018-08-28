Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE0D91F404
	for <e@80x24.org>; Tue, 28 Aug 2018 15:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeH1S46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 14:56:58 -0400
Received: from mout.web.de ([217.72.192.78]:49337 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726807AbeH1S46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 14:56:58 -0400
Received: from [192.168.178.36] ([91.20.48.192]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8o6-1gKPnI0UvW-00S6Sg; Tue, 28
 Aug 2018 16:59:30 +0200
Subject: Re: [PATCH v4 8/8] fsck: support comments & empty lines in skipList
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <87lg8refcr.fsf@evledraar.gmail.com>
 <20180828095219.23296-9-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2b31e12e-20e9-3d08-58bd-977f8b83e0a7@web.de>
Date:   Tue, 28 Aug 2018 16:59:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180828095219.23296-9-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6ujZt0nqpS2jH/BhiVUqVQfaGVflPHUkU0eFgEV4NTesEUpPp4o
 Q5E0pu/0oj6b41zk4EfZOAA7tlQxMxSpQtT75gQr+6xFDRIlyGd9STd68lOCgOyv0h5MoE1
 FzdGNhJmRdA1CMthJ12yUaTM2x+6Jtqi55RF7o2S8xKmavdXrU6/p5aWMd+T0jhylIL65Sb
 sXnV4xjQTxswBt29SFc4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IqaUzc8QJPc=:s83jvCwqRjn2e8gzyasbmu
 4oVvCvS7ulP8dYZwTSchHeaJtOjmfWlrciw3qrWXvfYBraE7vAVsvolgLIkRA4RXNpvcRft3J
 HdBA+OUBt5AuP4KxZ19RqtmIaDNoBB5jfvNFc9q0/jfkeRlWaQBvB2szHaaJn9TtKnErxy1yF
 RBIXTH/K35n1q+wFutg2Hq+AAiURs6GS/QlEUY3JSb4z2YlKKo1ZkSEjefhVeA7oX2//RbnsR
 Xen3gr+B+q7riTHi5O0Jjn/gVzayD43sN6bf5j5/atwy9pDncQXa03a/YLcNzMOMqTlgpxo2T
 eyRSgV4qhU/xW7i6oxV5aSBz6PFyOmoSC1WCIoWa7wbATsGM5rf5/TlK5x7vXFlU5S2d4/i3p
 0EeogxZpkvDYpiYOM4ro12N+jddnTt5gjkU2RR5CIvXa8iwUWQhNgbm3vxgMtLJDnQjSxVJ8s
 DljZXFTumLvj4JZjaayK4TsuWFMAzD7GqRrQuarfFwXyP1fXOePIcNH9QwamywwSPJnx0KOnA
 7vZ90dIep2923S1PGgP+iRxGYm/2gl9bTi5DBa+hQUPQrBCWknCb8R18P9R+vP3ZoIWhqsi1C
 LUnMFLRDF+Jm37YnS24FBpk1SxpdJaUVGEQ96AkW3XpEynFqDc5efZRG11/2joFg4EQwyoB8p
 vwDKYtpm+byEFRUfUluD7PEpreu6gtWxPK7AlOyWIbVqUqvf3jfRRfHvcnFBd9/4glC6rxOLk
 5C8z0TumiWQnAha4Ihh+XghdiaaiT1OS68fYBFyhewixzearkp9jpwUKDOMZuaMN6LE37ejx0
 MkKoFED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.08.2018 um 11:52 schrieb Ævar Arnfjörð Bjarmason:
> It's annoying not to be able to put comments and empty lines in the
> skipList, when e.g. keeping a big central list of commits to skip in
> /etc/gitconfig, which was my motivation for 1362df0d41 ("fetch:
> implement fetch.fsck.*", 2018-07-27).
> 
> Implement that, and document what version of Git this was changed in,
> since this on-disk format can be expected to be used by multiple
> versions of git.
> 
> There is no notable performance impact from this change, using the
> test setup described a couple of commist back:
> 
>     Test                                             HEAD~             HEAD
>     ----------------------------------------------------------------------------------------
>     1450.3: fsck with 0 skipped bad commits          7.81(7.42+0.39)   7.72(7.34+0.38) -1.2%
>     1450.5: fsck with 1 skipped bad commits          7.75(7.36+0.38)   7.66(7.26+0.39) -1.2%
>     1450.7: fsck with 10 skipped bad commits         7.81(7.43+0.38)   7.70(7.30+0.39) -1.4%
>     1450.9: fsck with 100 skipped bad commits        7.85(7.42+0.42)   7.73(7.31+0.41) -1.5%
>     1450.11: fsck with 1000 skipped bad commits      7.81(7.43+0.38)   7.84(7.46+0.38) +0.4%
>     1450.13: fsck with 10000 skipped bad commits     7.87(7.47+0.40)   7.86(7.46+0.40) -0.1%
>     1450.15: fsck with 100000 skipped bad commits    7.77(7.39+0.38)   7.83(7.48+0.34) +0.8%
>     1450.17: fsck with 1000000 skipped bad commits   7.17(6.92+0.24)   7.11(6.85+0.26) -0.8%
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config.txt        | 4 ++--
>  fsck.c                          | 2 ++
>  t/t5504-fetch-receive-strict.sh | 6 +++---
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ebaa044689..824634c412 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1712,8 +1712,8 @@ will only cause git to warn.
>  fsck.skipList::
>  	The path to a list of object names (i.e. one SHA-1 per
>  	line) that are known to be broken in a non-fatal way and should
> -	be ignored. Comments ('#') and empty lines are not supported, and
> -	will error out.
> +	be ignored. On versions of Git 2.20 and later comments ('#') and empty
> +	lines are ignored, but will error out on older versions.
>  +
>  This feature is useful when an established project should be accepted
>  despite early commits containing errors that can be safely ignored
> diff --git a/fsck.c b/fsck.c
> index 4c643f1d40..589548308a 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -190,6 +190,8 @@ static void init_skiplist(struct fsck_options *options, const char *path)
>  		die("Could not open skip list: %s", path);
>  	while (!strbuf_getline(&sb, fp)) {
>  		const char *p;
> +		if (!strcmp(sb.buf, "") || starts_with(sb.buf, "#"))
> +			continue;

Checking sb.len == 0 is simpler and might be slightly quicker.

But what is an empty line?  Shouldn't whitespace-only lines qualify?
And why not allow trailing comments, while we're at it?  I.e. what
about something like this instead?

		const char *hash = strchr(sb.buf, '#);
		if (hash)
			strbuf_setlen(&sb, hash - sb.buf);
		strbuf_rtrim(&sb);
		if (!sb.len)
			continue;

Too much?

>  		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
>  			die("Invalid SHA-1: %s", sb.buf);
>  		oidset_insert(&options->skiplist, &oid);
> diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
> index c7224db3bb..a1bac164d1 100755
> --- a/t/t5504-fetch-receive-strict.sh
> +++ b/t/t5504-fetch-receive-strict.sh
> @@ -169,20 +169,20 @@ test_expect_success 'fsck with invalid or bogus skipList input' '
>  	test_i18ngrep "Invalid SHA-1: \[core\]" err
>  '
>  
> -test_expect_success 'fsck with invalid or bogus skipList input (comments & empty lines)' '
> +test_expect_success 'fsck with other accepted skipList input (comments & empty lines)' '
>  	cat >SKIP.with-comment <<-EOF &&
>  	# Some bad commit
>  	0000000000000000000000000000000000000001
>  	EOF
>  	test_must_fail git -c fsck.skipList=SKIP.with-comment fsck 2>err-with-comment &&
> -	test_i18ngrep "^fatal: Invalid SHA-1: # Some bad commit$" err-with-comment &&
> +	test_i18ngrep "missingEmail" err-with-comment &&
>  	cat >SKIP.with-empty-line <<-EOF &&
>  	0000000000000000000000000000000000000001
>  
>  	0000000000000000000000000000000000000002
>  	EOF
>  	test_must_fail git -c fsck.skipList=SKIP.with-empty-line fsck 2>err-with-empty-line &&
> -	test_i18ngrep "^fatal: Invalid SHA-1: " err-with-empty-line
> +	test_i18ngrep "missingEmail" err-with-empty-line
>  '
>  
>  test_expect_success 'fsck no garbage output from comments & empty lines errors' '
> 
