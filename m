Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D815B561
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576647; cv=none; b=MY93WXyJCwsNgmn7hBZvr2lui2EtXBqPGN34oQyYeM14F+4ahUCY6E55DTHAY8RylETKmJd7UT/eonn5MjiCkPUZP+R/hFhFEskHXIPfgTkvAnvdKIr6A1b5IWznwHSQvuuHyOtiq5yk6XLzsjsnHBvQdc8a3QrQiRYHxMrhwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576647; c=relaxed/simple;
	bh=qvpS75Cja2O3TnNib6IoRvIY+6Br4y9ZeNv9KVnkZiU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m6/8q+yP+cEKbklMLT/aEVqZ/gw8Q0rgQrdbgq9ncIejdugbpYU3ecEw5delvgfZaYn4mVKPHjHmpc/QMXEDSgDcEiITkPhnOw+F71yNhm8f1lEruprcGqvQICVyA4ZEjPWPhAkGd/9o1iWNfva77eEgVtOokQ7J5q6jqXm4VuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=V3D90hk1; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="V3D90hk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726576639; x=1727181439;
	i=johannes.schindelin@gmx.de;
	bh=InKdSN/lp9650M50sWm0+kyniLrc5+/FpV2qkkorCvA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V3D90hk1LgzHDQ2o5tjo6QD8mTDt2NvoTvrU5NU/lmJmwDtGRx4emB93WaVImURd
	 rkCF026dO9tKcqmJNQOxnHOWtRBfsi/1lvBNJTohwy3n8olkIW9PqNaZW/PNmsKHF
	 9yLKWtH1buxvm4cgf1RiPNCoLg/0awDLvOL0uIQlyEk+xar54zGxrPp2IjlK/PXgj
	 ugpjHEG8bmG5U7JToMrFNizIvu+U9uOkHuRVUfK1oC0pfes3spL4sH/BMChjVeX0z
	 2ID8Gmfyb8TuTL7yB/MFPRBsc9hnlrIs4pRQjuJezovKF7B8mnsRmBW3Qv4YzP28S
	 kIgJC8AM+XQeOAZMFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.87]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1smdQb31DW-007YLz; Tue, 17
 Sep 2024 14:37:19 +0200
Date: Tue, 17 Sep 2024 14:37:17 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Beat Bolli <dev+git@drbeat.li>
cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] unicode: update the width tables to Unicode 16
In-Reply-To: <20240912204047.1020213-1-dev+git@drbeat.li>
Message-ID: <7449ce5b-5308-ce6e-394d-43dec511ef16@gmx.de>
References: <20240912204047.1020213-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zd6ugafeSTCrTb+r7uKRs6VYjToSJ+Y6svC0DsXgVClObDsRxnW
 8vg2wjDOuPV2DANBoOZMmgZHCFlFZLac/PsTsJZ/sUK719ure17iYAXNuSR72qLL59P4n1k
 SWBZ6Hb0ZA/5ICvFD0wt7ilmgwgQMHU8XKumQP8elLbuO0Mu3CBYH1Jvf192Mb5sZbpYQbV
 ZlQY2lVbiTfPGD923NKLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8lTshA3lDNI=;IuzYZ4aeIBZjlCDDvNRKNZiXcD2
 aTW7bVcglIloEbvNQxH97nHLen9Z3cfi3ke2TrFwmbDn7dLuwXKiAp8SSjUYVCoiwlKx6fYT6
 u4XrxRHS8/afTfUCdZXKkZL+pH6TSD91jpIL+7xHa9loDwDkIPlkaGeU0dNoUq23Bo5lWQ5bm
 u8VZK1EJcvqtB3s2REYNE7W8gPCBgXQGmeqBEcd0Q5eKVc0Cx3MH64doCuV3b5MXpjzXQ7+hr
 JijfKAVPjmgiHZ7bCJSIZCGOaa2aQ/PJZMS2+e5NA1rN/FX5po9Bc7eBglTvHDQ69osF8HEoP
 vxgcMbuF7A5QSo5oZCbcX44GoN+aMV61RZJ7wIUNV3iosQvdfsHZn15GtSz46/h0N6tU9hEZl
 cYKN9fyUZ5hDaoeG/EysZVMpJfv+cf8MsXT92edVOrHcNJvGfZs5OsZA5Ga3yL/0a73Br/Ghc
 ATc7tY71Usm04nq2UoPcQThNs5yK4Bj6IGqL7v01o4T97KESdY5F0QOU5h+uH4EoKcByT1QBY
 JZGXFTo0StnvX2JYToh0BDXYS72bxIQDpNurg3/493rVxcf1djMQJl59ILCFdzurHZcmMCOvo
 MNZFOQxiP504QuiMDnc2ZaHjDcvfy0PTFo6J5zjwRxGaVC+DfJk7ZB3OWmBEBLpR22QZCZTHT
 944gjNWyedyTSbVCKqdXmYJ+SlrJ8cr81vRRqYLFGzkBNcQWObOYUxvrHmuXzl2rqLYUAu/Ny
 SfQMkrrAwTjfiHet+fFqeV29r1PvjCB9gD8M5QGCt6n1D1Pwt4P82PhZehdMb3Xh+ThlpEJBn
 Qb7M5A9qWE7dpFpVjXHwvx8Q==
