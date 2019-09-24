Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D7C1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 04:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfIXEGr (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 00:06:47 -0400
Received: from mout.web.de ([212.227.15.14]:34115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfIXEGq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 00:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569297998;
        bh=F1CEHuB2CHvWJddt8Nzrfvg3/KlTCD7862ZhZKljhwY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LzAXe2U7wLEPKzY89axM5ygWzmxFv9OdpentlAnk8WBOKBA1nAbBUhOJs4/Nk5Iu9
         LYJMwLydzor6LQeSFX06fnvSc6n1tWa7hz0QIlDLHyfL40cqTJBSM6SRgzwJQ7nzBh
         UUxInLRMmoRqGCLpQLn/fDeaPgwXxWg9e7hZi3tI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaIRi-1hlZ561UgI-00m1yE; Tue, 24
 Sep 2019 06:06:38 +0200
Date:   Tue, 24 Sep 2019 06:06:37 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH v2 2/2] t0028: add more tests
Message-ID: <20190924040637.2hybnk54ehf3uhoa@tb-raspi4>
References: <pull.347.git.gitgitgadget@gmail.com>
 <pull.347.v2.git.gitgitgadget@gmail.com>
 <40e54cf5ce74d1404187e31c94644df29134b4ff.1569233057.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <40e54cf5ce74d1404187e31c94644df29134b4ff.1569233057.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:x0D8iavgHNAkHXrdDAu18OXxdMV4dt6qhOzdNRxX7kQMo5927WK
 D3ip7wCBPD15EsDnZPQQYXFOkJPDwpFSMzDPR8JblimwFJyNU/Chx1Ba5S60IfOyUyi3ov+
 1hAvl0r8NY6CM2CU7eD+O2rTuuj8iSJmZfgnZ5BLTl9DuzMg2ksq1jHSiHF/SglxGjAX1Q+
 6KlUrcAUnP1opMw2zsOEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NSaC5X4zKsM=:vbO9K7D372tNM9G/CCjEg1
 DQv0bLYAiFccgvs7NJRxp/9j2kMlauvvsNnX4pQ37uAbE5B1Es+HoZdEIIcjYQgeFslhuqM3I
 8umfQ8g3jsWvv3KGkji0vO1TXBl1zrImjR9GqeoFCje2JS9GX9YNpelJfLhiiQj+E7J4dMTiy
 1aRSQWrDwPDHGrYgm93+TqREnfaqxClf+iDjYzribu89UtWsDvEUdyXSzJXsTHRMeLOZ0SSmL
 RvfXRJtTnqITwk6CBdBvUXYBPEElk5XO+sU29GL6xgFHv8Ij7LMN/8flOXloMv0jzEvUhgdxm
 EXPldP0PvTefZWwfMyBpfDzTbX2I7F06OztRJ4gaoF3YbOLDVOJ5D+uBPgjYZJMbPY0e4MEe3
 hWeI5h1UagADAgqg/yByIqwvIa7RYHQIuEG7CrWJw5VJcdxOGTNW9utfY6M38Ks2pzVA2oJnl
 yzHcWycQ88MCY8MW/5fOih/DZae2ohUgzYbKs/CmzDfegKjy2+NaTGEEKKOyYEy22TEPRZ2EQ
 gPtxuN51PD3SWMYdLRe1w+MSl9lQ/L6yd3HAHcyMYwQk187QhMwsqr88o6UKbuG4c7e62brZ3
 1b6r9VDuDkmGrIE9RuMddz5bSNIZUCOytTpqzRlb+1//ReT1FU+Ym52T157gU1ILFcepVOqb9
 FXg7zhF1JjrzNVupdguFrsQm9lRQ0gCIf59F7WEaw6KdtQ/ubwDFdzScmhMSKlzQdI04bbdQE
 2QWnl1te9iqOL4hg+IIYjgxxK8g4XrLKmblP9tvfx+pIWt+oF7CzZrhpqq7+BNinxwbgO4+tq
 H+Ew4/AnFlnYxVK+SmSOE2Dmt/jOQ7FNQmp7/SG6V1Sq3k6V3HWXQYcbu97pb70hNcieEOw1z
 /RtRGpWUtz3nQ8xBCxTuYAYNATt4bAmT7MfXKxDlQ5aY42/5YNxxMAwx9Ajck87lAhsqlumt3
 M5eb/h/Yiuq7hZCv5/ZNh3snxVCTVdNbOTJHVQ9FMlxw0YwNKQhdGjQ2R3TRyziWrnmdiPdqS
 8DNAKFZ6zeF6P5jW8wk0CP7u48PxPiEssBChOGeAg1YS5LtyPMAYLeXF2U12dWJz+UV5mz6px
 3Tao7+TvPDW4tKojXOKfk1SIi7SfCI9KURUo2ZWD5qhKdhUi6NW1QUVBGGybvYOdyM7CvXXQs
 A6x7x/xi6Ta9nvgHRrgi8e2OR1PuCNAhpf5YIr+NMg/KUXKRXNSVEO8lOo9WAtWT3HAoH+G+v
 lXZ0zSrz3vI4aR14aSZnEmQfY5+Nx8satju7XjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 03:04:19AM -0700, Alexandr Miloslavskiy via GitGit=
Gadget wrote:
> From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Thanks for the tests, some nit-picks inline.

>
> After I discovered that UTF-16-LE-BOM test was bugged and still
> succeeded...

My interpretation is that the \000\000 must be handled correctly
on all platforms, and that seems to be the case.

Would this make more sense:

After I discovered that UTF-16-LE-BOM test was bugged,
I decided that better tests are required

> ... I decided that better tests are required. Possibly the best
> option here is to compare git results against hardcoded ground truth.


>
> The new tests also cover more interesting chars where (ANSI !=3D UTF-8).
>
> Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
> ---
>  t/t0028-working-tree-encoding.sh | 39 ++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/t/t0028-working-tree-encoding.sh b/t/t0028-working-tree-enc=
oding.sh
> index 5493cf3ca9..d0dd5dd0ea 100755
> --- a/t/t0028-working-tree-encoding.sh
> +++ b/t/t0028-working-tree-encoding.sh
> @@ -280,4 +280,43 @@ test_expect_success ICONV_SHIFT_JIS 'check roundtri=
p encoding' '
>  	git reset
>  '
>
> +# $1: checkout encoding
> +# $2: test string
> +# $3: binary test string in checkout encoding
> +test_commit_utf8_checkout_other () {
> +	encoding=3D"$1"
> +	orig_string=3D"$2"
> +	expect_bytes=3D"$3"
> +
> +	test_expect_success "Commit utf-8, checkout ${encoding}" '

General remark:
Do we need the {} here?
${encoding} could be simpler written as $encoding

> +		test_when_finished "git checkout HEAD -- .gitattributes" &&
> +
> +		test_ext=3D"commit_utf8_checkout_${encoding}" &&
> +		test_file=3D"test.${test_ext}" &&
> +
> +		# Commit as utf-8

Another nit-pick:
Looking at the other test cases, should utf-8 be written as UTF-8
for consistency ?

> +		echo "*.${test_ext} text working-tree-encoding=3Dutf-8" >.gitattribut=
es &&
> +		printf "${orig_string}" >"${test_file}" &&
> +		git add "${test_file}" &&
> +		git commit -m "Test data" &&
> +
> +		# Checkout in tested encoding
> +		rm "${test_file}" &&
> +		echo "*.${test_ext} text working-tree-encoding=3D${encoding}" >.gitat=
tributes &&
> +		git checkout HEAD -- "${test_file}" &&
> +
> +		# Test
> +		printf "${expect_bytes}" > "${test_file}.raw" &&
> +		test_cmp_bin "${test_file}.raw" "${test_file}"

More a style-nit: could we simply write like this:
 		printf $expect_bytes > $test_file.raw &&
		test_cmp_bin $test_file.raw $test_file

(Even on other places)

> +	'
> +}
> +
> +test_commit_utf8_checkout_other "UTF-8"        "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\124\145\163\164\040\320\242\320\265\321\201\321\202"
> +test_commit_utf8_checkout_other "UTF-16LE"     "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\124\000\145\000\163\000\164\000\040\000\042\004\065\004\101\004\=
102\004"
> +test_commit_utf8_checkout_other "UTF-16BE"     "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\000\124\000\145\000\163\000\164\000\040\004\042\004\065\004\101\=
004\102"
> +test_commit_utf8_checkout_other "UTF-16LE-BOM" "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\377\376\124\000\145\000\163\000\164\000\040\000\042\004\065\004\=
101\004\102\004"
> +test_commit_utf8_checkout_other "UTF-16BE-BOM" "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\376\377\000\124\000\145\000\163\000\164\000\040\004\042\004\065\=
004\101\004\102"
> +test_commit_utf8_checkout_other "UTF-32LE"     "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\124\000\000\000\145\000\000\000\163\000\000\000\164\000\000\000\=
040\000\000\000\042\004\000\000\065\004\000\000\101\004\000\000\102\004\00=
0\000"
> +test_commit_utf8_checkout_other "UTF-32BE"     "Test =D0=A2=D0=B5=D1=81=
=D1=82" "\000\000\000\124\000\000\000\145\000\000\000\163\000\000\000\164\=
000\000\000\040\000\000\004\042\000\000\004\065\000\000\004\101\000\000\00=
4\102"
> +
>  test_done
> --
> gitgitgadget
>
