Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14E23CF
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="rIC3Dm1g"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F0E5
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 05:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698494528; x=1699099328; i=l.s.r@web.de;
	bh=MHrHjcOUN1fSeKflDLEVSnIHAFKG8iJ98FKw421IjNA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=rIC3Dm1gk9SpTh91tL8MYu2LP3817koBxZbVP08RDcpv1l9tKrCdjGnUj9bxT32n
	 lazQURgqiru22mvfe2jqBpQKftwCExZotytBlAjIXqKF+zXyMhO41XsDc+reQXRFW
	 uEbwtBKnSMSoryA0AsRLzoiR8ey1F2YhiH+MlUt8ljpdIjtV/9GhDDNCkwnB3oy5M
	 4rmK2iedAP5Mbglzz98zGaPMLfa9Ef0r8/Ei86ImE8mCxCDFhKxszmVxRvcNpkhW0
	 wIhyKmYuTO5gvHVPhvfLaSzqDOVmgTVaqYHxwpcwJFjIr2Iv2hshXH7uD40MCYH8o
	 eGbPAMBUrq2LD3tz8g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.209]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1qiMYW2SSC-00ESUz; Sat, 28
 Oct 2023 14:02:08 +0200
Message-ID: <891b2fdb-bb71-42af-a82f-43ac73e40ffa@web.de>
Date: Sat, 28 Oct 2023 14:02:08 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Oct 2023, #03; Fri, 6)
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqh6n24zf1.fsf@gitster.g>
 <4014e490-c6c1-453d-b0ed-645220e3e614@web.de> <xmqqcyxn3gas.fsf@gitster.g>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqcyxn3gas.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qQn3yuEJwA0mjiFpqubXeiIOI11MN2bIIqqTq6gOS36wvOGfFGc
 M8cJwA0njeQyL0GzQN6iXbhpovGXGf9qAvm691oGnHY/5wUFmwowA11Wq7pr3kV9rTpou3U
 AuPe/2Ns5R3/r0cTzAlSs/GvlTSPyrAYyo0tA5SI9PBwvr24s2YkoZNB6DuJVQ3r8aGBFea
 VtHWpqRpeixlOfvDQs3cg==
UI-OutboundReport: notjunk:1;M01:P0:ckBkcx9HUv4=;IZeJb66EFsaQC5p7qvHoFAzHV76
 iiVXCgV5xq16Ku96d0OoO6LTKEiGSB4n5BOu9VfGCf1TKQRt7auEEWo3lUpVOSwSblBOnc46I
 bl6aGpRQiHJImvdqrmuU9SeWIan+QCFgsPmUW+satfgRstKhkJKPBBltFaaNs+aplWyUiCGPE
 H1tR9AASkNUCP5Oi+57wGhnf/AKxpiPDhj87hYTvsjLU/c6FBMaEDJyOebxXTtBIvNomhhKzW
 k62DDWtafQvg5ndffYJk6Dr3UPphqaRgSvDtd8hfpbXIbcpRHIaslBDrrRsq67G3x0aYv05hH
 chUXVEqtsiC+YHzFN9Hfy58BBeIsel6Ds5bEor8tdbAzSENur0lCETUZGX8Fp8TzUJpN1E1Kx
 FrNrun1NCbhFwZ9smsGXNIZl6N0v/tx+gopLxJZAduwqgzo5QcNZGoMlOcGfxWiMr3zLPduH6
 z21yFmxhQwxZawLDJCjSvsEnfXJzeAZI8xscF9o9NMh4vqsaWtDU81/ci6IDu40tYTwJU9TWq
 cIXXcDtuw9A2YQcto6t/47znQ/RGiYS5Jg8Bk+dBrIQHXFd8+V4hic7WMTA6p8uzsNoaJGxo0
 /XUdj7792sex0aS2JDippETY2tEEv/IBAPQXOHRtq5saehomM/JXBQPELtc0BwTu6t+4jTyY1
 gzZj+2rOTbz3OKClydqrcmC1m/WseUl0c1d805WEVWvuVc3chbUz9b67V5agux8Ks4E9qz3an
 QeHHam+Y/86DPgkY2d9P9uDKx6Dc5HXHJy+zj+dLUbo9YHMDDYvpeHPR7WPPm9V0ZJzk95GfA
 1VH6KwMUUzsHEUwO45L7oAOJb5FRSeX3q3wL5renku1+zK++FWa7iaqqY7bYH5nTfBONrfSpe
 hFUJJa96eL2bs6lIopJdt3mwK0x8R8f3NaEC6kxS0wUIGwzAp0xH4ylEaZp6MQMwMWy+48zs1
 3Dttrg==

Am 09.10.23 um 18:35 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Am 07.10.23 um 10:20 schrieb Junio C Hamano:
>>> * rs/parse-options-value-int (2023-09-18) 2 commits
>>>  - parse-options: use and require int pointer for OPT_CMDMODE
>>>  - parse-options: add int value pointer to struct option
>>> ...
>> I don't mind removing this topic from seen for now; it's not ready, yet=
.
>
> After seeing the discussion moved to giving a more type safe enum
> support and then somehow convesation seemed to have petered out, I
> was wondering if we figured out the problem space enough to see an
> updated version with well defined scope and good problem
> description.

It's a simple idea with a broad scope: Replace void pointers or fortify
them by tracking type information across their use in order to get
compile time type checks for the entire code base.  Give developers the
basic guardrails they already have everywhere else also in generic code.

Adding such type checks is easy, but fixing all the places using
incompatible pointers is a lot of churn.  Option parsing, sorting and
many other callback functions would have to be fortified.  The
OPT_CMDMODE patches were a test balloon for a small subset of the void
space.  Extending them to cover more or even all of the int options may
give a better picture of the price for such a feature.

Will it uncover user-visible bugs?  So far it hasn't, not directly.
Perhaps ASan suffices and we don't need to care about exotic platforms
that would punish our type sins.

Dealing with the OPT_CMDMODE code prompted to me to come up with ways
to improve its error messages, though.  These patches took me
surprisingly long to prepare (plus my Git time is quite limited these
days).  I'll send them separately.

> I do not mind keeping it on 'seen', especially if
> these two early steps are not expected to change.  It is not like
> they are causing any maintenance burden.

The OPT_CMDMODE error message improvements change the code a lot and
conflict with these parse-options patches.  Please drop the latter and
let's discuss the former first, as their user-visible changes are more
tangible and useful.  I'll send an adjusted and perhaps bigger type
safety test balloon eventually.

Ren=C3=A9

