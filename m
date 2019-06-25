Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E1161F461
	for <e@80x24.org>; Tue, 25 Jun 2019 13:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfFYN5q (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:57:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:55125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbfFYN5q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561471051;
        bh=M2aw+p9RYmER9aIRq1Qt61d+qdsBFj1a3A9SaOImG1s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EsoLip2vKIZMlXp3Bv1X3MHYD5uW+oTN3VgZpBFUKLdQHnyZZlIqucGUVl8heFMak
         dcH4OSXuFF7iVW06uLCxC5u46cxC44haWVi+Hi5tF4PgieztPXlktWBZI43vYLm3h3
         4BY+jYDK6HvIA2icg+nhrx8SQR6Lkh3fhxspXLsQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mbir8-1iHr7d2jGA-00dC1g; Tue, 25
 Jun 2019 15:57:31 +0200
Date:   Tue, 25 Jun 2019 15:57:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 01/10] ls-files: add --json to dump the index
In-Reply-To: <nycvar.QRO.7.76.6.1906251328320.44@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1906251557001.44@tvgsbejvaqbjf.bet>
References: <20190624130226.17293-1-pclouds@gmail.com> <20190624130226.17293-2-pclouds@gmail.com> <nycvar.QRO.7.76.6.1906251142580.44@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1906251328320.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7cfD8+3HBUNNtiBtJEd1p8XR3hjPsVH3eiBFTNZT1rbEzLbpNUW
 FU5GOoYqOCZHh/TLsggTYf5vsQQBDXV5+RBU/xhXO95jECsmNjD//oFk7GT15jB5JbeAyZy
 PoyoTFGtDkEkWO0a51wJ7keY38aesiABPb1zRZY8toDS4C1rriE2I9AksP69VA4fa1yQDHE
 ijMtrrYI43FMZoLLCKBYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j9yKbeQHdBc=:nu3Dd01vb3z3qAR1NzzzdX
 gZGTXjBDkMuIQ5Z8scwVtcIr/x3jceUMoumrb5ST0QvXsIsYbW5gITC/iwCID95c/DOoRvVX7
 7tadcfizuXFgV4FMwux+tSvifbv3ml2Yum4R8QBnwpRDx+v9RvVRXKQOpcxIUeGE7DVOqE1OL
 GZj6OC/fGr+oum1q6/0WfsnLX/gVDDTfJFXtS0/A7/PPcp0QZ5/X8X3r2cALJAmUqcLMXLZuA
 S6+GXsn0bSxU5tC9VIpYZ/R644KGCANEkddD2jrxZUI+JSYgt2a0ZziH43+SNLqMmEoHu9g1T
 YZ/9hPy56KkVRibILpKRh0D2bhVUhSDddshrsxHJPTVJGSOmAVH58i7P5gfFQQRLVud2fyPXF
 ziDMa3uy0WKRM1INEvftIbo2gpDip0QZora/CIu9rsUjEFDAea4sF6Yizq/M1YYZlVDBamWFM
 azrBgaq5fxwGYYxeXmamu5MOOnkoocAKpZc9r6X245vSFKkF8ynkahdIhNnH/34aTgbBKMOpa
 oTVLMY9k23RcYcHBUG6TypIizy1ft8c34qZDfomVho0Kf861IoOqhQlvP98bz9KAN+4WtcYwo
 mRLv0LYpdiZlaq6ff5UxYmhZzIC+CjeGmZoBmnV2znhg0MFb4X+iPSqeJItvrwnO4PivHTzby
 UbF6gJVAktrLLk/7dzakyB0M3hjNfvyzIaTzL4nl+FN+ExlUVl3OJIjTdtfAs0FPA7SPrOKsf
 cffPFYn5It8EsG0tluSCPn0LN6sMJ/eKQzuyU2RPHh6DYPH+5LiO07cMs5NzKhTxSA65lhWHU
 64TIwEaMUPWNXHkQaeOFhNHU+NZeSIp9HOM5MKQG0C+5r9rk+4ZDa3HaNLp+CCpS4YzMBlsi3
 DcAOwu0FGpuvdBCvpWwGnEGy3H0ZQx/5kEHf208pN75yGSws07l9EvZCkQ6WJK4t2Lli37qCh
 y9TJBWcvjBmru5E5fOVE96RTxMtWmWoctDjz6L60NGmYXG1NhWr3m
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Tue, 25 Jun 2019, Johannes Schindelin wrote:

> diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
> index 9f4ad4c9cf..8b782c48e0 100755
> --- a/t/t3011-ls-files-json.sh
> +++ b/t/t3011-ls-files-json.sh
> @@ -4,18 +4,6 @@ test_description=3D'ls-files dumping json'
>
>  . ./test-lib.sh
>
> -strip_number() {
> -	for name; do
> -		echo 's/\("'$name'":\) [0-9]\+/\1 <number>/' >>filter.sed
> -	done
> -}
> -
> -strip_string() {
> -	for name; do
> -		echo 's/\("'$name'":\) ".*"/\1 <string>/' >>filter.sed
> -	done
> -}
> -
>  compare_json() {
>  	git ls-files --debug-json >json &&
>  	sed -f filter.sed json >filtered &&
> @@ -35,9 +23,21 @@ test_expect_success 'setup' '
>  	echo intent-to-add >ita &&
>  	git add -N ita &&
>
> -	strip_number ctime_sec ctime_nsec mtime_sec mtime_nsec &&
> -	strip_number device inode uid gid file_offset ext_size last_update &&
> -	strip_string oid ident
> +	cat >filter.sed <<-\EOF
> +	s/\("ctime_sec":\) [0-9]\+/\1 <number>/

And of course, \+ still isn't POSIX, so you have to write [0-9][1-9]*
instead.

Ciao,
Johannes

> +	s/\("ctime_nsec":\) [0-9]\+/\1 <number>/
> +	s/\("mtime_sec":\) [0-9]\+/\1 <number>/
> +	s/\("mtime_nsec":\) [0-9]\+/\1 <number>/
> +	s/\("device":\) [0-9]\+/\1 <number>/
> +	s/\("inode":\) [0-9]\+/\1 <number>/
> +	s/\("uid":\) [0-9]\+/\1 <number>/
> +	s/\("gid":\) [0-9]\+/\1 <number>/
> +	s/\("file_offset":\) [0-9]\+/\1 <number>/
> +	s/\("ext_size":\) [0-9]\+/\1 <number>/
> +	s/\("last_update":\) [0-9]\+/\1 <number>/
> +	s/\("oid":\) ".*"/\1 <string>/
> +	s/\("ident":\) ".*"/\1 <string>/
> +	EOF
>  '
>
>  test_expect_success 'ls-files --json, main entries, UNTR and TREE' '
> @@ -98,7 +98,9 @@ test_expect_success !SINGLE_CPU 'ls-files --json and m=
ulticore extensions' '
>  		touch one two three four &&
>  		git add . &&
>  		cp ../filter.sed . &&
> -		strip_number offset &&
> +		cat >>filter.sed <<-\EOF &&
> +		s/\("offset":\) [0-9]\+/\1 <number>/
> +		EOF
>  		compare_json eoie
>  	)
>  '
