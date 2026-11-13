Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580054;
	b=4Axq1VQpdSuVhEHO2WtnQQE+BYdqjPdvhqbL/tyBTBfAGk2k3WfEOkJQ8/fHo6wchJd1
	 EhgEahBIC31nkElDgbHx7dEtY4I6ZABnUrSloeZ3ao++6mokaetU2HLsDwPe6bnnqhdmU
	 FozQCA8SnPQY4V3qse07XWaFuxGORx8rAwo7nVJdbhCRW3M6bMBJl7jn7TotX1fwi+SZK
	 nwsFv2a67YNknJceRBuX5TseQCdE0abp77z9I94egFLDNAyeOSGrcOFN36pjWYbpq+7eX
	 Fiz0nF+vZ/09V3Ki9LQvZ2lfgr3YUQdWUewKD57CgSvLbE+snpuNHHhcenTIO4ZenNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580054;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=p7v3xl+EKLHigwzxnDJOSlUACR5rEAd9gJkxga3pYQU=;
	b=kmFZI+sNVaXHk5ytemVwsxLP2J1y/6zxjUdMHz0OVgVPpEbJcGBuXGbN0EpIZH7WqD1u
	 eLKjmXP98fC+soF8pVPJ0ajwmLnQKUVs9SJzNLuPdVDYtgq+nRfDGE9zKYhqU7W+E5V2Z
	 RMxcrWf1zCjIMaj63SVxU9X8og7JJwT04pSN1OCqyQfR8EXdX2JjBGtE3XYR06Jci6ySR
	 e3XfxWzSVhXDMPmbhjOd+8XO+osGF4dYVg7AcIT3gbKqJk2pY3t0EVK3N7n10e7TmFsPp
	 Jk7murJXxK1pa57DnlQmKpmrpgiKwie3mt0mcTqxukVu1O2SCO2ZRR/pD1w/eOC74Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=delpeuch.eu;
	spf=pass smtp.mailfrom=delpeuch.eu;
	dkim=pass header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.a=rsa-sha256 header.s=s1-ionos header.b="n/LpyCq7";
	arc=none smtp.remote-ip=212.227.17.13
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A76606A323
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A76606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.a=rsa-sha256 header.s=s1-ionos header.b=n/LpyCq7
DKIM2-Signature:  i=1; m=1; t=1794580045;
 mf=PGFudG9uaW5AZGVscGV1Y2guZXU+;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=delpeuch.eu;
 s=s1-ionos:rsa-sha256:otypyg9Onr4cqThG+/ymCYEXRvpU
   BdyhUnP8Ra1dpp6s7jnolNkfPc3Sh0QiWvm0qAK3+e5EtZskdIqjJONYMkWlrtP9Xj7uMd09Hb3
   5N6gOuTtjSk3sxHZgTbCmyayvJlcIt2GMjNgVd4aCSFD4VxPEStjc6w18dOMpzBh+mtmpjlhGJr
   CyM5vGasF7AtZfTKBV5J/ZwiSCXW2qhknIzeO7ab3OMpqrJUdmnwrgeuYoSdOYXTkbCA6PzgFsU
   8E5aU2acykwlew7CpDNcZBUWCp0gfTNES87t9stEkfbM4ySx3Z4R2Q/wuo8gn3ub3On92UbnZZM
   f25L7kWEdl6WXw==;
