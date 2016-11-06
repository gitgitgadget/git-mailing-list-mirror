Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998382021E
	for <e@80x24.org>; Sun,  6 Nov 2016 14:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbcKFOv4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 09:51:56 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33470 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbcKFOvz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 09:51:55 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so12091302wmu.0
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 06:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+bRIiOp/nFyGCj58cCUORVhmfTCwq+oXep/BJA0E190=;
        b=RQ6/7uWrYgTD1X8ort2rBdZUfLIhMIc6Sv50rgvrnhMp2g/r0r8rHc0qWy7lhTvQ2y
         CXzd3s2H1XZOOfKUtyMEI254oA4/RTwADSP7rry8+H1TtsW0zyXHLrar2UrTqYjfVfrO
         pCsb7eQn4w1/SEfqdrkeCpk4DkffT2coHsCpQW1KFKwNLNKId9FqMRIalnZ/WhEdev++
         Rg1h0OF2oeqKZHzebPfEwbRIPIjC/5Os+43np1kEQBd7dDZURbcuq3i0hG5yTxPpmFgx
         56y+XvSaU4uXqa7roG9Djnq5MSMuLPt0ePq3uQdPmWsVnwQqL70t/kF8yP7i5BN9Cbdk
         Gjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+bRIiOp/nFyGCj58cCUORVhmfTCwq+oXep/BJA0E190=;
        b=QFlHyxmTKXO7/LWe+GM6ldO2IcBlXlI8oc+coyam2vjkxD8RfoMv/6AUlu2kQytfC/
         Ogz3YKL+9Ml1E+QiVj3q7Ha5tV3bYOlek/jeunbvsqXS/gP+YgGEP3sJXfbKFjh+yt+J
         j6F2HCv/AZYS1sZ1VavghOC/mC1Eff8BjXSqTaAwYOZ68TPJSpTI7/vpWn5hJqwpQdKk
         PHfg7igKF56OMCby9IsisWLdAUBJ95Iwxxv0tS9yIDviiNR5k7NDnvjD2Xogi7X55hoC
         fMMtKDPVEpj+ED4ZJweBZQqbbRVA2Y+WNuK0vJj8rBnB4VSwYwIpqZ2IIRbd4yy4/VWx
         6Uwg==
