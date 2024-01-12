Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2775657877
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fJu0as02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705054103; x=1705658903; i=johannes.schindelin@gmx.de;
	bh=bTXL8dB2YhXVoCn3lE66w3pfbSsDwXWfg5wniCaTCdw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=fJu0as02RnzqBzEwpwCh8v+Jw9b86Bfzfw2F2GdNhzZc7YMQt7RmYrFxjFzoaW/a
	 Mh8hsZcIw0KV1LsTGLUxmFCHQZbydjwewa/3+R8Kg4soz7cnO2quUdKnpeotZBwNh
	 nPgprvK3hQLjgHE8S5wYn9F9sm12b+xMhKsHbqSithJ0oUhtNYSpBTmB9R+Urvt/Z
	 tPlpdEvhbeyGnkzIt3NaqD4UE2qymIG6yvSDuPBYPQYOd+1lqySNGNQzD/TuL/906
	 UJBjNjMweiOqAZccbeMZHBE/JSCxILg9fJroFGGqRpXAyiPBN+GDiYMVgjuOU55za
	 GvQ9H44xR8i973TqNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.101]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqaxO-1qkp6t06Iy-00mbz4; Fri, 12
 Jan 2024 11:08:23 +0100
Date: Fri, 12 Jan 2024 11:08:21 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, Stan Hu <stanhu@gmail.com>
Subject: Re: [PATCH 1/2] t9902: verify that completion does not print
 anything
In-Reply-To: <73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im>
Message-ID: <d978494d-6c48-5923-4745-c42a39e1187a@gmx.de>
References: <cover.1704969119.git.ps@pks.im> <73406ca9c8f38ac2ad8f0e32d6d81f1566a6b4d1.1704969119.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wQYCSoEkMDghtQj9CfrRR97snFhl5soLaWK+a4ulCI+g09CTG9+
 NOjjktNFr/fDNKUM8OAwyjfGrvHILyDxa3S4nsRDTApXPoIAotFHDizFql0sInVxC+qaOd+
 tIc7WmeA0pnEq2dj5mv6/sJTSPH4AzvmwQnS01O6Y2NgOtbzDR3UERwmaQ91DMwjUs+QhoD
 05kO7/qvf+0fMXJHbKRgA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tQpD//+Lbyw=;OE4psU2QrcGlLpDaEZabSEa0Uj1
 nh+hAT0kZiG8kmjLs6bICo9sIAM7+wMTXuhq6UTaKCxlXBmrmAXtOK4xamdRHlc8rWt6iHE56
 6CuHiORWzdz+jg4lVX2TSR0C5/ih3bYH1biN9GzreHsmY0aKX/j2QTj4l10EEySlHyvh25ewZ
 fBVBRv3q3rnfMv+Lyuo9NXhtxOIZFBLZtli6/tjczeef//95p0lh/TxZdNoUw39P46KeVdHni
 K6u7ax38OtPqP69ZsgnORG5zyI5+x4E32Digbg2lOnluv2eJNSwOvghEFMwASkvrwJMhEoKfK
 lI4XDWzGMtWbe3UZQfxZ4MkDvbvUe+nQc6y8MQfuqGrHperzmOlbrchyT+PG6ZEKjwYl2sD2e
 Rrxij5XE2u9juXDbDzRxOjQQWbEmUiGZq+rzXAHZHGXX/h5u2ZLWBHTZoDSW6QAElHV3DTtoR
 6MbTO2owlN4ygHz5HCiY84pehCndxr2Ok3uyLsgtlvJAvSGv1S5MohDorrj0xSFUV59wBYTdl
 FiQ3PLcvswGMHDXPE58s+ZdR78adEfipTATZEdRYOjIhOS/x2gjm3wYuhbXTWfD6jKsZmzpIw
 XKdbbwSnyw9qz7iXHTClDhHa312JmhJGsDp8r9TzThPBx+5Q+zoB8yVb/Ee7pWLT+YD2v1qdB
 Mx4AZAf7WJfNCLvFDMld6/MR54dg/hsIuxsa1tGIlCcCFGqh6xoG7WSCR0VzkU0SugHV42GvM
 pHE9x8ebAt1c4MWs1npb57g367NaOumme9WoKXae4JWkGilAZcgq3VGsU7UfxHkICf+scTwDE
 G9gFQecn+xYL9wodxFrkFck6TF6IFd/gj9QR1K3Za3xNX2zRQ6erE35/OSq5CzpHyrvrQ365m
 3Zt+AmUpo3d/oKcg5/yjDAvFSEgYlEn0LXzEXuwgfTvBialiM12Dc2xErkSoO4izHAk9zkTmA
 OK/NQw==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 11 Jan 2024, Patrick Steinhardt wrote:

> The Bash completion script must not print anything to either stdout or
> stderr. Instead, it is only expected to populate certain variables.
> Tighten our `test_completion ()` test helper to verify this requirement.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t9902-completion.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index aa9a614de3..78cb93bea7 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -87,9 +87,11 @@ test_completion ()
>  	else
>  		sed -e 's/Z$//' |sort >expected
>  	fi &&
> -	run_completion "$1" &&
> +	run_completion "$1" >"$TRASH_DIRECTORY"/output 2>&1 &&
>  	sort out >out_sorted &&
> -	test_cmp expected out_sorted
> +	test_cmp expected out_sorted &&
> +	test_must_be_empty "$TRASH_DIRECTORY"/output &&

It seems that this fails CI on macOS, most likely because we're running
with `set -x` and that output somehow ends up in `output`, see e.g. here:
https://github.com/git/git/actions/runs/7496790359/job/20409405194#step:4:=
1880

  [...]
  ++ test_completion 'git switch '
  ++ test 1 -gt 1
  ++ sed -e 's/Z$//'
  ++ sort
  ++ run_completion 'git switch '
  ++ sort out
  ++ test_cmp expected out_sorted
  ++ test 2 -ne 2
  ++ eval 'diff -u' '"$@"'
  +++ diff -u expected out_sorted
  ++ test_must_be_empty '/Users/runner/work/git/git/t/trash directory.t990=
2-completion/output'
  ++ test 1 -ne 1
  ++ test_path_is_file '/Users/runner/work/git/git/t/trash directory.t9902=
-completion/output'
  ++ test 1 -ne 1
  ++ test -f '/Users/runner/work/git/git/t/trash directory.t9902-completio=
n/output'
  ++ test -s '/Users/runner/work/git/git/t/trash directory.t9902-completio=
n/output'
  ++ echo ''\''/Users/runner/work/git/git/t/trash directory.t9902-completi=
on/output'\'' is not empty, it contains:'
  '/Users/runner/work/git/git/t/trash directory.t9902-completion/output' i=
s not empty, it contains:
  ++ cat '/Users/runner/work/git/git/t/trash directory.t9902-completion/ou=
tput'
  ++ local -a COMPREPLY _words
  ++ local _cword
  [...]

Maybe this is running in Dash and therefore `BASH_XTRACEFD=3D4` in
`test-lib.sh` has not the intended effect?

Ciao,
Johannes
