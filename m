Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95932192B89
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712378; cv=none; b=IQrF9Noo5W1jQZetFLbHmmcWJBqLnt4YwRlrKeR4egxI4ECgYhwNgtltRNsQBBYwIYZDzAlOPn7NJCmlKiSH5XU5LJBF09QI5Os1WMW64ejNpDE0XK73kJzYDSiN1Rvk88A4pxs3z83ZE5SGiRy36WnqKuxptNfJT0f/4TP1g6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712378; c=relaxed/simple;
	bh=Fb8O+KIA4QZkMg0BFGtouM6PcY8V7jage7Hio3NwJxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kJsz95gVaSQ/++HAx5cyyjpKQa0WYldTYIiI7J9MG2u7ulrB6PBheOcg6ioluB6+ls0Lgn1LvaVUl4kV/Wkdhtn/XptauGtiwLoIFfHLSxEC87L/0VowlK8NDreXtGfkSAOsM4YiikK99oKdbqj9+7mU9sRjSO6QRLOiYF9iI6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=jihHWWg8; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="jihHWWg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727712368; x=1728317168;
	i=johannes.schindelin@gmx.de;
	bh=Fb8O+KIA4QZkMg0BFGtouM6PcY8V7jage7Hio3NwJxc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jihHWWg8Gfg1LUK6iZHZ6JO7pquMJO+H1lEvOtAukNclTQIyOzwcBIogIWtA9DEd
	 f7YyixJ+lwfddk1dLooDFXNAAw0yC9WOFnpK9wQkzKuI1MY1G6X0POvdyUVYhl7qY
	 xYhKBebqE1fRzPLFyHXHvDNBQvUjsLhM/JK9JOTcxYn68KGWVKEDv1dl8mihvXwzM
	 An8g2uCyI78ySoe4CKvsx8dVxnho8qXrU7kXz9Xfm714OzrCBwbYoyNjtfrYJRk9t
	 WBJAgzEDcExwspr2mLky3X67NtCjjBuvPmbTaRSrZaVfmyqrjCZx1HLpALoPHl4Ip
	 4J7A+ajzrYnvmwDyYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([91.13.166.221]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1sn5R02uow-00ERbG; Mon, 30
 Sep 2024 18:06:08 +0200
Date: Mon, 30 Sep 2024 18:06:08 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Mr. Manuel" <mr-manuel@outlook.it>
cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: AW: Push to GitHub HTTP repo fails (>v2.45.2)
In-Reply-To: <PA4PR02MB70407ADD7FB88A87D6B965AE8C762@PA4PR02MB7040.eurprd02.prod.outlook.com>
Message-ID: <6e7d2f78-8375-270a-c6b5-a8535515c9f7@gmx.de>
References: <PA4PR02MB7040A36E17B197AB8DD7BBFC8C612@PA4PR02MB7040.eurprd02.prod.outlook.com> <a6dd718c-807a-c19b-b915-e6cc455256af@gmx.de> <PA4PR02MB70407ADD7FB88A87D6B965AE8C762@PA4PR02MB7040.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EkA/o8HgoNLCUKwEGNq2WlpjjrHMDV9M0TzWeJLoC2bEBAr8hds
 JJxK3eOkLLTyVIwkyJVoKMEzqa+Y9zGdE4CRD1of9tDJVkHIrCYNoGJl+/QDw4JBDRVXMIS
 Jr1pPuV7AokCZ/Z76UphtF0rdbrbuwGY9SEelmkHp3wuc6Ck6gM5ShDDqrirbltDzFfABUy
 7l9AgZBnV+UouRvFl1OhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FQu7oVme/So=;w77aWjvBdm5scu5q+i0yse1CMUx
 bHe7JC+EcTWkBQ6ztVCIL05DKaHEiwpTq2LvC24tYvc4IZ0PImyb9Ioii3OX0oxmmExU1eV2j
 ubryW4Ki7xYRfNc9qy7hu295h3V0gHaAGwjDEldrvFC/Kn7TellaLrPltxagcaxyidIbGaBGi
 pApzpqtOSM4AIT8CAK1AOikMcyMyg4xxy8KZZilsuEXLCPfe0Dm1bDrwET9GIA+wd5zHgtpnP
 lFQvf16L/YPFLe6pUJoddK4Mb7n0qC6jWYXC5G7QQBevHe3hVirn6U6w33c7bJE+b+pdtS53g
 WweARW8HS/0XcZFny6iYymmTvOPShAHfMk7OdlgFONAcOxO/yLtCjWmyQ7OVliPeYHQ/3fobW
 sVNz/MV7hKU3rhDWnLV4Fseshcx7YPZGUXs2k4xF7SnSdsl2ROzR7RYik/sYX620orevM3jHO
 gxaQQp5zsJgfUZLYVtu2716pct4LjyItkh0YjyhLDvbfMfU8qz+bx52ORbjCzC8iL3vyUdYrJ
 BCt82YnhGvijkV3E7qAPMJi+kN2Yj/mst1up1MjadqanFYQEKCZzeJysy5hMiEw8v3GMvZ3oj
 u2vJUNU86qsMSsZJoT5iBmpr6skfNjtna8eGw7z8gcSy5U4OsISdCpn3QmoFkRUOdjSUIQKvJ
 RO2y/NhF9qFwhgBb8EAmPiIqFAapjo485LronITKWMSMiS8Em1MnWfPiRwQhouM1EFOzip35f
 Eo94b9tuvxKM90EhI/UOVnS5kkHH1a+yhCZ5i02nuWiH0T8Hgk08mT5WWfXhEeozEdkAwYTbL
 5sGnUJ3B0FnKq26kephyQplA==

Hi Manuel,

On Mon, 30 Sep 2024, Mr. Manuel wrote:

> thank you very much for your answer. I installed v2.47.0-rc0.windows.1
> and now everything works as expected. I have no special setup, no proxy,
> no VPN, everything default.

Excellent! Thank you for confirming.

Ciao,
Johannes