X-Gm-Message-State: ABUngvfYlI+0HT+LaxZ3EGyyriUiHVzKg04RQMsmFnGGBMoTwjtn6dWUQx602Iv+OjMeNQ==
X-Received: by 10.28.137.71 with SMTP id l68mr5768881wmd.76.1478443913253;
        Sun, 06 Nov 2016 06:51:53 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id 135sm8029923wmq.8.2016.11.06.06.51.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 06:51:52 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/4] t0021: use $PERL_PATH for rot13-filter.pl
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161102182022.zalzmc6rcwmvrgqq@sigill.intra.peff.net>
Date:   Sun, 6 Nov 2016 15:52:00 +0100
Cc:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E073426F-8285-4D11-91BC-E1B80F54AD32@gmail.com>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net> <20161102182022.zalzmc6rcwmvrgqq@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 02 Nov 2016, at 19:20, Jeff King <peff@peff.net> wrote:
>=20
> The rot13-filter.pl script hardcodes "#!/usr/bin/perl", and
> does not respect $PERL_PATH at all. That is a problem if the
> system does not have perl at that path, or if it has a perl
> that is too old to run a complicated script like the
> rot13-filter (but PERL_PATH points to a more modern one).
>=20
> We can fix this by using write_script() to create a new copy
> of the script with the correct #!-line. In theory we could
> move the whole script inside t0021-conversion.sh rather than
> having it as an auxiliary file, but it's long enough that
> it just makes things harder to read.
>=20
> As a bonus, we can stop using the full path to the script in
> the filter-process config we add (because the trash
> directory is in our PATH). Not only is this shorter, but it
> sidesteps any shell-quoting issues. The original was broken
> when $TEST_DIRECTORY contained a space, because it was
> interpolated in the outer script.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> t/t0021-conversion.sh   | 19 +++++++++++--------
> t/t0021/rot13-filter.pl |  1 -
> 2 files changed, 11 insertions(+), 9 deletions(-)
> mode change 100755 =3D> 100644 t/t0021/rot13-filter.pl
>=20
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index c1ad20c61..a8fa52148 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -13,6 +13,9 @@ tr \
>   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
> EOF
>=20
> +write_script rot13-filter.pl "$PERL_PATH" \
> +	<"$TEST_DIRECTORY"/t0021/rot13-filter.pl
> +
> generate_random_characters () {
> 	LEN=3D$1
> 	NAME=3D$2
> @@ -341,7 +344,7 @@ test_expect_success 'diff does not reuse worktree =
files that need cleaning' '
> '
>=20
> test_expect_success PERL 'required process filter should filter data' =
'
> -	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl =
clean smudge" &&
> 	test_config_global filter.protocol.required true &&
> 	rm -rf repo &&
> 	mkdir repo &&
> @@ -434,7 +437,7 @@ test_expect_success PERL 'required process filter =
should filter data' '
>=20
> test_expect_success PERL 'required process filter takes precedence' '
> 	test_config_global filter.protocol.clean false &&
> -	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl =
clean" &&
> 	test_config_global filter.protocol.required true &&
> 	rm -rf repo &&
> 	mkdir repo &&
> @@ -459,7 +462,7 @@ test_expect_success PERL 'required process filter =
takes precedence' '
> '
>=20
> test_expect_success PERL 'required process filter should be used only =
for "clean" operation only' '
> -	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl =
clean" &&
> 	rm -rf repo &&
> 	mkdir repo &&
> 	(
> @@ -494,7 +497,7 @@ test_expect_success PERL 'required process filter =
should be used only for "clean
> '
>=20
> test_expect_success PERL 'required process filter should process =
multiple packets' '
> -	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl =
clean smudge" &&
> 	test_config_global filter.protocol.required true &&
>=20
> 	rm -rf repo &&
> @@ -554,7 +557,7 @@ test_expect_success PERL 'required process filter =
should process multiple packet
> '
>=20
> test_expect_success PERL 'required process filter with clean error =
should fail' '
> -	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl =
clean smudge" &&
> 	test_config_global filter.protocol.required true &&
> 	rm -rf repo &&
> 	mkdir repo &&
> @@ -573,7 +576,7 @@ test_expect_success PERL 'required process filter =
with clean error should fail'
> '
>=20
> test_expect_success PERL 'process filter should restart after =
unexpected write failure' '
> -	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl =
clean smudge" &&
> 	rm -rf repo &&
> 	mkdir repo &&
> 	(
> @@ -624,7 +627,7 @@ test_expect_success PERL 'process filter should =
restart after unexpected write f
> '
>=20
> test_expect_success PERL 'process filter should not be restarted if it =
signals an error' '
> -	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl =
clean smudge" &&
> 	rm -rf repo &&
> 	mkdir repo &&
> 	(
> @@ -663,7 +666,7 @@ test_expect_success PERL 'process filter should =
not be restarted if it signals a
> '
>=20
> test_expect_success PERL 'process filter abort stops processing of all =
further files' '
> -	test_config_global filter.protocol.process =
"$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
> +	test_config_global filter.protocol.process "rot13-filter.pl =
clean smudge" &&
> 	rm -rf repo &&
> 	mkdir repo &&
> 	(
> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> old mode 100755
> new mode 100644
> index ae4c50f5c..e3ea58e1e
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl
> @@ -1,4 +1,3 @@
> -#!/usr/bin/perl
> #
> # Example implementation for the Git filter protocol version 2
> # See Documentation/gitattributes.txt, section "Filter Protocol"
> --=20
> 2.11.0.rc0.258.gf434c15

Looks good to me!=20

Minor pedantic nit:=20
Would it make sense to rename "rot13-filter.pl" to=20
"rot13-filter.pl.template" or something because of the
missing shebang?

- Lars