Message-Instance:  m=1;
 h=sha256:
   QTmASMsAYoOYXuB06q4QJXHfZG6OvOnEZ7+7aKOqJNM=:
   p7v3xl+EKLHigwzxnDJOSlUACR5rEAd9gJkxga3pYQU=,
  sha512:
   76VFwh7ZjqC9sQcbNbI+VL8eJZsWvqsj0hZpCORg4fiV+ddfFjpMPzMAUVdTSf8CmMt7kbxRpsLIH4IUPl/2bA==:
   WE0TKrFVA9GZsVYVbTOAQh7Y18AeEYGFHtNfeVwWdB22sXzmvGknQ41yPAuF7t7RkQseYMtt+e1hKfj7gOasRw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1794580044; x=1795184844; i=antonin@delpeuch.eu;
	bh=p7v3xl+EKLHigwzxnDJOSlUACR5rEAd9gJkxga3pYQU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n/LpyCq7CfeDqSm5yRWZ0zHzsjPzuZu5ZLG9lCLrLNxrIk3daoXAQENgbPPig3a1
	 MlXsAblOfi0MNovGtVPvlMXT05zrucAAJyyZdMA1lM4Ff+rWSinC/HhvNxmDX1bMh
	 vssuOSyoFAJRXwMP5o52vkOdnPgbB1uh/GBSnBaXCgwfn9CIPGWh6+9b7CZk4LuDZ
	 ZE60Rvhrs3rQEt6B4A6jDp7O5Q5PRWSwFR/NM+YxFYud+wiJTxniXEAzPosHxv3f2
	 AzrcTid07L947MEHWeYOGxL/CI1/aLf0KqNT8+rmyqQVLYbujbOGjoS6XwCCgA9hL
	 xELNCQN7LYptrPmsrQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M6m5o-1xNzZC0Hmw-005xMS; Fri, 13
 Nov 2026 15:27:24 +0100
Message-ID: <03a8ee6a-4f53-485b-af4a-301eab88e03e@delpeuch.eu>
Date: Fri, 13 Nov 2026 15:27:23 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: document the current project governance
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2479.git.git.1793632435937.gitgitgadget@gmail.com>
 <xmqqmrrqg7uf.fsf@gitster.g>
 <e977b49f-8462-4b63-bdff-daee75994a36@delpeuch.eu>
 <CANYiYbEkTaRPdCLO=kovcAkAoiTt=+Z6=OPhCu9Qi5F8UShe9A@mail.gmail.com>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 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
In-Reply-To: <CANYiYbEkTaRPdCLO=kovcAkAoiTt=+Z6=OPhCu9Qi5F8UShe9A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NmaEIXAv5FkNlb2qfYUrocWl"
X-Provags-ID: V03:K1:E37fwA6iLsm+pQLKpD/zm67eiQ8yBqfkcWv6W78en9s2kfnuEs+
 6OAhBC4QSJEoLShUzg/3Ky4dcYhcyajCXpV0PX+EKWbBiDGePdewri/ojxPj6hrS1FdV8s/
 SwYxO4sshsEy5sf1BCJBCuwPBqRJFGWcby30BkqSoUmu0ds/vwOW6WHII3rBpHn8077AJQ7
 DpMAL2jJGz5b+eMG81TeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4RnT1s3kvw0=;J2sfvbfOxSIUuzhOla7/eg0966f
 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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NmaEIXAv5FkNlb2qfYUrocWl
Content-Type: multipart/mixed; boundary="------------QKVcyaZZvQOlpcQ0IH2MHFqO";
 protected-headers="v1"; hp="clear"
Message-ID: <03a8ee6a-4f53-485b-af4a-301eab88e03e@delpeuch.eu>
Date: Fri, 13 Nov 2026 15:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: document the current project governance
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2479.git.git.1793632435937.gitgitgadget@gmail.com>
 <xmqqmrrqg7uf.fsf@gitster.g>
 <e977b49f-8462-4b63-bdff-daee75994a36@delpeuch.eu>
 <CANYiYbEkTaRPdCLO=kovcAkAoiTt=+Z6=OPhCu9Qi5F8UShe9A@mail.gmail.com>
Content-Language: en-US
From: Antonin Delpeuch <antonin@delpeuch.eu>
Autocrypt: addr=antonin@delpeuch.eu; keydata=
 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
In-Reply-To: <CANYiYbEkTaRPdCLO=kovcAkAoiTt=+Z6=OPhCu9Qi5F8UShe9A@mail.gmail.com>

