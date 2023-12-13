Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="BWtOnDYj"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7275BB0
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 03:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1702468597; x=1703073397; i=johannes.schindelin@gmx.de;
	bh=6ZQkw6q8jxhPG7nY1q0zrLv+KlWRPyjUbcT7QATK1i4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=BWtOnDYjxohEuQhsuUnYlapJ3b2ez9/XUgJABTap3opD2d0yKG1vpnbNyGQUVgme
	 V0EA1SuwNX6XOgwRWtjaESqbk275X8M/FzybHUvhkk0SAs4YDEXXorao0Nv15iZ6B
	 nS6YRcyXAOYgdTlIAa/gs8UgYq2kLSjyks5ehXCfvc/LC+pSn0oPk2EwmyubB7w02
	 hxjJHXcdyr44YD+L3XfjHN6z5k+PpBinSOUhGhegu5rXhRM7d+/gXKZyOzDmCWVrV
	 1E29BgjaCdVuIQOeDJI9a0l1v1TKinseobDi0wBVtao5l8d644EcZZQCM2+EnzKyF
	 ySepWPuZUKWsLdOygQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.125]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryXN-1ra5bc12Zx-00ny2X; Wed, 13
 Dec 2023 12:56:37 +0100
Date: Wed, 13 Dec 2023 12:56:35 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ragesh Krishna <ragesh@rageshkrishna.com>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Problems with Windows + schannel + http.sslCert
In-Reply-To: <TY0PR06MB544239787E909DD4EAC1CA42D189A@TY0PR06MB5442.apcprd06.prod.outlook.com>
Message-ID: <710affcd-f6bf-371c-d7e3-8bce3b01da3c@gmx.de>
References: <TY0PR06MB544239787E909DD4EAC1CA42D189A@TY0PR06MB5442.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1MTdoUu/RSr3ojLZWLhriaJ427jBpqrkJTKvlzfloQXJLEHzuVP
 4spJG7TGSCVrYyKv4qM/DEIIYNahSFq++nkBNnnKQMkTKWNVKuqF08VyjzyUDDOsM6ftDAe
 PhCT0zaDO70hTzvEcO/NgHONgE2mxaV3GgEGfmf0o9YMIJW/V+XqUNcVno9tFoZE2vjfLED
 hKGDKPTArOa/JIRwp0MSA==
UI-OutboundReport: notjunk:1;M01:P0:FLjYjRytmeY=;N9GLgLpT7pUK7Rx1aECLtNF9MN2
 Pk70bhJJg4g4P05dxfHkLnd3h/5h9xw/YmAtuutvr82k87odT/s/O6EU9h3qdd7fxZeEcI51Q
 nFDVB4VyCYpFED1EPCujL39D+hCnzAJHYelq8dOFmw+bmEkzp5WrKwS6c+kLzsnr7zMMPhet3
 nRkpoSwqZPTfWtfVIpJGfirigp83/2933Gw9bpoWucxwX0hvzRO0RtZP5aLmDcXJlIwH+Luss
 N/dph8hzqgF9Xcr+oLEGHj38KDzedrReXkIOKRHDlIK+FhD90ePZB6FlZ2XrLkhyQ7mD5/P/a
 Os9q0vbmNkIHffjmzhVj0svWV6vtydsQnBTo/tF+QUBRRAUIHhDP77XMFphyBldv/ozopDMUp
 wTUD4FLtxIWZtaA/uHSa68dHyznz0OUJGlIzKpoC+kMbnD8Kr18aCOl+7XEdykxL8VA5w17xr
 WNGWaIHRbzImt0jgVQPbRbZ0RRXaQZ7PezAGvz4vSOsI1oyaOFPIZ2nIWzxCO1oRzYC55PhLI
 2LOBKzZ2FVs6xboglQ/vMpBX7nWNmrl1EPrWwXbCU425K7GR5POLhCbTDWLAFq8xgGiwGu7V+
 GCw9+zyymXFcEQX/nBIBnwXqjdRrTER+5x9njUPPj28GfoZas/0zteg3a/gHOMCKTTMX6dA//
 xXWSyd/45qmRSorfVGs0jt5hru1cLe8kEP6cZguRxKa+Bti1V8o0W3Nxr4ujt8/eqHCqvQejE
 5U8HvhJUS1AgV9EfCJ/o7LEMI5UjOWu/bAfmAidygJ0SGX6w6wfTXROBW+D6s6HmJcS6gkmjd
 XLUzfUqK2Xjc0xVYyqci7gJSv00PsdXHMFMCTnGEROCnL8jwB2UzCc6k822fOU46tnT/ZunPF
 DR9x/gaHcqLN2SYA46SvNLMwvbchZJwfmuRFHfrHK+zrCyTy/mO2hDsFNRh9fuMSx5iRL4udz
 Ns42Lg==

Hi Ragesh,

On Sat, 9 Dec 2023, Ragesh Krishna wrote:

> I'm trying to use SSL client auth on Windows. My git installation
> currently lists only schannel as the supported backend.

There is a reason why only Secure Channel is listed as supported backend,
and it is a relatively boring one: DLL hell.

However, contrary to what `git -c http.sslBackend=list ls-remote <url>`
says on Windows, `git -c http.sslBackend=openssl ls-remote <url>` should
work, too.

Ciao,
Johannes
