Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="GWJT6cBl"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119D095
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 09:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702400696; x=1703005496; i=l.s.r@web.de;
	bh=URbXSDoB6HydDHTHEbtm5z9uGkP9fu/GVXHAY50RpTs=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:
	 In-Reply-To;
	b=GWJT6cBl2jX90QZA4zKgPlwypjT/cmKJPK/hL0gLEosY9zxQAkAuM0TBYW7ZJeTW
	 LcCQaae8T343BozQ6YWgZb51dRRXVvSdPq9kZD9Up77EcMPLjOwpjSQGyiPy+r/ZC
	 k6ZsZdcJJV2k6Q+MB9XpsL61qATy9VzPgnZmI9rdaNk28pc0sTwfrBkK9Sk1Adwc9
	 TMTvziqcjVW6c/Czv3CBaQ3cel8TPEv7KVPgqh5lPi/8onZlgtBR/SSE0FjwYLpKJ
	 XJsTHEtENsFVLmRagTC9rDF+FUNIH3Kwxu7wUkq7K8d6aXRIMO6I/SGnzmzGycXh4
	 4e82rRf6HmO2GsRBLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoeYH-1rX3qr0aPR-00odEz; Tue, 12
 Dec 2023 18:04:56 +0100
Message-ID: <9feeb6cf-aabf-4002-917f-3f6c27547bc8@web.de>
Date: Tue, 12 Dec 2023 18:04:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Test breakage with zlib-ng
To: Ondrej Pohorelsky <opohorel@redhat.com>, git@vger.kernel.org
References: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: "brian m . carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <CA+B51BEpSh1wT627Efpysw3evVocpiDCoQ3Xaza6jKE3B62yig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PamiLm7519arX1AHujvWQwskYzEzwP681X23VBDCJVBnUyplZJV
 y7njH5Wv2SMTz6J6W6fmvuZB4ppjkyDXO75VMeyYi7qzwZkRUpBLOdatHhKdr7us+lR9XxF
 rE121FisQm8UCwKakMCkew78YkY2MwaeTTC3IkEEWF2GfyD450j4a/Ilgkb3Jk7fdojuFAp
 tlSjeKM7mMQt/gGnldiLw==
UI-OutboundReport: notjunk:1;M01:P0:sUQCqH7A3aw=;GvsEG32GdQ59xiY/2/RuMg/88jn
 e6WPiJU21YumV5zq0mxAGFbs42P51IJR+gzZduRRFNLTS0NeB3bAkjhLSQi9T/ZpHT2+URGfB
 SOQdzWrYgrhwVIMTlhlomRQLc0DtceWpciH5dHnBV+0IomxywfvHQrbuMt9n4FYX5hoHKLlVN
 xBYcYGNeXX6jjFIz4raYSkejcviy9Sxljv0w2Ci0X/nL3vvWhaR/PRROyDtR6dap2cfh9Ox2C
 39dT42lZlCjeH/q1mDhYFS7hstEg/NLXBCd4DxXkWhlpMPrhb49mA0BGReNesO5mFM1/OBOAP
 V360BH/ZyAQiAopOwSUljmk+7+9h99hCUyp36NdzbhL0qLtBU/GsV1Ngri+ucUApy9hDCwBIv
 OOSn9nccQ3ppYaejsW3LsJEFVZPCvfbwgS+77TXrkFbyEmy1vYpn5PcGA4PQTakwQqeIPbumB
 +uXAV6zArVSU2YZNfTYOsdo4+bmHkh/lFTz+bybxqdyp54l6BfrriBuF9VD8Le0fRAsqvRTET
 7d+jLd2TiWENpG9jxdpk1VBZb/cFB0/P5erQ5/bsT9+z/Sslw3vDQ4spG+rowoiiJ+1YwIxDE
 L/u5/n8j3BzUK7fF4GESc7PuUeQ16PJ1GUPKZoo1odqO5sQ40vzrMjw1HlbnWZ1gWbzV53Lrt
 Vf913lSn4+6aOOy96RTkzMnMkaEUAY4pAYEKKVQOUU/tVkkfr5Mcnrzre8UR8xdEByys2nY01
 1njxoJ0+/aZgxiKUa4H0eOismZXUirlAmVfbXq4JOnM/u6Lb905UUlh2o4YMyqx4bsTgS0Adj
 Wn44rkx1y31p/kny1RYoQhbNxuHmTPDL/lxBgakj3tHk0duDEP9ZdcPDejT286FBBTG6r0qTu
 j9rkgLj5XPVpfQf9zX+n/95DoMwgkD10GifLeqqzlF0XUIsnz//BdkBVNLkRjJ051gU16AFFn
 ahSHdw==

