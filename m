Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="EG07uDHm"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A161ADE
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 09:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1701106783; x=1701711583; i=l.s.r@web.de;
	bh=KJU/roOw6mmvPdbELYdbNX7mBd5Z+SvDBXuuZTJXPc8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=EG07uDHmy1Bfx/VKk54S+4jGM6/OSQwU1aD5rYK46zVOrU3YRCopa9Fnann7j9S0
	 uTc2f9t42BlGuMwtT2QlnwIIT1P8zHRyzZhE8gQtXeLnRsCrz8u+gAitJ3AswP53N
	 hV+DVDsL2R0AKx5voBR3ux4wNfWG46ZAyuhYkJvXP2YEOCWE9sN37Gcn3ZQI053od
	 +3RyEDlFYvOCDlMAjzvQ7EcxIDBR0yyhEuzR3i/kLDmMzaolPdAvRRHRDfcBpjMZQ
	 UToIRTREvexDa6zQbju6t4JZowd91kqoLq3ycDadrldWvIzPMxhnokKEpnfGP38pb
	 MmaSdJFaQEbUv/n1EA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.29.38]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7Nmq-1rD9ko3z5A-007kxS; Mon, 27
 Nov 2023 18:39:42 +0100
Message-ID: <d1f28272-635d-4638-b0f4-76d64013b0d5@web.de>
Date: Mon, 27 Nov 2023 18:39:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i18n: factorize even more 'incompatible options' messages
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>
References: <e6eb12e4-bb63-473c-9c2f-965a4d5981ad@web.de>
 <CAPig+cR5PKkyC24LkOU4+yzng1xeBOBbADTBHXH61xkAR7kymw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPig+cR5PKkyC24LkOU4+yzng1xeBOBbADTBHXH61xkAR7kymw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3RduOod57voFGC3S9chdK2TWxdYyDN0iXOtX8llwAkbTR6YgDTY
 lL+McsnQDecHb+6Ijb+YUp5EFrXyj3r/J/kexg7uP9MPEJqqG9wFWbzVZlVafuanPr8LDjS
 7tSwJTAzCyaCcXOKmdszM0azQbNch4C2sg4/+D61IKPa/6t/SBteLQ3oi/1NuLKx7a4JZtv
 G48zxL7q5FwSEJgzL4CAw==
UI-OutboundReport: notjunk:1;M01:P0:vEIfHTrkjyU=;hyCKG/r0Nom1EOPDTDyWjCg3vKb
 omCkjnhTeW+TJVnVSwcDqppYhhKPRakxFDG8XO+OW8PcAfC1v+kUuSotAIexpevFWKJMjEgnW
 yaGTZS7ZLFXjdr+NFLe1NzmXR6jO55WHnR22nO2uFU2ziqV/XGvMjrtBhEaq/lXSl8EUGIT49
 CE+wzN8CDnMhtLpNHEMlKxdIko6xF80ZxbBKzvMwbm3VF2mpYXhU6valulqgmgi5JcywQpYRg
 8geTAPJOsdkWWg+Cpk2UmFQZmI0/q7l1AoALrK74nLO8NClTi4Ob6nQWZTyBXh7NnH2ABiH+q
 I7A6qFywKXBMxGloXbW84aRjZkkV8pzQY/1HUh+XzJ7DJWJ/ZRj/WztbbML63lu5VObftPRgD
 LVQi9alMR15DFPlpWwnijlSlryvwu3nfH/2HNbNfDSFAZTI14GdKbfy3lsArQ7THYTmBD7tVR
 s2ZYiK8lORZtD3zUidKu5cFHbo3KzxZB2TlCy49TAsMdAVlwl7OLGc5+jrsgWXxdtpFP7PiNH
 MHIeOaoW7yKvjWs5htoXKaz/dyqOnEA0fJihxadGnnJlftrH4lp3iBZvdCp4hUtsdUP1/Xt88
 1+jPwkXedb4r3ISX17HaYOyJDaFPgJWl/n9dODa3Tn0x8Fty5hvgzYuekOcex/MiyYIsb8oMO
 fd8TI3nVg8l82h58Lv0lcc8TDgtp/5hNtgpI7NlquoT05LOWs0rhtutuSwt81TfWmtaDvFIAI
 YUwHyn0iC5lz6WyK+LKG/KaQdqWaNj9hiMu6EEFCojSElM3TKKoqbnpoSta4zCzcNUD9aHfQn
 nF/lObffOAy4S9c+Vdh99pFATwAZhoAnInxhFzHVM5v12BNatV8sIrL3RqZA2eADNbT0etVBg
 CqXQSF4R7Pod/MJUHOe6epm++9rnz/DZK22BXxY6yjsol3/NdAj+DykFzUtaij4S8mJ/tiaso
 sHk9rQ==

