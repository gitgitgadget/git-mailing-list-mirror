Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1140203EA
	for <e@80x24.org>; Wed, 27 Jul 2016 02:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbcG0Cgh (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 22:36:37 -0400
Received: from mout.web.de ([212.227.15.3]:63206 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161164AbcG0Cgf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 22:36:35 -0400
Received: from [172.20.0.236] ([207.179.142.2]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LnjNH-1aoTEU2DMd-00huAK; Wed, 27 Jul 2016 04:36:10
 +0200
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 4/5] convert: generate large test files only once
To:	larsxschneider@gmail.com, git@vger.kernel.org
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-5-larsxschneider@gmail.com>
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com, peff@peff.net
Message-ID: <c3d7466b-cd3f-9f62-bc82-9f77b4f3d1a4@web.de>
Date:	Wed, 27 Jul 2016 04:35:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160727000605.49982-5-larsxschneider@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:YywsdcO/zN837TutnRCN34vZpAq0sOirxUdp5NARcJQ8ESv85LW
 rd7gRBqfmLyUMY56A+Zo532UmMQdbM6qvok7Cknk7YkeRDp4d1sujFfYAhR/ptIZJbs/++g
 5D3boRiF2K/caPACP/jayRfG9vsc1jq4OC0SbbdYXW4PhghOde7bkHzNiUIbbJ2muGclMg8
 W0RUTHej/x+7MwfaK8Lkw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:sMdNO/aL1FE=:eHJypR8r5gT9abqm9x2+v7
 J/K4ZAf1rSj/U/2tCja2BQ9yg3D7usI+KNMRjNyoy2pvQZ+v6HXmHEOFLQG1E/R6wtgDoW7RH
 JL8pbvcCxzO2cL5vnJYkRXQa2p+r3gIW03Q55BOETsAbbAojotuvKFTLRmZV9O/5LLcY7WeRk
 fEDPTo88BjVWnCFndeT7DZ+ZKfFP4i3Rh1oWw2gex6dKO95oTvfqcrR2ocnQxZpy5wLEEjp9k
 8WxJKHQg+rNV62zKrKKWbOPnLsyB1ZB3W7sNKhjifO/vkzCUEhs3vFGobW8EhI5JldlLAJUY8
 WffTN+8XeoQsFiHS3rby6jg0zxBffGQ2/aG31mEMR6srgG0yW8Sre76oyyH25phjb5kPWF05k
 0HWA9ErciA3v5yJQCekt1/JZM1GDTvUnbOVx8K9ykHUVc/vjp422gjDkigzcg7VIB4H8BXpSy
 oWe/mqBGUwBO82azxwkivaXdT57lnNnh1z/XNzO+j2l9rKyYvJ/Otnj7mNDjRhDN/ukpspT0T
 9k7Oy+rgTnLnkbCJ8gAMSot2bL8l52Ql2OL7274M1MWvu8tBmS9gYwEBgs0gVTNihhkGbsEEI
 hiysjnPUJIoovI56wN+eempS9xBfmZ3g48jxD+dFUEO40TbU5YR7MUJ7MOhgt6K43vVyZiQbz
 xHRnwzggqpSn2PwcvIKwvPbQ5XzmdUBvc6BsjCkzyNTkuHLa8XXAP0NHTQjnYzSfquKc6lJ6+
 PgaTdM4+m5Zu7JEkETwRMHKm23xFTY20IS7ng+m2hFZGMI+tCE5dNg3vPnUcwq49Bp1o3xVvW
 pRgd0mf
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/27/2016 02:06 AM, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Generate a more interesting large test file with random characters in
> between and reuse this test file in multiple tests. Run tests formerly
> marked as EXPENSIVE every time but with a smaller test file.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/t0021-conversion.sh | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 7b45136..b9911a4 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -4,6 +4,13 @@ test_description='blob conversion via gitattributes'
>
>  . ./test-lib.sh
>
> +if test_have_prereq EXPENSIVE
> +then
> +	T0021_LARGE_FILE_SIZE=2048
> +else
> +	T0021_LARGE_FILE_SIZE=30
> +fi
> +
>  cat <<EOF >rot13.sh
>  #!$SHELL_PATH
>  tr \
> @@ -31,7 +38,15 @@ test_expect_success setup '
>  	cat test >test.i &&
>  	git add test test.t test.i &&
>  	rm -f test test.t test.i &&
> -	git checkout -- test test.t test.i
> +	git checkout -- test test.t test.i &&
> +
> +	mkdir -p generated-test-data &&
> +	for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
> +	do
> +		# Generate 1MB of empty data and 100 bytes of random characters
> +		printf "%1048576d" 1
> +		printf "$(LC_ALL=C tr -dc "A-Za-z0-9" </dev/urandom | dd bs=$((RANDOM>>8)) count=1 2>/dev/null)"
I'm not sure how portable /dev/urandom is.
The other thing, that "really random" numbers are an overkill, and
it may be easier to use pre-defined numbers,

The rest of 1..4 looks good, I will look at 5/5 later.

> +	done >generated-test-data/large.file
>  '
>
>  script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
> @@ -199,9 +214,9 @@ test_expect_success 'required filter clean failure' '
>  test_expect_success 'filtering large input to small output should use little memory' '
>  	test_config filter.devnull.clean "cat >/dev/null" &&
>  	test_config filter.devnull.required true &&
> -	for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
> -	echo "30MB filter=devnull" >.gitattributes &&
> -	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
> +	cp generated-test-data/large.file large.file &&
> +	echo "large.file filter=devnull" >.gitattributes &&
> +	GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add large.file
>  '
>
>  test_expect_success 'filter that does not read is fine' '
> @@ -214,15 +229,15 @@ test_expect_success 'filter that does not read is fine' '
>  	test_cmp expect actual
>  '
>
> -test_expect_success EXPENSIVE 'filter large file' '
> +test_expect_success 'filter large file' '
>  	test_config filter.largefile.smudge cat &&
>  	test_config filter.largefile.clean cat &&
> -	for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
> -	echo "2GB filter=largefile" >.gitattributes &&
> -	git add 2GB 2>err &&
> +	echo "large.file filter=largefile" >.gitattributes &&
> +	cp generated-test-data/large.file large.file &&
> +	git add large.file 2>err &&
>  	test_must_be_empty err &&
> -	rm -f 2GB &&
> -	git checkout -- 2GB 2>err &&
> +	rm -f large.file &&
> +	git checkout -- large.file 2>err &&
>  	test_must_be_empty err
>  '
>
>
