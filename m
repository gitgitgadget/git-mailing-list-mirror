Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B05280002
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388066; cv=none; b=P09qv4RCYqVIEjQNdnAZ9UEdDRk5vulOLkmlOcWfXbm/ue8VgHUg+uXBzUcG8tk7vgO22B7apRHPxY21BR8VFC9kE8/F/hOy8pP9Ho+wCKuXcRgcEQHGkPtobP7HzLJpkHiknrqiYXsnXRVDlQa9MD4Wz5hUUF83HKEvnXBfdc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388066; c=relaxed/simple;
	bh=EPZ+xtQjhcFk96xn7wOx7ctU+F0R5IA1hAut3tWEQOI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HYlYzZGZ7zwVSN6Ey0aj+HRQ0SXG9ha3mXEUn5IJiPnlPeDBAQ6NYR+YF65ot9RqXmr6+EPG0DEMm81KPC//bqIZUq+RWRilBP9CnWUgbrZ7gBe8g3Wa5pgdUycv7BkKCdZ5Pa5H2kkPqvTqjQqvNUEaCeoZ9tKydKWI6mZ3EL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NW3ZWnPy; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NW3ZWnPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751388061; x=1751992861;
	i=johannes.schindelin@gmx.de;
	bh=EPZ+xtQjhcFk96xn7wOx7ctU+F0R5IA1hAut3tWEQOI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NW3ZWnPyAJIpNFwo94BBchZuorSKFOPth/1wZBf/qsiY25Pm0glCrM28umBU3pWp
	 E1FeAXuBFkkONlz3DhmqoN+HNlOf5S/wmgsb7iHYUmqCF1W+n7PO8SmdWitBdMkp7
	 Jt/g8EH2cFp6KgdShsHug815R9ZH/QDuVrvHrINPrBOLHSZoEPiIkR6mpsvy9sS5A
	 m1Zl3ysQd7FjIEqxhgzBhELjAJyfIThO3UHISdALjjgQN43EqG+qik+AuezuJtoUw
	 YUZb5Pgein2g8772JYDzgGD6Aaytc3SEpwjr6SyebEcfu+bdLjH9lYSFb7T2CsVTd
	 Xiz/mhr/UzlLnrlMyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.20]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1uc9HF2ipY-006AE9; Tue, 01
 Jul 2025 18:41:01 +0200
Date: Tue, 1 Jul 2025 18:41:00 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Aditya Garg <gargaditya08@live.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Why git on windows pops up Git Credential Manager inspite of
 having set a credential helper in .gitconfig
