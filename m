Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045A364A5
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166165; cv=none; b=Vp5Wopo7wrf7c1wZYcGcgw3dSDBU7bBnNNbJzvVFiKHGWylZ/ukKMbaIF3xbKqcCDZUcmnenWR1YcMomRXEIlmIDbErw7IQcjEWnf/fp58fhkxdH4SlbIAjcdhdA+niFGxTcp9Yq6bge7kzAolRKZ5ZoNbFD57ymYpLjMidiEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166165; c=relaxed/simple;
	bh=upUugHMXt73rHN9Xy/gJzW3KitAwByX6hoCtoYRwyQ8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pS/3Fg33Wb7/P74GUYs4FSQHKWtOCCRPS8+OisRjmsAkY9jhULCmtm7/NEgkYWUXpG2rCKwjxfMWhkBEaq4JJUzMBlvcurMiTWyVinkMzNwtKsJZiK2YOUi+yRHtjfJeHlZ9vsqvPUrUpZ5xSUq9EkLMXNnYp1NtownwOjhqPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=UwhZ4NF+; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="UwhZ4NF+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713166160; x=1713770960;
	i=johannes.schindelin@gmx.de;
	bh=zj06XsyaEG6W9BoajVRl4dE8ddJKeg/8Bs0D6hZcNdo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=UwhZ4NF+ZxhVe2am2yPCfysTt3R/NSPBKBTadepWliWdjDNOyIl98pyAZNdk9E5m
	 dWWi0uXLI++Su3hxjVcphHWDSTZtRRWEI2qnCIG6NA2k5ppQtNzE0oNwLpOqZvtZX
	 f9C/oTo5ODe1b2W4nuzvWW1g+RNh/6UniIsT82c5HVhTQxtw2YBF0/4Vj9+UnUbLV
	 VnI0Bnr7OrzKCW5Rv4w4ynDE+DLYCgdJsz/6B+UA72tzBPS/AkMUBxu5lnYqiNG0L
	 QpKQZAuxZIgmVH8W133EUB9PVQM+AXBDzTLbeqy0vqNX/bvLF25wp6GUoXMShDwFg
	 I3w7AXzyMRJjUw9yBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([79.232.181.149]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCbEp-1s5vQa3JOV-009e62; Mon, 15
 Apr 2024 09:29:19 +0200
Date: Mon, 15 Apr 2024 09:29:18 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Scott Chacon <schacon@gmail.com>
cc: John Cai <johncai86@gmail.com>, git@vger.kernel.org, 
    Taylor Blau <me@ttaylorr.com>
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2024
In-Reply-To: <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>
Message-ID: <a34826be-a16c-ebb4-0450-274dcf75c31f@gmx.de>
References: <ZhcBJSP4MxX0AMFM@nand.local> <A7406B15-8DF1-4B3E-80F3-BC56A9AC4D85@gmail.com> <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1497985291-1713165973=:1415405"
Content-ID: <98a4bd8f-b766-7fac-0ac7-d2c8683eb31c@gitforwindows.org>
X-Provags-ID: V03:K1:gkKiWw+0sDkmsEbxefyyxBUamz66itjrfrivOqG8iBLuaMlwAzp
 R+QS5WM9iJ3Nmk4gof7FD+c0Qcu2TDt6pSNXW20LHJzDI0xznaCUUqPXdYOKCqKHLwktMOu
 06VNRkWn8xZ/2/zwmsogW5OYc5C7U7UHHHj2RunS4wQLfqcaC9vRmiEfPGj8jC/E9+W4+9q
 Vy4S9wshz04p4QVP8KIBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5ZwcjIJBenY=;8sFgwkFyDkJURs5cUSlWksnyrp7
 hWzVclu/kv80gc22TTukPgOAeM4QV9CWNI9gkwPaUE8SQ2cyIfNQKzL7tO/33TvUHxfx6NnH8
 vfIZOlmtFCwcirSdZxot4OGVtBXaXA2G7/79TBvUzxvGxc55gpwK+X5Phe31lZV98065Z5jmr
 bdOKB3MCKCU0MbNVqaecBPyG8yWun0ebnmgNGFyWbVt9/pqX7FjkM8tKN2Zp6wAUZt/DnIpEi
 L6Mwg3gMPPM+n1UdtppUukDM8FN9Cp8drLJG6+YG3Y1lCLUCS/0nSL4P58RcSAVI74XTRG7Lk
 8nakvRXcChtihyImIvFMw+suZC1hxNBQvowFMB7gyECb/8TQhfOkE7QgC0hthaYldlLYyitFA
 bJltbln5EcxPlRqgupBgr9Uj8BOmJ6MrBwURaqjSuLyhyHj1zYcCtN7ntsSUAg0RaZ8/P17Z6
 QQhaTlT2fd6u8SqIDP0sIaxfufgLIlRL+M60KN7odbQwmfuN6Jwhg8uTt+hhxTzdiwW/4B89R
 /o1SMMHADe1JXC91taxnCvUIdDnYHrOr+jLDF1x2rktLZ17Cc4du7tYrrwxHC7wNP5jTmbwVV
 AoW2Vr7bnwSUNdcYP+/xOdhzIJt8w4KRA5QJe6h6FhIeb0UdIMTik5kvqA6LOi7nDT7093Ts9
 WRjKzDHbeaZt1XzBH8UzF5MPUQipS05P0UEPq5Wyjsnhzf5jAY0tkTIYSpjxtq9ChWydwJ8dq
 cFdn1YcviXCr5bE5HWE0HFaOe0mHqzzsaa8hKW1WXLx/BYjW0J1r1Qt4Fb5totmgsJ8cxFOpJ
 Z5MSBMpHLtffB0EizakW1CsVkxL/J7okhhRWWQSxBVT4U=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1497985291-1713165973=:1415405
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <42034390-d2b9-53f2-dfad-fd9afe696197@gitforwindows.org>

Hi Scott,

On Thu, 11 Apr 2024, Scott Chacon wrote:

> I was about to come in and say roughly the same thing. GitButler /
> myself personally would be happy to help organize an in-person, recorded
> talks Git Merge style shindig in the fall. I'm also happy to help with
> some of the core team / speakers with travel costs if needed.
>
> I helped organize the first Git Merge in 2013 in Berlin [1] and would
> love to do the same thing again this year (my my, have 10 years gone by
> since then?)

Thank you for offering! And the same to John =F0=9F=98=8A It sounds like a=
 great
opportunity for you both to co-host =F0=9F=98=89

For the record, I would _love_ to join and celebrate the 10-year
anniversary in Berlin.

Ciao,
Johannes

--8323328-1497985291-1713165973=:1415405--