--------------QKVcyaZZvQOlpcQ0IH2MHFqO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmlhbmcsDQoNCk9uIDA5LzExLzIwMjYgMDk6NTUsIEppYW5nIFhpbiB3cm90ZToNCj4g
V2hlbiBJIGNyZWF0ZWQgdGhlIGdpdC1sMTBuIG9yZ2FuaXphdGlvbiBbMV0sIEkgYWxzbyBh
ZGRlZCBKdW5pbyBhcyBhbg0KPiBvcmdhbml6YXRpb24gbWFpbnRhaW5lci4gQWx0aG91Z2gg
aGF2aW5nIG11bHRpcGxlIG93bmVycyBoZWxwcyBhdm9pZA0KPiB0aGUgYnVzIGZhY3RvciB0
byBzb21lIGV4dGVudCwgcmVidWlsZGluZyB0aGUgbDEwbiByZXBvc2l0b3J5LCBzZXR0aW5n
DQo+IHVwIHRoZSByZWxhdGVkIEdpdEh1YiBBY3Rpb25zLCBhbmQgY2hhbmdpbmcgdGhlIHJl
cG9zaXRvcnkgVVJMIGFyZQ0KPiBxdWl0ZSBlYXN5Lg0KPg0KPiAxOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9naXQvQ0FOWWlZYkU1cmNuRF9WR0p5TDJDalMtUjVFMHB5TlNkNVRldHZI
ODQ5VzZ3QzVKaUFBQG1haWwuZ21haWwuY29tLw0KPg0KVGhhdCdzIGZhbnRhc3RpYywgdGhh
bmtzIGEgbG90IGZvciB0aGUgcG9pbnRlci4gSSBmaW5kIHRoZSBkb2N1bWVudGF0aW9uIA0K
aW4gdGhlIGBwby9gIGZvbGRlciAod2l0aCB0aGUgUkVBRE1FLm1kIGFuZCBURUFNUyBmaWxl
KSByZWFsbHkgY2xlYXIsIGl0IA0Kd2lsbCBiZSB2ZXJ5IGNvbnZlbmllbnQgdG8gbGluayB0
byBpdCB0byBkb2N1bWVudCB0aGUgdGVhbSBzdHJ1Y3R1cmUgaW4gDQp0aGlzIGFyZWEuDQoN
CkFudG9uaW4NCg0K

--------------QKVcyaZZvQOlpcQ0IH2MHFqO--

--------------NmaEIXAv5FkNlb2qfYUrocWl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEJUVxpLyjfMNrm7SYkiwbZqPT0CIFAmr3HksFAwAAAAAACgkQkiwbZqPT0CIG
VBAAwrxSLtVGx24utZgkGq0bfadI+FeIqNmK6Cdy3yfv8s4SFG7jZMhbn2DM4ljQVdvRi4Xa9G0G
QmnIEZIZxI7dsDsv4rDyGyVlSUQDub7Lnqi5v/w3fjsUOFAEuS1zPMaJepzLmPB402auZ0K+MsSj
gWu9FfMPFbEY0PduM1H6QCZAcLJy5s/JBqyK2xoytbzYq0IAlAn9YE3eDbEx7eLquDb9uEy0Rbxj
7NBDqYRCT6W+IBi7c64GO7GhfZmL0khpfvPIlYQ9xC/LdwucyFSmPjHSjaBWGriCyqldyTQ6f4gZ
FzcgSEXg2ANK75wndgijqi5lI0V+tBpDnyeOJ4zAOZcXJiN07D4w3UTVCk/Et+P1DblGgnG/MXfZ
458VmixoIl+TGBMea4WxNvkCb/Sh8NxEacX4c/8++rPS9U275lJlsAMqO/PU44lohc83f8u3sIpL
fOjJ1N61t9mFS6YcmB9vAJrkja1XvDFxeS53ml/XfcteULJir/j4q7/q1YlP+xLJJHf8BzaTbJ2T
792gtzwTEoPhiXCuHHxAZZZMXWpRkTWRrYOkFHJWaKTYLmWpGdNqkCQ117TgOnzs8xqALcbTbnZB
SOlJZEwAKWZU5NEK4O7wBRb+29fZ4nCIuU1U0b4V9VWQ/uRl7dhmYhgWJbFQ/mAZa8w9zfCBBpIy
j8g=
=7Aqe
-----END PGP SIGNATURE-----

--------------NmaEIXAv5FkNlb2qfYUrocWl--