Am 26.11.23 um 18:49 schrieb Eric Sunshine:
> On Sun, Nov 26, 2023 at 6:57=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>> Continue the work of 12909b6b8a (i18n: turn "options are incompatible"
>> into "cannot be used together", 2022-01-05) and a699367bb8 (i18n:
>> factorize more 'incompatible options' messages, 2022-01-31) to use the
>> same parameterized error message for reporting incompatible command lin=
e
>> options.  This reduces the number of strings to translate and makes the
>> UI slightly more consistent.
>
> Thanks for tackling this.
>
> A couple additional instances recently slipped into `show-ref.c` which
> were caught during review[1,2] but nevertheless made it to
> "master"[3,4]. This patch, of course, doesn't need to address those,
> but if rerolling for some other reason, perhaps they can be included,
> as well(?).
>
> [1]: https://lore.kernel.org/git/CAPig+cSrp7vZuy7D_ENHKZKZzF4OSmCtfYNHPG=
MtS1Hj6gArDw@mail.gmail.com/
> [2]: https://lore.kernel.org/git/CAPig+cRTOMie0rUf=3DMhbo9e2EXf-_2kQyMeq=
pB9OCRB1MZZ1rw@mail.gmail.com/
> [3]: 199970e72f (builtin/show-ref: ensure mutual exclusiveness of
> subcommands, 2023-10-31)
> [4]: 9080a7f178 (builtin/show-ref: add new mode to check for reference
> existence, 2023-10-31)

[4] changes the message added by [3], so that's one instance, right?

=2D-- >8 ---
Subject: [PATCH] show-ref: use die_for_incompatible_opt3()

Use the standard message for reporting the use of multiple mutually
exclusive options by calling die_for_incompatible_opt3() instead of
rolling our own.  This has the benefits of showing only the actually
given options, reducing the number of strings to translate and making
the UI slightly more consistent.

Adjust the test to no longer insist on a specific order of the
reported options, as this implementation detail does not affect the
usefulness of the error message.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/show-ref.c  |  6 +++---
 t/t1403-show-ref.sh | 16 +++++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 7aac525a87..59d2291cbf 100644
=2D-- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -315,9 +315,9 @@ int cmd_show_ref(int argc, const char **argv, const ch=
ar *prefix)
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);

-	if ((!!exclude_existing_opts.enabled + !!verify + !!exists) > 1)
-		die(_("only one of '%s', '%s' or '%s' can be given"),
-		    "--exclude-existing", "--verify", "--exists");
+	die_for_incompatible_opt3(exclude_existing_opts.enabled, "--exclude-exis=
ting",
+				  verify, "--verify",
+				  exists, "--exists");

 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index b50ae6fcf1..d477689e33 100755
=2D-- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -197,18 +197,20 @@ test_expect_success 'show-ref --verify with dangling=
 ref' '
 '

 test_expect_success 'show-ref sub-modes are mutually exclusive' '
-	cat >expect <<-EOF &&
-	fatal: only one of ${SQ}--exclude-existing${SQ}, ${SQ}--verify${SQ} or $=
{SQ}--exists${SQ} can be given
-	EOF
-
 	test_must_fail git show-ref --verify --exclude-existing 2>err &&
-	test_cmp expect err &&
+	grep "verify" err &&
+	grep "exclude-existing" err &&
+	grep "cannot be used together" err &&

 	test_must_fail git show-ref --verify --exists 2>err &&
-	test_cmp expect err &&
+	grep "verify" err &&
+	grep "exists" err &&
+	grep "cannot be used together" err &&

 	test_must_fail git show-ref --exclude-existing --exists 2>err &&
-	test_cmp expect err
+	grep "exclude-existing" err &&
+	grep "exists" err &&
+	grep "cannot be used together" err
 '

 test_expect_success '--exists with existing reference' '
=2D-
2.43.0
