Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE8E2021E
	for <e@80x24.org>; Sun,  6 Nov 2016 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbcKFPpz (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 10:45:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36396 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbcKFPpz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 10:45:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id c17so12230505wmc.3
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Bl4P2HuJtcnvToijkGeMW/ZZaUTnTU3BJ2/D2vARodQ=;
        b=ycJpuR2Ul5DBexcA0BnDxUVRNaDX+gK4NQCahwXpg0+bbRzTWI+VzY+lEKGCZaE9Ve
         ldUgpVEqje9b6E9c06jFujIA+B7uZ7OS0tnYjL0l5BtQoj05sE86Ka4SGDC39dcG+/BV
         lRXzNvqI663JuM9hYO/rg6/ZP2BK54RCSjAoM0bqvagfIvK+q1z7lAB71DcKtQuZh+GN
         ESGMHDO0SjpCgM6valvM/clnIKFb38rYwbWk+7ynOXvtP0MZOTHaHE3ozZTsMj8KFSmh
         kgxgkSM7ZCXPNQr+ZWMsX0TFHRTKKX7+mVB1p7bIUzflp3n6//A0JX+LeVFeCNjMI2rZ
         8TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Bl4P2HuJtcnvToijkGeMW/ZZaUTnTU3BJ2/D2vARodQ=;
        b=l4+LDAjg9LSvV1T7U+9aR/r2G99SeikX49eCA22myjgVgxe3z/JKlJKpARJmA9/3wL
         FbOSM4gwCq2PB9GjdHZitXoOIh5Q8da7lAqn8ufzw6rPcnC0wejRTv8Wmy4/vfYCripM
         4KnAZPU0+m4sgDydUDM/WlbjWRYvpVM8dJBDCvxCe57lCHMtgh9NTkE1V4qOqU2dUR7r
         oBFP8FBbQnI78XvMsf6CBjoX8Nut+U2nfu32N00Kj8w4jhNZmdPV2676zOi8GK/nEgdF
         xGysvvVDYBYTNaJguzYqFGVI+09kQ6eC3LwKPUvFAoNsrfls6ootkduxaNuaZ6C4TP2d
         1XTQ==
X-Gm-Message-State: ABUngvdGPpgh6zEgeyAAMQiizZkQgsOy6O8+gxYNoExh0gfiWMq+71KdVlqCeBWdt8AA4g==
X-Received: by 10.28.230.72 with SMTP id d69mr1671985wmh.119.1478447153300;
        Sun, 06 Nov 2016 07:45:53 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5D74.dip0.t-ipconnect.de. [93.219.93.116])
        by smtp.gmail.com with ESMTPSA id 70sm8264747wmv.1.2016.11.06.07.45.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Nov 2016 07:45:52 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH (optional)] t0021: use arithmetic expansion to trim whitespace from wc -c output
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <3b58b90d-5435-1503-d052-413a947a5ab5@kdbg.org>
Date:   Sun, 6 Nov 2016 16:45:50 +0100
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com, tboegi@web.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <C61D1F80-7B7A-4111-9418-75D178AF4353@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com> <20161016232038.84951-14-larsxschneider@gmail.com> <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org> <3763DDDB-9D53-4877-8399-32DF1780CAB7@gmail.com> <fb4d62de-fbb5-a2b4-8eba-b135125dafa9@kdbg.org> <3b58b90d-5435-1503-d052-413a947a5ab5@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Nov 2016, at 21:22, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
> Instead of a pipeline with sed and a useless use of cat, return the
> unmodified text of wc -c from function file_size, but substitute the
> result with arithmetic expansion to get rid of the leading whitespace
> that some version of wc -c print.
>=20
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> This is a pure optimization that reduces the number of forks, which
> helps a bit on Windows.
>=20
> There would be a solution with perl that does not require trimming
> of whitespace, but perl startup times are unbearable on Windows.
> wc -c is better.
>=20
> t/t0021-conversion.sh | 50 =
+++++++++++++++++++++++++-------------------------
> 1 file changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index db71acacb3..42b529f615 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -22,7 +22,7 @@ generate_random_characters () {
> }
>=20
> file_size () {
> -	cat "$1" | wc -c | sed "s/^[ ]*//"
> +	wc -c <"$1"
> }
>=20
> filter_git () {
> @@ -369,10 +369,10 @@ test_expect_success PERL 'required process =
filter should filter data' '
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: clean test.r $S [OK] -- OUT: $S . [OK]
> -			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
> +			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]
> +			IN: clean test2.r $(($S2)) [OK] -- OUT: $(($S2)) =
. [OK]
> 			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
> -			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 =
[OK] -- OUT: $S3 . [OK]
> +			IN: clean testsubdir/test3 '\''sq'\'',\$x.r =
$(($S3)) [OK] -- OUT: $(($S3)) . [OK]
> 			STOP
> 		EOF
> 		test_cmp_count expected.log rot13-filter.log &&
> @@ -381,14 +381,14 @@ test_expect_success PERL 'required process =
filter should filter data' '
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: clean test.r $S [OK] -- OUT: $S . [OK]
> -			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
> +			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]
> +			IN: clean test2.r $(($S2)) [OK] -- OUT: $(($S2)) =
. [OK]
> 			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
> -			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 =
[OK] -- OUT: $S3 . [OK]
> -			IN: clean test.r $S [OK] -- OUT: $S . [OK]
> -			IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
> +			IN: clean testsubdir/test3 '\''sq'\'',\$x.r =
$(($S3)) [OK] -- OUT: $(($S3)) . [OK]
> +			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]
> +			IN: clean test2.r $(($S2)) [OK] -- OUT: $(($S2)) =
. [OK]
> 			IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
> -			IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 =
[OK] -- OUT: $S3 . [OK]
> +			IN: clean testsubdir/test3 '\''sq'\'',\$x.r =
$(($S3)) [OK] -- OUT: $(($S3)) . [OK]
> 			STOP
> 		EOF
> 		test_cmp_count expected.log rot13-filter.log &&
> @@ -399,8 +399,8 @@ test_expect_success PERL 'required process filter =
should filter data' '
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
> -			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 =
[OK] -- OUT: $S3 . [OK]
> +			IN: smudge test2.r $(($S2)) [OK] -- OUT: =
$(($S2)) . [OK]
> +			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r =
$(($S3)) [OK] -- OUT: $(($S3)) . [OK]
> 			STOP
> 		EOF
> 		test_cmp_exclude_clean expected.log rot13-filter.log &&
> @@ -409,7 +409,7 @@ test_expect_success PERL 'required process filter =
should filter data' '
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: clean test.r $S [OK] -- OUT: $S . [OK]
> +			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]
> 			STOP
> 		EOF
> 		test_cmp_exclude_clean expected.log rot13-filter.log &&
> @@ -418,10 +418,10 @@ test_expect_success PERL 'required process =
filter should filter data' '
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
> -			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
> +			IN: smudge test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]
> +			IN: smudge test2.r $(($S2)) [OK] -- OUT: =
$(($S2)) . [OK]
> 			IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
> -			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 =
[OK] -- OUT: $S3 . [OK]
> +			IN: smudge testsubdir/test3 '\''sq'\'',\$x.r =
$(($S3)) [OK] -- OUT: $(($S3)) . [OK]
> 			STOP
> 		EOF
> 		test_cmp_exclude_clean expected.log rot13-filter.log &&
> @@ -451,7 +451,7 @@ test_expect_success PERL 'required process filter =
takes precedence' '
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: clean test.r $S [OK] -- OUT: $S . [OK]
> +			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]
> 			STOP
> 		EOF
> 		test_cmp_count expected.log rot13-filter.log
> @@ -474,7 +474,7 @@ test_expect_success PERL 'required process filter =
should be used only for "clean
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: clean test.r $S [OK] -- OUT: $S . [OK]
> +			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]
> 			STOP
> 		EOF
> 		test_cmp_count expected.log rot13-filter.log &&
> @@ -603,11 +603,11 @@ test_expect_success PERL 'process filter should =
restart after unexpected write f
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: smudge smudge-write-fail.r $SF [OK] -- OUT: =
$SF [WRITE FAIL]
> +			IN: smudge smudge-write-fail.r $(($SF)) [OK] -- =
OUT: $(($SF)) [WRITE FAIL]
> 			START
> 			init handshake complete
> -			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
> -			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
> +			IN: smudge test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]
> +			IN: smudge test2.r $(($S2)) [OK] -- OUT: =
$(($S2)) . [OK]
> 			STOP
> 		EOF
> 		test_cmp_exclude_clean expected.log rot13-filter.log &&
> @@ -649,9 +649,9 @@ test_expect_success PERL 'process filter should =
not be restarted if it signals a
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: smudge error.r $SE [OK] -- OUT: 0 [ERROR]
> -			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
> -			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
> +			IN: smudge error.r $(($SE)) [OK] -- OUT: 0 =
[ERROR]
> +			IN: smudge test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]
> +			IN: smudge test2.r $(($S2)) [OK] -- OUT: =
$(($S2)) . [OK]
> 			STOP
> 		EOF
> 		test_cmp_exclude_clean expected.log rot13-filter.log &&
> @@ -688,7 +688,7 @@ test_expect_success PERL 'process filter abort =
stops processing of all further f
> 		cat >expected.log <<-EOF &&
> 			START
> 			init handshake complete
> -			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
> +			IN: smudge abort.r $(($SA)) [OK] -- OUT: 0 =
[ABORT]
> 			STOP
> 		EOF
> 		test_cmp_exclude_clean expected.log rot13-filter.log &&
> --=20
> 2.11.0.rc0.55.gd967357
>=20

