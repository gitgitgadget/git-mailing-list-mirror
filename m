Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ABC51F403
	for <e@80x24.org>; Wed,  6 Jun 2018 06:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeFFGTz (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 02:19:55 -0400
Received: from mout.web.de ([212.227.15.4]:45089 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751330AbeFFGTy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 02:19:54 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MevzF-1ffTfV1wAD-00OUET; Wed, 06
 Jun 2018 08:19:28 +0200
Date:   Wed, 6 Jun 2018 08:19:27 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 01/10] t: add tool to translate hash-related values
Message-ID: <20180606061927.GA7098@tor.lan>
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604235229.279814-2-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:MGTB+BAXs5w+R0EDQZ0LuFPmLXF1o4z+mZLhmEDz3Dv5hRnzuJD
 QEL1d95T2h9zqp75Fef7DYbu6Fk0yU2/lcp5R8fo+yujjFR9Dyyjk62d1/DH/bHOxSbp4to
 JNjdtIphjNOAsjfXM/TwgJ62Prb70y1aARfvLC5q70cvK2gV8zKsU4kTG6SPvqO9+zph28l
 HDa17iINEnsYNuwNlMLtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E3QPosJiD1g=:IkzcAhhaQ5RPDPPJn7bhV4
 N1g1f61DV6JWSW6xBACAQdm07NTiUluu3bW0zXOTlBNtdg3kX/FddJhIZ+HNCnbNW58+e1EGn
 lTEcpSEFui1Qxg6l664G1hGIRxt3Z4EcAlRHA9JvO5veofB5K0BezCwMoYg5Vy3QlKEp4YmnC
 4W9+/cGyeX7S8dnUl3tDde3//OV7MbcvITbVjM9RtZP2uyPrAF5XpQI5bhYoJYxzDsWC6OOeK
 0kvLBzhkNbf1IvT2yeWL01HR5AwA02pfraLLDn4VSnm05bkZG5fxpmLCKriTGXTbaumzC5YpA
 pUnTYRH6GdOyOdMepsOVkoi/c+eoU85qi5B8jDDYDuV41M1kMfA164oZoOJ2iM3iomCWGkhGd
 ckhpiN82Rcfcs3R/UY5LcpIfSkPU9xLuVQPXOdp/ikqlIzLA8Uwe03DqPsKe2Bl2cNyFKRUjT
 6xInyGnleBf67bzuLBh6RhpABhahecJuiLOZ+9npUOG8MUYKD5yUr7nq+SSobpmVIkGtSwPI6
 OHOpiZUsfvuDDHGknXupX9MVrzn4Oe34u7LrPJRuAsEL3N02dTfCEcJqVhBT4ZWpfMn3eCtMT
 qYn0xQUck2wlmmcpbmOX0riKTeamTcaF+UNj+56mG4KNMbk3/6+SPm3IGWETgDzQgv94n9amh
 WIkZ7FkvIyeEpiorqI7QNRmjznr89NJCRJwhyXxOUsOcdXdWyHUO5cwbmZ5NpZ9oDSSNBa1kP
 SA8XhIl+iFkxGwKrqGsH1p5jOz7SHttV4ipGbKUSN2KsrjPXzCukEE2oloM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some style nite inline

On Mon, Jun 04, 2018 at 11:52:20PM +0000, brian m. carlson wrote:
> Add a test function helper, test_translate, that will produce its first
> argument if the hash in use is SHA-1 and the second if its argument is
> NewHash.  Implement a mode that can read entries from a file as well for
> reusability across tests.
> 
> For the moment, use the length of the empty blob to determine the hash
> in use.  In the future, we can change this code so that it can use the
> configuration and learn about the difference in input, output, and
> on-disk formats.
> 
> Implement two basic lookup charts, one for common invalid or synthesized
> object IDs, and one for various facts about the hash function in use.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/test-lib-functions.sh | 40 ++++++++++++++++++++++++++++++++++++++++
>  t/translate/hash-info   |  9 +++++++++
>  t/translate/oid         | 15 +++++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 t/translate/hash-info
>  create mode 100644 t/translate/oid
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 2b2181dca0..0e7067460b 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1147,3 +1147,43 @@ depacketize () {
>  		}
>  	'
>  }
> +
> +test_translate_f_ () {
> +	local file="$TEST_DIRECTORY/translate/$2" &&

Unless I'm wrong, we don't use the "local" keyword ?

> +	perl -e '

The bare "perl" is better spelled as "$PERL_PATH"


> +		$delim = "\t";
> +		($hoidlen, $file, $arg) = @ARGV;
> +		open($fh, "<", $file) or die "open: $!";
> +		while (<$fh>) {
> +			# Allow specifying other delimiters.
> +			$delim = $1 if /^#!\sdelimiter\s(.)/;
> +			next if /^#/;
> +			@fields = split /$delim/, $_, 3;
> +			if ($fields[0] eq $arg) {
> +				print($hoidlen == 40 ? $fields[1] : $fields[2]);
> +				last;
> +			}
> +		}
> +	' "$1" "$file" "$3"
> +}
> +
> +# Without -f, print the first argument if we are using SHA-1 and the second if
> +# we're using NewHash.
> +# With -f FILE ARG, read the (by default) tab-delimited file from
> +# t/translate/FILE, finding the first field matching ARG and printing either the
> +# second or third field depending on the hash in use.
> +test_translate () {
> +	local hoidlen=$(printf "%s" "$EMPTY_BLOB" | wc -c) &&
> +	if [ "$1" = "-f" ]

Style nit, please avoid [] and use test:
	if test "$1" = "-f"

And more [] below

> +	then
> +		shift &&
> +		test_translate_f_ "$hoidlen" "$@"
> +	else
> +		if [ "$hoidlen" -eq 40 ]
> +		then
> +			printf "%s" "$1"
> +		else
> +			printf "%s" "$2"
> +		fi
> +	fi
> +}
> diff --git a/t/translate/hash-info b/t/translate/hash-info
> new file mode 100644
> index 0000000000..36cbd9a8eb
> --- /dev/null
> +++ b/t/translate/hash-info
> @@ -0,0 +1,9 @@
> +# Various facts about the hash algorithm in use for easy access in tests.
> +#
> +# Several aliases are provided for easy recall.
> +rawsz	20	32
> +oidlen	20	32
> +hexsz	40	64
> +hexoidlen	40	64
> +zero	0000000000000000000000000000000000000000	0000000000000000000000000000000000000000000000000000000000000000
> +zero-oid	0000000000000000000000000000000000000000	0000000000000000000000000000000000000000000000000000000000000000
> diff --git a/t/translate/oid b/t/translate/oid
> new file mode 100644
> index 0000000000..8de0fd64af
> --- /dev/null
> +++ b/t/translate/oid
> @@ -0,0 +1,15 @@
> +# These are some common invalid and partial object IDs used in tests.
> +001	0000000000000000000000000000000000000001	0000000000000000000000000000000000000000000000000000000000000001
> +002	0000000000000000000000000000000000000002	0000000000000000000000000000000000000000000000000000000000000002
> +003	0000000000000000000000000000000000000003	0000000000000000000000000000000000000000000000000000000000000003
> +004	0000000000000000000000000000000000000004	0000000000000000000000000000000000000000000000000000000000000004
> +005	0000000000000000000000000000000000000005	0000000000000000000000000000000000000000000000000000000000000005
> +006	0000000000000000000000000000000000000006	0000000000000000000000000000000000000000000000000000000000000006
> +007	0000000000000000000000000000000000000007	0000000000000000000000000000000000000000000000000000000000000007
> +# All zeros or Fs missing one or two hex segments.
> +zero-1	000000000000000000000000000000000000000	000000000000000000000000000000000000000000000000000000000000000
> +zero-2	00000000000000000000000000000000000000	00000000000000000000000000000000000000000000000000000000000000
> +ff-1	fffffffffffffffffffffffffffffffffffffff	fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +ff-2	ffffffffffffffffffffffffffffffffffffff	ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> +numeric	0123456789012345678901234567890123456789	0123456789012345678901234567890123456789012345678901234567890123
> +deadbeef	deadbeefdeadbeefdeadbeefdeadbeefdeadbeef	deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