Am 12.12.23 um 15:16 schrieb Ondrej Pohorelsky:
> Hi everyone,
>
> As some might have heard, there is a proposal for Fedora 40 to
> transition from zlib to zlib-ng[0]. Because of this, there has been a
> rebuild of all packages to ensure every package works under zlib-ng.
>
> Git test suit has three breakages in t6300-for-each-ref.sh.
> To be precise, it is:
>
> not ok 35 - basic atom: refs/heads/main objectsize:disk
> not ok 107 - basic atom: refs/tags/testtag objectsize:disk
> not ok 108 - basic atom: refs/tags/testtag *objectsize:disk
>
>
> All of these tests are atomic, and they compare the result against
> $disklen.

Why do these three objects (HEAD commit of main, testtag and testtag
target) have the same size?  Half of the answer is that testtag points
to the HEAD of main.  But the other half is pure coincidence as far as I
can see.

> I can easily patch these tests in Fedora to be compatible with zlib-ng
> only by not comparing to $disklen, but a concrete value, however I
> would like to have a universal solution that works with both zlib and
> zlib-ng. So if anyone has an idea on how to do it, please let me know.

The test stores the expected values at the top, in the following lines,
for the two possible repository formats:

	test_expect_success setup '
		test_oid_cache <<-EOF &&
		disklen sha1:138
		disklen sha256:154
		EOF

So it's using hard-coded values already, which breaks when the
compression rate changes.

We could set core.compression to 0 to take compression out of the
picture.

Or we could get the sizes of the objects by checking their files,
which would not require  hard-coding anymore.  Patch below.

=2D-- >8 ---
Subject: [PATCH] t6300: avoid hard-coding object sizes

f4ee22b526 (ref-filter: add tests for objectsize:disk, 2018-12-24)
hard-coded the expected object sizes.  Coincidentally the size of commit
and tag is the same with zlib at the default compression level.

1f5f8f3e85 (t6300: abstract away SHA-1-specific constants, 2020-02-22)
encoded the sizes as a single value, which coincidentally also works
with sha256.

Different compression libraries like zlib-ng may arrive at different
values.  Get them from the file system instead of hard-coding them to
make switching the compression library (or changing the compression
level) easier.

Reported-by: Ondrej Pohorelsky <opohorel@redhat.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t6300-for-each-ref.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 54e2281259..843a7fe143 100755
=2D-- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -20,12 +20,13 @@ setdate_and_increment () {
     export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }

-test_expect_success setup '
-	test_oid_cache <<-EOF &&
-	disklen sha1:138
-	disklen sha256:154
-	EOF
+test_object_file_size () {
+	oid=3D$(git rev-parse "$1")
+	path=3D".git/objects/$(test_oid_to_path $oid)"
+	test_file_size "$path"
+}

+test_expect_success setup '
 	# setup .mailmap
 	cat >.mailmap <<-EOF &&
 	A Thor <athor@example.com> A U Thor <author@example.com>
@@ -94,7 +95,6 @@ test_atom () {
 }

 hexlen=3D$(test_oid hexsz)
-disklen=3D$(test_oid disklen)

 test_atom head refname refs/heads/main
 test_atom head refname: refs/heads/main
@@ -129,7 +129,7 @@ test_atom head push:strip=3D1 remotes/myfork/main
 test_atom head push:strip=3D-1 main
 test_atom head objecttype commit
 test_atom head objectsize $((131 + hexlen))
-test_atom head objectsize:disk $disklen
+test_atom head objectsize:disk $(test_object_file_size refs/heads/main)
 test_atom head deltabase $ZERO_OID
 test_atom head objectname $(git rev-parse refs/heads/main)
 test_atom head objectname:short $(git rev-parse --short refs/heads/main)
@@ -203,8 +203,8 @@ test_atom tag upstream ''
 test_atom tag push ''
 test_atom tag objecttype tag
 test_atom tag objectsize $((114 + hexlen))
-test_atom tag objectsize:disk $disklen
-test_atom tag '*objectsize:disk' $disklen
+test_atom tag objectsize:disk $(test_object_file_size refs/tags/testtag)
+test_atom tag '*objectsize:disk' $(test_object_file_size refs/heads/main)
 test_atom tag deltabase $ZERO_OID
 test_atom tag '*deltabase' $ZERO_OID
 test_atom tag objectname $(git rev-parse refs/tags/testtag)
=2D-
2.43.0