In-Reply-To: <PN3PR01MB959737CFDDC39898364CBE34B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <610f64a5-015e-b2d8-03ea-78bb623f6af0@gmx.de>
References: <PN3PR01MB959737CFDDC39898364CBE34B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UI74jRUfGGh4dP9L/pr7plfU+pq0nu1lll3MyOG51AQCdhsEg7I
 UmlZAf20B9Zh2A7ac3hrDMLxy96cNtr4EAig7K8Dx/DXvZSl0zoybUUL73UHCDAElUJjEjT
 h6nUTiQAmBZecATe837BMGu1tuMVGPM+sORlp0ueHWLTz3xmVzmymQVYLQui/EtScP3rYBO
 DR8VwhZVJJXORbrxM/8dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:artJGNodeHc=;WpmRhmowYkyQRPTEfaEiPQ0Ksg9
 16bEZ2kTTBn7zBxJM9FjVpP8vJ+hIGKMTJ4Gh6Y+3bxNGhS1Uw9sm8P8Z+dsXutHY9KIKoLoX
 cvM1GVfy0MvsjCG0+FOWOdLsXBD0ht5ZIj+5BRiOLWvuZ1uc8GoQ8RHYYJZyeDq85vnzpRQ1v
 oMHzkyyUcQ4As316AWhWDjRJlK7Qbhe7RPMNY8y05wf9Fwx9aet/54aPPrvo3YACDC7fsVrhl
 b0B9Kkc32ZWQwHwWFaNVOhQF57PVDJ/2t1Ug2zx1JkTrzkzf7A9/FwnkqB8dxfUakDZSm1FkE
 7nWDYn+00hthPl9Y0iYQxx4VpEvtMu+rFil857pEX/ZynHCxBbf0aOFHfW+mAdMljnqiZj/4K
 D7GLsqKByA9UnazkLb57MwMf/9OH7phnTEoaVD1A6f4uK5/A+TpJfhu4sRQ9kRgnaQd6ni9a+
 TEm80ZY6WxpipAW/UuoVxzg4yPWNi80kj6jKrIpzkjKA6L2BHlIwW3KLmw8Od6HNeoUNatV1k
 c8nziFbJpVN4wxMDPF2V1btlut6Lt2u4Gp+/Ly/xVqotlotJZFThxS0JH2pFiVXehA4biVq2w
 UvZQmksaCo6QNwnH2e5rKA3WRdMnpN+m3uuh+iMaloGYGTLrE6W0cfdpKWJjJ/LtTqxI8LR1L
 SkolVqr+/yVnNOIEG9oi+SASTttcmwMDghLzDjuglA+nZSdh6oudYBBW3+MMUzFB3Cuq1fezo
 PaSTOosTkwOLX8xPBHSIY8Z7XBAoI5zRUd1MIF4KJAS29hVjHOagGy30XFA+AiH+Ld3P2aaT1
 apJ4y7UacyFcKuy3PrrUCYbHevbNGkuIKFzc8pDaMiIeHHrvy+lkPzrECOuciRWz1WD3/835k
 ZzfW4LhViZGAxK3DEnFjGGRR/Yd6iWv0O76dKRfdvTnhJDRjmqXceci5yWEfmld+U16FO7aaG
 kdUMn9SilCO3ubPaGKEb/CccubyYsgM7wlu1uTcVY+VtQ3TyrKrSuHl7utvbzfKF1VYr4x5oO
 /FY66hrPgvWVDr2yzRttOafEs7WviG3ZmnIOyH7ZE9eojywA7t4n/35jaW1wJHEtFo05plbPO
 zOqTvI/lVJu5Cs8GIiJiOrvFv97bIOBQwauq/TMkKzfKiDeL73B7zbEbiZ+CVAsZd8oVXd5oz
 8n2UPFsWM2WtZ9zjtUCTScnOx/atwMlJzddicrSAT/vTeNpXCOkBKk0rCGSrFbpilfb1kZW2W
 mdr3AMTLd2UmGZHzMhfEUaAzF3ZWF6gbvaW0kuwqR5GAQSghyMzoNWcU3EkLW0uMdadEF4BaP
 8EdXEmucQo4jRplTo9L3rAXdKJjljso16fz63PmOJDG3hmcGz/OYpQYfyB6Cvgz0Dk9679eC4
 qQoxTDoj4Rk6wnYTXEngXc0Aw6M6zGxeHdRABMxz/2ub6nkXJnDtcvBbxF/5VaHXIt9c3uTzN
 oJxp2XPelzfgRp7GmH/yzQcluMZbvgUdV0lK4ooWBIH+XsKyY/Nu82km+Kmjrj7Ci1CSvXQr+
 QCIXyC/6U9h8QoTYd0gpfO5xK6+j+UkskBZiKB36XnSuagyVMORk4JvXRauaNVO2+j568e/G+
 gqhGriVLsTU2N3kC/lAEFtqDHXbEMREtWzCQzmyVu0Fm7RH9uqySFJc/A3NSUzYGmJP57ON2b
 Pok4ZdaVvYuN5vRHhlQSgpE/hUYjs9aGEap1wYpPxco4eEKsQkLitfOFitM8QXUlEP5mkDFXc
 8X+iKuVOz9GjM1loDUee65wK8xgaDSNGLM9RHJwaCw39PIDs9vtaY7i3gcjcDLoN/9/v1yl9e
 hfbjz+x/pdZaVvyrsEfC5uK9Qz/K7dLPoosbdUUs6eiHHZtOj1lVrzQkI2uonkWdPSBt6XKNN
 zPjblSrU+VwWFqY7BYCHcJUOKBOt98yLvXuFousfpNzSw99IUM1fzQGLkXazhpUCbYdceIP3W
 RnRPDET759HEbVKIOl6WwSb+dmBws6coPQMBY0Y+lrMVnp1mq199vx9yaTLBiyfUiOd900+Ih
 /Tsf5fmFy1A7WxrNjdLghosVf0Z1NrNoQWbULxezm1yYA1urs/n7wirDnrFx1by3wklacpgjf
 WAnmrrA0XB65CzEau1xbU58RRbfr7QQpt4nkKi79KQ04kMppRBodohqBsyXWKh+l8x5j3Hf7G
 dQh0P7RLfQFLGjuP/Sx01cghGT/Ynqa+WVeYiT1MYjB8wFUfAgbNpfaOP92lVEVS6/aAexf+l
 cwFVjOmAytEKnOTNDU0MvG4fPiAFE34m4Lk9A7w+YxlOvqmYL93xVR1sawdkU8qWS6QxQr9YX
 UxQ3+acsakZe83BPglfXftzPtU2P15g0U1iiYsqZrvSKsXVENGIK/7MYV+w7zskSE3isHCrgI
 2xvPpf0U1lLrn0/G/CSzlzJAU49pKIRnEf3MXY3dYzpHwravjGEEg4nThAwvKV7Ap2BUgLK2F
 XgP1JYGty/cWbSMarkGLq0O0RxtWli1HjOK4jU6Evf5dLCZKvSNcLLfS9jkgM8UAOSJ/P75c7
 rTWs01Knl6HlDeCXJf1COkwbPXsy5Z6zSiCUVJdD3VX+iVZHb5qdwZbrgbBLJ85PYjvfKVgEY
 ozm3yNVFYRtVGZ5msBV6yCu8UCKmuWq+ygD+NYMmqimRumJt/OuGfik4X4vsZKWcTh5CjriPr
 ZwFFcUW5k/ijnsOnBwrHF6bNm7SNPAS1rYi/+2M38wcah0BY7VVOxnR8Us7hGcwitnvPJV3Di
 nPQnJX1zPmS8/32OBUbTJbyOE4xiBJBfI2HoBz0fC1dYKs3zwtm+6YCdWx67GC7Pu2wYoXnxP
 Ri2+gAv26ZFxXhSZI3xYS7spUSv+OKTiZJJOEGIEcbkTd2WOJ8Uy9rHIS2oT4lmkJEhyhj8E8
 RznHgkb78chtb/7rCei4XdsrQqSh41HCMDnM/lIu8Cvuy34nHTFtXGo7rZ7GTV5xY6adJgPEc
 sm75W36N7sg8/h8ELI+e0AqEk/beLOdCW10prw66Zwq1Lundo/3lcSOmeoWaCcAPrVzeQyBco
 B5pes40ZRuFniU3XxxDLUIO6URRBl5DJlN38ntK/2t0y81oY5nVGC8srd2oxGuCLAuP6hm5uZ
 VvsjfpNr2ptJFA3jDMUuifqU7+YY0NpQdCTdayOZjFgBKImlXvTIVeC3T0zjurbOoZWjDbTBd
 n4S6qz2LtGh5XmxhvFUuAoK5VsMqwHQ0SmD/SMe5yaxzvcq6cg9AnMbVUFmbo97TRR4m2jQN4
 zqEjfmu+98c8EiTtvBKnDBvAVLiVbavjRPuzMMIg9WsbJQZW4ZnSwb8WOBCX21wZ143gxVlUw
 drORk/CAcUb0mZu1mlIWVtnriTaii4tW6m1wTl2cbyLZlrOfjsuLecBeh5Qr3t7NjWn9v4zjf
 p91cVrQfv8Of2ObsX/m7D1tPU12Z1xoP+y76nS2UbWwYoT47fPrPMrwybHOfj47dIl+MsMfEb
 r7r9oK4N5lg==
Content-Transfer-Encoding: quoted-printable

Hi Aditya,

On Tue, 1 Jul 2025, Aditya Garg wrote:

> I am having this issue with Git for Windows that in case I configure a c=
redential helper by following the git
> credentials documentation (https://git-scm.com/docs/gitcredentials), the=
 Git Credential Manager still pops up.
> I simply close the pop up window, and then it seems to be getting the pa=
ssword from my credential manager.
>=20
> I removed it using git config --edit --system, but after every update, i=
t pops out again.

As per
https://git-scm.com/docs/gitcredentials#Documentation/gitcredentials.txt-h=
elper:

If there are multiple instances of the `credential.helper` configuration
variable, each helper will be tried in turn, and may provide a username,
password, or nothing. Once Git has acquired both a username and a
non-expired password, no more helpers will be tried.

> I wonder if some proper fix is there for this.

Yes, from the same page:

If `credential.helper` is configured to the empty string, this resets the
helper list to empty (so you may override a helper set by a lower-priority
config file by configuring the empty-string helper, followed by whatever
set of helpers you would like).

So the trick is to call `git config set --global --add credential.helper '=
'`
followed by `git config set --global --add credential.helper $HELPER`.

Ciao,
Johannes
