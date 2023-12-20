Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2421C47A7F
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="E2pOJREF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703092697; x=1703697497; i=l.s.r@web.de;
	bh=xJ17LjDmmejy/0qYod2GQkr8x1m94pf+9wwxAEZFajw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=E2pOJREFgyl7r/4wDwwK71JMHAtISlqngoMJZHX+QwlnY+f0Am38N+ls0e7ZXrdX
	 BX/mpodk4lXeSRDCFr2JI6ANNW5AvSFdya55FH7Tc3oVGs9A9CCqSdjXDYaGiWla4
	 3GiLRMTytEdzaqjmrdg2e2CyFoVNJYJmpXIa7B52DGMRF7HSjRgr2T2XmOtAYRJ2d
	 9FHq9H9SgTTRsAbSRzg+AlLosgdTC30bkzllO6RPY2hszL5ih1vs1V0ZsFRSjP5i3
	 +9us6Yo0UHBHUL0oyT5GNv1K2K55ey6VflHueDB3yY4g0uWBCEVAx/7+bFLxXXp7T
	 H2QnbPOOtNzBf2G0ew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.9]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav6f-1qiKHa34ZP-00cKis; Wed, 20
 Dec 2023 18:18:17 +0100
Message-ID: <32270c4f-7ab8-48ea-bd07-455581b4a8af@web.de>
Date: Wed, 20 Dec 2023 18:18:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/git-merge.txt: fix reference to synopsys
Content-Language: en-US
To: Elijah Newren <newren@gmail.com>
Cc: Michael Lohmann <mial.lohmann@gmail.com>, git@vger.kernel.org,
 Michael Lohmann <mi.al.lohmann@gmail.com>
References: <20231220070528.8049-1-mi.al.lohmann@gmail.com>
 <c6814a39-b4f9-4b1e-b81b-45ffe4aa7466@web.de>
 <CABPp-BHBncDqCSvGm6Ow2D2+JQLf_3htwnxZ-RWV+tsxiH1rhg@mail.gmail.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CABPp-BHBncDqCSvGm6Ow2D2+JQLf_3htwnxZ-RWV+tsxiH1rhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rgl7MmyWjcc5TdWwYea4OlW+rjs/CsKARnbYmY8en06StmivpWI
 TLFH/UM5cZ8ViUMOMqD+mgHnjE1M04T/KRboZqcRqVrHubrkROdSP0tjbzwjBI8oVHWbeDZ
 WIlejrWsWK/q9WYspoiuND8mMPLaeqvhetTBzYtD504yOXXl5183M8XGOtA1Zr5cIyXV7lS
 WCEBwKhvcn/4HvKedGxkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dTqlRX78lYQ=;DuCcNNzBziMrFa0vEU6EuXmRDOd
 ILg5097Sb6lCDZFtPYK52HUF81S0888dSKVvnG3tgt2G69Z84DJje1j9QTisySImbzfw7MuTF
 aTpNq+9CP5etY5HxfEYOggQZhtYmwnosAZzb3jSqdpMHOZerSFoLv8b3N2sHX+EzSBwulMHJ+
 ntT6ltMSksBAihliKChzUgCr9QVHIp3yHpKJ8FtsJeTcgZnfQObMfIVc5FOxI9MXEVtI7+NVM
 tnBxTLwq/GtoOLvG4SS+0WRWXvm4rmqCk7681wfHEWIRbX9IwxUjo9HFLOEj6Ruy61uexEFi/
 UGHagqn9AQuOdSjqEIIUukFclD9RxccTGWB4JIjqrCWQDVBONNm0cQnNQWqJqTMIAjUeiqcnd
 J+rBuWM55IW0h167MbVX6AS/Rff+Jtwxj0hvZa0I9jvPmMLvRO2V+B5a4lfSwef7otyti/v2y
 IG0ouafLXOkyY//S6YqxnDTdqz8GvuvdhM5Y4HOMSs8VAdgicbc9NBFWop8Z37Ybt4e/uhsgP
 nY9QpLAJNokhB9uOwbbRkl6+RQevK9GTu8SuYVXfhPcX2xQj8v8aNOe/s2s2tJ3FLiLD6H2MJ
 KUMW5YUgtsjO2k2xfpPLPIZWNDvntmNIBLNm+qk/i5/jqYGKVDo9uKkC3NpMkXMWGwGanwpJL
 uhpb1iV+KlA6Pm0YJZmmaey27eZn9ofCCU8YnlNnOrn26RjwNXN7sbmmkmPX4DMLT3bwHYL4N
 wQethSeY5gRp25A5nmyoNHOh9TBpLZWpdS0bYOgEqLzKEJ1EGT1Q1dQq3lvXPKT2EXsVKNJN7
 4xUFUNBJbeTjfQc7cFhNzHH4O28oXxMKiY2Cq23NDIya7l5D6/umOVD8u8/TrUDvF3YO7qiFq
 RERjksPFqakVis9loVpkmhLiezQTF9Thf6SAkjQjeTOs0vjCM+PNwDFqoY/qgnpNNMZTsE/vy
 1CG99g==

Am 20.12.23 um 17:29 schrieb Elijah Newren:
>
> On Wed, Dec 20, 2023 at 7:46=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de>=
 wrote:
>>
>> Am 20.12.23 um 08:05 schrieb Michael Lohmann:
>>
>>> +It is possible that a merge failure will prevent this process from be=
ing
>>> +completely automatic. "`git merge --continue`" and "`git merge --abor=
t`"
>>               ^^^^^^^^^
>>               automatically
>
> Do you perhaps mean "completed automatically" (i.e. change both of the
> last two words in that sentence, and not just the last one)?

Possibly.  This looks like a case of me making a mistake while criticizing
someone else's grammar, though.  Which happens almost every time. o_O

Ren=C3=A9
