Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4AA38F641
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656734; cv=none; b=ktQJcYX2AKL3ZVzrmS8zttIm0m28u0gywcMkRnWrQgzFItc75ar9jZ8p79+0/yDPj8psuHiRR26xZdwJiYNRG/X4EzBvsW259G6SKwv9hLiZgpgTzlW4Y2rxI/D7uCfj674JHcpj29alpu83VTLSSAVyXbVJjLZghES+bchOgFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656734; c=relaxed/simple;
	bh=dnRCccLBLvn8OaupjrqVqFoyQZf4Aosesinw3pHbUsY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Qa4CuCeu5E0Xx8vi11v8FiWLohPB/t//0HWB8YnC2D9FQOIGb/8YyngvJ8YyEEifaWjptsEncPSUosxAxtjBCLVzHITRoQIQlIbnv56LFWYhSeWAPJ2iL0q26RK8mCOvrcfYShtB/3XcV0t3pwuI4IVbOhsYYrdmb2mlC1WE688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=creativepost.co.uk; spf=pass smtp.mailfrom=creativepost.co.uk; dkim=pass (2048-bit key) header.d=creativepost.co.uk header.i=john@creativepost.co.uk header.b=2HFyl5rc; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=creativepost.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=creativepost.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=creativepost.co.uk header.i=john@creativepost.co.uk header.b="2HFyl5rc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=creativepost.co.uk;
	s=s1-ionos; t=1773656728; x=1774261528; i=john@creativepost.co.uk;
	bh=dnRCccLBLvn8OaupjrqVqFoyQZf4Aosesinw3pHbUsY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=2HFyl5rcb38TGmzIWPubLXO3xcEnp4M+U3nLpUZ3uSN147XF8469gdICBAHr48X5
	 JM+0pBH2Zy8ztm6HzlH8bXzSJ6Y/uor5GfoFDFNK+TixHkOO+A/HWK0BYdsuZ3O/w
	 LruBRQJlcZJ/tFA8foUX+hfCqnnt4xYblFGcexDmmrQm9nhlfl3b+I8hIhjHca6sX
	 U6ZrtAif2vWYWyUA5CMli3u+suF1DOqLVVM7Ak7T93064ZPgxnyDK4zG+YtJkMy1/
	 BYCgO8mMRoW2+aUJ9+uAzdBIG8KXKFXYyzRwkkURO3a8m3NOgNk3DGnCcm9aQM5qi
	 cAyUKqwH6634ugpPVA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MGxYh-1vo4Jk2wHz-0033K8 for
 <git@vger.kernel.org>; Mon, 16 Mar 2026 11:12:27 +0100