This looks good to me! As I run the Windows tests once in a while, too,=20=

I am in full support to make them faster :-)

Since the file size function became very simple with your patch,
shouldn't we get rid of it? If you agree, then we could squash the=20
patch below into your patch.

I also would like to move the arithmetic expansion to the variable
to make the `expected.log` better readable. That means I would like
to have this:

S=3D$(($(wc -c <test.r))) &&
...
			IN: clean test.r $S [OK] -- OUT: $S . [OK]


Instead of this:

S=3D$(wc -c <test.r) &&
...
			IN: clean test.r $(($S)) [OK] -- OUT: $(($S)) . =
[OK]

Would you agree?


Thanks,
Lars



diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9968465..4454587 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -23,10 +23,6 @@ generate_random_characters () {
 		perl -pe "s/./chr((ord($&) % 26) + ord('a'))/sge" =
>"$TEST_ROOT/$NAME"
 }
=20
-file_size () {
-	wc -c <"$1"
-}
-
 filter_git () {
 	rm -f rot13-filter.log &&
 	git "$@" 2>git-stderr.log &&
@@ -363,9 +359,9 @@ test_expect_success PERL 'required process filter =
should filter data' '
 		cp "$TEST_ROOT/test3 '\''sq'\'',\$x.o" "testsubdir/test3 =
'\''sq'\'',\$x.r" &&
 		>test4-empty.r &&
=20
-		S=3D$(file_size test.r) &&
-		S2=3D$(file_size test2.r) &&
-		S3=3D$(file_size "testsubdir/test3 '\''sq'\'',\$x.r") &&
+		S=3D$(wc -c <test.r) &&
+		S2=3D$(wc -c <test2.r) &&
+		S3=3D$(wc -c <"testsubdir/test3 '\''sq'\'',\$x.r") &&
=20
 		filter_git add . &&
 		cat >expected.log <<-EOF &&
@@ -446,7 +442,7 @@ test_expect_success PERL 'required process filter =
takes precedence' '
=20
 		echo "*.r filter=3Dprotocol" >.gitattributes &&
 		cp "$TEST_ROOT/test.o" test.r &&
-		S=3D$(file_size test.r) &&
+		S=3D$(wc -c <test.r) &&
=20
 		# Check that the process filter is invoked here
 		filter_git add . &&
@@ -470,7 +466,7 @@ test_expect_success PERL 'required process filter =
should be used only for "clean
=20
 		echo "*.r filter=3Dprotocol" >.gitattributes &&
 		cp "$TEST_ROOT/test.o" test.r &&
-		S=3D$(file_size test.r) &&
+		S=3D$(wc -c <test.r) &&
=20
 		filter_git add . &&
 		cat >expected.log <<-EOF &&
@@ -589,9 +585,9 @@ test_expect_success PERL 'process filter should =
restart after unexpected write f
 		echo "this is going to fail" >smudge-write-fail.o &&
 		cp smudge-write-fail.o smudge-write-fail.r &&
=20
-		S=3D$(file_size test.r) &&
-		S2=3D$(file_size test2.r) &&
-		SF=3D$(file_size smudge-write-fail.r) &&
+		S=3D$(wc -c <test.r) &&
+		S2=3D$(wc -c <test2.r) &&
+		SF=3D$(wc -c <smudge-write-fail.r) &&
=20
 		git add . &&
 		rm -f *.r &&
@@ -640,9 +636,9 @@ test_expect_success PERL 'process filter should not =
be restarted if it signals a
 		echo "this will cause an error" >error.o &&
 		cp error.o error.r &&
=20
-		S=3D$(file_size test.r) &&
-		S2=3D$(file_size test2.r) &&
-		SE=3D$(file_size error.r) &&
+		S=3D$(wc -c <test.r) &&
+		S2=3D$(wc -c <test2.r) &&
+		SE=3D$(wc -c <error.r) &&
=20
 		git add . &&
 		rm -f *.r &&
@@ -679,7 +675,7 @@ test_expect_success PERL 'process filter abort stops =
processing of all further f
 		echo "error this blob and all future blobs" >abort.o &&
 		cp abort.o abort.r &&
=20
-		SA=3D$(file_size abort.r) &&
+		SA=3D$(wc -c <abort.r) &&
=20
 		git add . &&
 		rm -f *.r &&

