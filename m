Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9A1CA80
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="AO4wF+9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702997070; x=1703601870; i=l.s.r@web.de;
	bh=yDVXG4KOSfHHM0wButNnpFYHi+aHNVXuCdWFuxei0eE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=AO4wF+9aye6mD/liv4WlZvFSKWktBtMoN8Xb9oC9aTcczxhka3N0+S2xud2pOqWy
	 Uie3FX9IUcgvIe8KR0lB1bpuIDe4RYRYyO2jaZRYcmHS5+PrwvaForQ/eya/heBR/
	 PI00fcUenXFzf6BYzIQNO8mmLeDga822r58VKbp+rffsyDCGlYf4pReVj2VGKLQgm
	 xdAQlq5ilSVduJmz+/WTtnPA3CYPLLeDSPu6tKaK5JDvMk85yaj2Ayd4z3OJhLGBp
	 WegpZsdzQ3nL8f1yJiuqKCcIRwufw2HMFYTHWoHrfelgfTr8mmO30WIvKZoRhW8JZ
	 P0sq//avOV8y/YohfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1qmKam2WsI-00fcDK; Tue, 19
 Dec 2023 15:44:30 +0100
Message-ID: <e788cf7b-56c7-48c2-ad4f-65d9c9e73ad5@web.de>
Date: Tue, 19 Dec 2023 15:44:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] SubmittingPatches: clarify GitHub visual
Content-Language: en-US
To: Josh Soref via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Josh Soref <jsoref@gmail.com>
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
 <043d2a24202d39c5564e4a4369c86ae4648dd721.1702975320.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <043d2a24202d39c5564e4a4369c86ae4648dd721.1702975320.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a87ez9ZhrnwC2Pa6xL4cVM+5d/dETh8wwEIn5DYqajb+t488zQa
 507sg8v8zzG1UyfKTho08zpRF6QdJR1i3a8Yhb9r0X9/YP95408+ACRNkB8Ry5zBtyj4NZ9
 5DlrZkv1na65v3PebuSyshvOyftzXJlW81/7pHHJu97unplIDuxYQ79gwqCHIsUAvFozkjJ
 8FenmIDACFX55wlJzGJSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Hg6GNIRGc/8=;Dwnz7Zs/bRH6HnPCcL//NnDUHud
 UVpXPMIM0WwD3jFY7llFZmTPZ1o+jj1/3ZrusHi6/uRabDB0oyZ1GMvVt880OKGGD+OzxeGzH
 O9eNYbs4fg2Bm5JPO1Xhs2nxau8lPCRqLaUXChUL7U8E5VO/L1EzPCr32mgLfTTBDQbbOfL2z
 uo76+neSwtlWRk2VDlT6VbbBOGX50RUdt47IZspSvUh1O0fSyGEEIiVvkz7rGvVmWtsHf7NE6
 U6Jk/QFGD6LE1++zIz7dLZXA/H/i2/F/hrYXYjTbj5F/PntmTgnORFvsgiG3YeHay/qoBdDxF
 03evbafFX2Sb5xxDLmS3N5OTOoeY8Wo/t0N9Bo42IkPaV1ali/1DVqjXvmTQSuWvGHOkJcMJL
 gbsOpcfCyDLULJ8s/cxg4Lx6USxc1dCGRx7NelhjAOfq27tmxmf2n5OQaK4dkbRgoae1728HX
 zwZMIURmNyVKhXRC5OSenWuernPOiM9W2v34yVPIWUfP0gMf5RBPgFfQXuGBb2AV0jb9ewfHX
 gtT5Aqb59vEyIX66tHR+HxaV3bXmPDzCnfCFM0418Qr1nGv5KwFpi3F/uE0rDW9D7voefuAPW
 I7n4hmoGqd2VxvZm42PRmbruN6Imw3fUL83fWGrEixJa6/kaGore3f7qUzCp3encdiUM/yA/3
 8uvsQUDO1Hu/35kYqunhT7JAfUBm/jyHd09X8vW0/quwLK4J/P/eJZT5TJYGJdErK46FlWMQr
 XI8QgPBAgbMsyPbeEW64R+NhxSl7lZ0AWHOjq/ED8qI3idrBUo46prNPwf9ziT1f9d8TAyG/V
 jcbjDEwXRZ/f6xLpLK8hnh2cgvQcwo7ZkCrUSztet49sHVMm+tdh4pyS0vCV7wo8N80UYrw1+
 Iihi/HL13KWbFhK7ZX4mSjSD91G1++eHhpRU90wF3h5kKrv0NLIPMa9Cf1w5DCo/yOWVmWFL3
 cTJ/Yg==

Am 19.12.23 um 09:41 schrieb Josh Soref via GitGitGadget:
> From: Josh Soref <jsoref@gmail.com>
>
> Some people would expect a cross to be upright, and potentially have
> unequal lengths...

There are lots of types of crosses.  And while looking them up on
Wikipedia I learned today that an x-cross is called "saltire" in
English.  I only knew it as St. Andrew's cross before.

> GitHub uses a white x overlaying a solid red circle to indicate failure.

They call it "x-circle-fill"
(https://primer.github.io/octicons/x-circle-fill-16).

>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>  Documentation/SubmittingPatches | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingP=
atches
> index d7a84f59478..8e19c7f82e4 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -604,7 +604,7 @@ to your fork of Git on GitHub.  You can monitor the =
test state of all your
>  branches here: `https://github.com/<Your GitHub handle>/git/actions/wor=
kflows/main.yml`
>
>  If a branch did not pass all test cases then it is marked with a red
> -cross. In that case you can click on the failing job and navigate to
> ++x+. In that case you can click on the failing job and navigate to

In the commit message you say the x is white, here it's red, so what is
it?  IIUC the circle is red and the x-cross inside is the same color as
the background, i.e. white in light mode and black in dark mode.  No
idea how to express that in one word.  Perhaps "red circle containing
and x-cross"?

Ren=C3=A9