Message-ID: <457209f3-e998-4223-bdf3-57245bc51926@creativepost.co.uk>
Date: Mon, 16 Mar 2026 10:12:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: git@vger.kernel.org
From: John Emmas <john@creativepost.co.uk>
Subject: git --format anyone ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KnkQp85P7Y2zmBqIz6awrnhiMd3dlrO5MYNk1Msl07ZepqwV9+K
 2LFpNJnY1EGRIMD2pBkwseM6H5XPkKBMgKC6Xfheox6vHg8k+jiSPz52sVnwIxHmgK4GGLJ
 ++axPL8YzuB996rUfSy/igEA1L4b0V3vHNo0WOYMGvXSIZx3LSXmNsE1BLveUL4ca0Zsetb
 3gEJlq2VxwlTjwHMUOprQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vBFAgzIaqW4=;B15dO09NR69n0AS4gXu/Vex4Mee
 4S96TwKZKteiAUFQMD4NhfWv74uTGVMJ4XNegrcK2vrWFftRG1eHo3u7qbRGjKAXnG7pn9Asc
 IvOLEJLtx46R8Z/NKIFItH88t6CnJ9NZXv9ErPzdIExz7HhrJxmvQCgE3Kfw6QiUOyHOwqt74
 UYm/nDBOXhylJxL9r8L0KdGOe8ycFEa1pvXLJhgn8MdphUh/IRvXATGE6OX6/5tjFvyrZ+waw
 5Xk+UpoQpGJCBm095DaIgeX/WglxznVBcPucsaOFIw3CevHB9+VG9jf2HNr+GrCgWp/938nyZ
 vHkOBs145rRe5g4fxylEk8Q7c09iearzGd2WOOXmvLw2Q9CB1IlFZnKOQ27mh98Xe/wykGdU9
 VcFXlST3Usgq6jfcRl4A7iX4NvBlj0YREeatqMqxcJCHZOScZ+6oriCCHt8tYRT8Wc++qpRA8
 L2IeiXRdJNZeZOxhEmiNxUj6KHGfLKsdEJv/RDpZBKzHHkduW5DS37IOuwjPGtyVxqY6BxUg9
 9YNdAvF8t7XG7uTTAjAi7AuhYT2bzKl/E4SU2GXQVcW0wBpRfjYMarZAvMyzNHwzvvrBpbaNt
 AM3wLc8WmuJXIgwsDqBZwSKl1vubfkGoWHBQygw7TTy7fcS/mOLn4PMrzpxtXv4OPcA/AD09X
 3/OEAA04QV5ZuQUQ+/SNaYeRjXLo3CPv8QRvI85Y+zGwFo9LeL7zvu7NEbGSFHUFpswG8sXE+
 R2UIE23WTH/jrMv42KHAMyXoNj7gkNZzr+4aMwRkSHH0Fy1S6Fo9+n5CzBA/UkrTlQ9xRFEgJ
 sXc33vDQgWxQgrBOyEN5w7xWmXoDCWs/02KTh74XJ9LXR5YYsuZcLoh0Qx+MFcgTXRpKtldEh
 oVdX2W2ZaDCwxn1YifK5C6sMXVcEqoB9fs74WinYD8XDamrCWDLZQABBsQSapUZLHV6ds/YaA
 F97D47TegBerQXDRGXWLGsfU6OYFuiJjPHwNZpa+tWg4k14O6ZBNsKgpGWesl+ywX6nZXGXy9
 5QY0Ja/gMT3w0rR7Mal9yliiN2CeS7KN+4wwOLoLqp8b8Tlhk6QsEhei4OLNWNwZiw3rFlR37
 mTUgZ8lqWuuIU48PGTcZvOH75a6sEfoPOvIqtPsmbCrq8bPDHGLr+5UAxZLhO4WhplSuJdZXz
 dvy+enhIr/XjcPQ8IdhxfN0nwciy/5ivycnDWRdaFmjAom0WweYzJImG/iZj5+wgAr1TwD/1b
 gx7qOpEGtfIh1A8BISvbvpbvfCdmC338D/1uiarfL/uJ1NwPg9dmosQwrday+iTUBtL0gb65b
 vx3SOH6MM3a2HOOh9OzoQ4YRq5R1U/p/rJol9xrrkFQAeyIZZ/4Uj8yGeFD4VLMhAUcslVayU
 /rXxLHkQDvMSo7mBCGfuuT7rxZ9YZG3nVWWOg7TjbjKG6Sr/h02LFHAE54TcYPuAOjj+IRVyu
 RRgVtiMA+tq+R7nZxwd6XjdvivozGKh/9QQIf/0qOWmCgVD428h8bjk6zM54XgA6AC9Yd9b1a
 kqunqTcOMCOyXeJYdMXxzOQ/ZsYaJMWhiEVQl/55aA+gGA4TnuHmpJXrSuC9hTX4jCyOu+BE/
 4AOu0ZRA3HN/fodx7PRb9XIrQMQ2nWcbc0UIe7FiS9Xoywl/iuu8hIBcDRutRZaf8MY/0f7z0
 XwRgGSUfzNnvqh1FoC/ScR+IzFr5OSFLyTSRY3oAe4rN3oVOEACcJcT/pzfMLnuaNH+35SgUK
 tx9dCVg2Xq65u0RV22GDkw8D5TFOlxUxZIw+o8pFGbVXhkrMkEN/tQtJmiOppzZC0F2rcbtZV
 wzejWgpXlOS+AVb4/UA9BI2ftw==

I'm hoping this is the right mailing list (I'm using a product called=20
Git for Windows and its logo looks the same on your website!)

I'm working on a project which requires me to run "git --format" (with=20
various parameters of course). I'm currently running version 2.51.2=20
which looks fairly recent and if I simply type "git" it displays a list=20
of available options - but it doesn't deem to offer an option called=20
'format' :-(

I gather that the latest version is 2.53.0 so would it be worthwhile for=
=20
me to upgrade? i.e. would that then offer me git --format? Thanks,

John