Content-Transfer-Encoding: quoted-printable

Hi Beat,

On Thu, 12 Sep 2024, Beat Bolli wrote:

> Unicode 16 has been announced on 2024-09-10 [0], so update the character
> width tables to the new version.
>
> [0] https://blog.unicode.org/2024/09/announcing-unicode-standard-version=
-160.html

I can confirm that the output is identical to the result of running
./contrib/update-unicode/update_unicode.sh.

Maybe we should add an automated, scheduled workflow for these updates?

Ciao,
Johannes

>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  unicode-width.h | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/unicode-width.h b/unicode-width.h
> index be5bf8c4f2..3ffee123a0 100644
> --- a/unicode-width.h
> +++ b/unicode-width.h
> @@ -27,7 +27,7 @@ static const struct interval zero_width[] =3D {
>  { 0x0829, 0x082D },
>  { 0x0859, 0x085B },
>  { 0x0890, 0x0891 },
> -{ 0x0898, 0x089F },
> +{ 0x0897, 0x089F },
>  { 0x08CA, 0x0902 },
>  { 0x093A, 0x093A },
>  { 0x093C, 0x093C },
> @@ -227,8 +227,9 @@ static const struct interval zero_width[] =3D {
>  { 0x10A3F, 0x10A3F },
>  { 0x10AE5, 0x10AE6 },
>  { 0x10D24, 0x10D27 },
> +{ 0x10D69, 0x10D6D },
>  { 0x10EAB, 0x10EAC },
> -{ 0x10EFD, 0x10EFF },
> +{ 0x10EFC, 0x10EFF },
>  { 0x10F46, 0x10F50 },
>  { 0x10F82, 0x10F85 },
>  { 0x11001, 0x11001 },
> @@ -261,6 +262,11 @@ static const struct interval zero_width[] =3D {
>  { 0x11340, 0x11340 },
>  { 0x11366, 0x1136C },
>  { 0x11370, 0x11374 },
> +{ 0x113BB, 0x113C0 },
> +{ 0x113CE, 0x113CE },
> +{ 0x113D0, 0x113D0 },
> +{ 0x113D2, 0x113D2 },
> +{ 0x113E1, 0x113E2 },
>  { 0x11438, 0x1143F },
>  { 0x11442, 0x11444 },
>  { 0x11446, 0x11446 },
> @@ -280,7 +286,8 @@ static const struct interval zero_width[] =3D {
>  { 0x116AD, 0x116AD },
>  { 0x116B0, 0x116B5 },
>  { 0x116B7, 0x116B7 },
> -{ 0x1171D, 0x1171F },
> +{ 0x1171D, 0x1171D },
> +{ 0x1171F, 0x1171F },
>  { 0x11722, 0x11725 },
>  { 0x11727, 0x1172B },
>  { 0x1182F, 0x11837 },
> @@ -319,8 +326,11 @@ static const struct interval zero_width[] =3D {
>  { 0x11F36, 0x11F3A },
>  { 0x11F40, 0x11F40 },
>  { 0x11F42, 0x11F42 },
> +{ 0x11F5A, 0x11F5A },
>  { 0x13430, 0x13440 },
>  { 0x13447, 0x13455 },
> +{ 0x1611E, 0x16129 },
> +{ 0x1612D, 0x1612F },
>  { 0x16AF0, 0x16AF4 },
>  { 0x16B30, 0x16B36 },
>  { 0x16F4F, 0x16F4F },
> @@ -351,6 +361,7 @@ static const struct interval zero_width[] =3D {
>  { 0x1E2AE, 0x1E2AE },
>  { 0x1E2EC, 0x1E2EF },
>  { 0x1E4EC, 0x1E4EF },
> +{ 0x1E5EE, 0x1E5EF },
>  { 0x1E8D0, 0x1E8D6 },
>  { 0x1E944, 0x1E94A },
>  { 0xE0001, 0xE0001 },
> @@ -366,8 +377,10 @@ static const struct interval double_width[] =3D {
>  { 0x23F3, 0x23F3 },
>  { 0x25FD, 0x25FE },
>  { 0x2614, 0x2615 },
> +{ 0x2630, 0x2637 },
>  { 0x2648, 0x2653 },
>  { 0x267F, 0x267F },
> +{ 0x268A, 0x268F },
>  { 0x2693, 0x2693 },
>  { 0x26A1, 0x26A1 },
>  { 0x26AA, 0x26AB },
> @@ -401,11 +414,10 @@ static const struct interval double_width[] =3D {
>  { 0x3099, 0x30FF },
>  { 0x3105, 0x312F },
>  { 0x3131, 0x318E },
> -{ 0x3190, 0x31E3 },
> +{ 0x3190, 0x31E5 },
>  { 0x31EF, 0x321E },
>  { 0x3220, 0x3247 },
> -{ 0x3250, 0x4DBF },
> -{ 0x4E00, 0xA48C },
> +{ 0x3250, 0xA48C },
>  { 0xA490, 0xA4C6 },
>  { 0xA960, 0xA97C },
>  { 0xAC00, 0xD7A3 },
> @@ -420,7 +432,7 @@ static const struct interval double_width[] =3D {
>  { 0x16FF0, 0x16FF1 },
>  { 0x17000, 0x187F7 },
>  { 0x18800, 0x18CD5 },
> -{ 0x18D00, 0x18D08 },
> +{ 0x18CFF, 0x18D08 },
>  { 0x1AFF0, 0x1AFF3 },
>  { 0x1AFF5, 0x1AFFB },
>  { 0x1AFFD, 0x1AFFE },
> @@ -430,6 +442,8 @@ static const struct interval double_width[] =3D {
>  { 0x1B155, 0x1B155 },
>  { 0x1B164, 0x1B167 },
>  { 0x1B170, 0x1B2FB },
> +{ 0x1D300, 0x1D356 },
> +{ 0x1D360, 0x1D376 },
>  { 0x1F004, 0x1F004 },
>  { 0x1F0CF, 0x1F0CF },
>  { 0x1F18E, 0x1F18E },
> @@ -470,11 +484,10 @@ static const struct interval double_width[] =3D {
>  { 0x1F93C, 0x1F945 },
>  { 0x1F947, 0x1F9FF },
>  { 0x1FA70, 0x1FA7C },
> -{ 0x1FA80, 0x1FA88 },
> -{ 0x1FA90, 0x1FABD },
> -{ 0x1FABF, 0x1FAC5 },
> -{ 0x1FACE, 0x1FADB },
> -{ 0x1FAE0, 0x1FAE8 },
> +{ 0x1FA80, 0x1FA89 },
> +{ 0x1FA8F, 0x1FAC6 },
> +{ 0x1FACE, 0x1FADC },
> +{ 0x1FADF, 0x1FAE9 },
>  { 0x1FAF0, 0x1FAF8 },
>  { 0x20000, 0x2FFFD },
>  { 0x30000, 0x3FFFD }
> --
> 2.45.2
>
>
>
