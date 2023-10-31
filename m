Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC90E18C29
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="T+KJywbX"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DBADB
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698746437; x=1699351237; i=l.s.r@web.de;
	bh=Mkaluv4gWySXNJ5VbAoM7oxC4uLBOna19Aca3Cc1ieM=;
	h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:
	 In-Reply-To;
	b=T+KJywbXGkLHUrs2IX+Ttb0IKLZScsf0v3dhALAgeVo3O5RbsrrDHL1st6BgxWTg
	 MccOgbR12rIqdbqFLpf7wAnAorxUpxfouDofqshyuyvvOUwQ184nmpWJqMK2Dnqqv
	 0+F1nXq8hKDQintfMrWnMTX5I5l/OI/APoMV8MjAXaFu9i59dQacqba+/dKRdWc16
	 qCHN1tx1X/7ZjiCN3L9UOuBTylWxKSUKd8fxvuzB6I4K4yRjFkIzBHZvdWxGNB+M9
	 uIe6JE+ThgmYIeuwDWUjS7Frvyyyz5QY4Vx3/5N2qqz2iY9mnd5afJIWy6VutvVjQ
	 uruUm5SOIcgRWaJ50Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.159.209]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Pm-1quQ1h2Bca-00WE4m; Tue, 31
 Oct 2023 11:00:37 +0100
Message-ID: <4be3c37a-6a04-4d37-9b20-4199435e5cf7@web.de>
Date: Tue, 31 Oct 2023 11:00:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [EXT] Re: ls-remote bug
To: Lior Zeltzer <liorz@marvell.com>, Git Mailing List <git@vger.kernel.org>
Cc: Andrzej Hunt <ajrhunt@google.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Bagas Sanjaya <bagasdotme@gmail.com>
References: <BL0PR18MB2130C672D503E49F955E04E8BADFA@BL0PR18MB2130.namprd18.prod.outlook.com>
 <BL0PR18MB2130A3CA5DEF0DD7199F2979BADFA@BL0PR18MB2130.namprd18.prod.outlook.com>
 <ZTsNfgJV1JN2y-Aw@debian.me>
 <BL0PR18MB213007901229C84D348D4CB8BADCA@BL0PR18MB2130.namprd18.prod.outlook.com>
 <cc829a27-2580-4e07-a6ff-2c4992131420@web.de>
 <BL0PR18MB2130C503D3608186AFC516D2BAA1A@BL0PR18MB2130.namprd18.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BL0PR18MB2130C503D3608186AFC516D2BAA1A@BL0PR18MB2130.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E+Vu/LPXMKe6eVczYbBL6vuAE2HBHpJ5oINwAF9HX8cIsAca4u/
 Jh+AI9csFsGlWzmCiNpblA3EQfxOvVWr2GtnmL/OcRDGYVKdzv6NpQW5rgRqZyIdTQLLuiW
 ERWUZ20IDQmNwVSEcw0J7/X1RTH4hqUd9yBIvGEyiBuVr7bXgslM1l0RyD9pdKZPCckX6/f
 K4EP8QOdzrwXTZn5gWhAQ==
UI-OutboundReport: notjunk:1;M01:P0:NcVILl1ZZK0=;oaFmTvfV9TswB3Dhn+jqzTbrp1Z
 pZQwTDC27rX52lbCaX2QzSLz3EoLDlutKFM/epJIhQ6CCMfWGCSFOeH7JPtNWIxHkFvEqGb9L
 5SVoONidtIT6ZTnOVPlTOh2MZMpRwFEq45NzWvo+aozLORLy2QXN1xwJNw+xggEXaHan0X7De
 JB0YdOTKzUNYBU2BsJT8b0Qpt6NHwL0ll+gVUudAoCllNS2gAzMBxPW2s6qj9jFapfZXpp7Xz
 iBsTq4wICzvVC5d5gebdDlVrA8GxpMGLB9W/zQcjZQ4NFcwsl0ntsEMVVAWRL5Fsy/PlqkK9b
 hELhUhjjzjpMrq4R/Z4DllEtHUdcxkg/GJm5wRhg8+75ghaByYxUEAMWFsMP95f9yynwqN0gM
 T82joTD/C4Cd5dWD5bz3dmI/zhz/PcxNX7h7bm9l6qfDHetVrnLp3GCmb5ka121qb/EUGREgl
 0cc5jhdsYAV/gKVRi7Kq5+NCcI8+5NOrNnf/kIst58qQ7I2g/8h5xEmsKgmN3AVd0okykoHu0
 MBPdCs+Cn68d19p6BlR1bba4dzLBjq8fAX64Z4GbgzbytqRlFlaQM7StLR7+cpt80a2huxavt
 jVKUp1rOSQAcE7D8Gtkrwx8WIr7qdy8YgdXEpFdV6G9TUQiB8UE30XDeDT1kyjYtsgHq6PZV6
 2vy8iwN9Lwrb43qlngcPxzLTzulzpYHe63ssM6s8lb6ewmomurLywetsPQMfIMRfjecdofU24
 NihW6JOucYTc7O+hj1vXIivHlpcAujYyj2nqzhQPq8/gaByISm29kq1NL4szxbyYUAcwzX4Wl
 w79ilPIp/oqKR+5tIDgnDop3kUsZEyqNUIoMEQQX9PLlzJFQ2X3uaTHm2+2gs+AdulOcsw5sQ
 R8VlOhL+ngKV+sA2Gx5uqWWeatdGj/riQ6dNCeGoHEIUmNCH+IDRLn1+RTyNbFDQN1cS/Qv83
 jV7QVDg72eGM8eXQ/2IOBe96XCE=

Am 30.10.23 um 09:17 schrieb Lior Zeltzer:
> But why when cancelling stderr redirect to stdout (2>&1) all works well =
 ?

Good question.  Maybe the output on stderr can give a hint?  Any error
messages?  I assume there is *some* output, otherwise the redirection
should have no effect.

Ren=C3=A9
