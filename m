Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB851D9A48
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840578; cv=none; b=Br7mRK3aTpx6leLafWOff/dc7UnRktUznBxJLEN7fHg2mDNGRd76UeN3r7M50iBRQT8kmIUvGw7ad5aRh1OIVjTrMEeNbOmdnGFuYDskV5h9BFCJFmXX8Fkwfh7/gUMuoBNGEinMqdQLRLGE8BXrdmxp0vXA3KVa6+RYxv7Nif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840578; c=relaxed/simple;
	bh=mBmkFvuJgQ9MM94950nLcEJIO/S48JZMWu/u/AwwZTk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e3L4SKdkItgiDMx4r8r1n7kW63GZsY0Qfrl7JCaRTRDmwVcVtBMA61ZORQ53jHqWqA5qC1OeeMSLwvm7cDprodOZ4Yow0CpI6Edu+pQ8LODdrJKjrCN0zxA7GZk9Ixob2p6qzJllyPfV4IlcA/6Ed8pTfdTuNPzXe78ZTxLCQzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=fKAgwjkW; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="fKAgwjkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730840571; x=1731445371;
	i=johannes.schindelin@gmx.de;
	bh=mBmkFvuJgQ9MM94950nLcEJIO/S48JZMWu/u/AwwZTk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fKAgwjkWKtc+OMPs6tGmtGxgXSLoOmTccFUvZVTF57almmLUdDyROXwN3PjPw+kS
	 i6jzYqNPf7vuYOv6mRFv5C9yuH5S1hYhypIIu/9pfrokAlTuqUdfzswTGSHnKf8VR
	 lpjlG+T9HGE9KOSs5lzF6lhn3udaQOTdgcbUODGX8EqdV07XRzX1XWfuR8BQUxHqr
	 ibOExiNwTrRxtIH3JetHkq28KxVlCiaKsqfC0uXPjVGkl5ZgqzuiawJARZhSWooNY
	 GZpRbntqIUeJGMy6BUPrjaJgn717MSgoquWKxb7oLWJTbNbHlKTZSZXwKM/xtvs9l
	 8yCDDndjcDQwThvw+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.65]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1u2Tgt39ie-00tVw5; Tue, 05
 Nov 2024 22:02:51 +0100
Date: Tue, 5 Nov 2024 22:02:51 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Arver <linus@ucla.edu>
cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
    Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] trailer: spread usage of "trailer_block" language
In-Reply-To: <CAMo6p=Fo0gp6Vgq73E6k=Q+tV0g8EB3L_AEWq_4e85G86QUc1Q@mail.gmail.com>
Message-ID: <9ddc7555-9459-72ac-81a6-84166baf7570@gmx.de>
References: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com> <CAMo6p=Fo0gp6Vgq73E6k=Q+tV0g8EB3L_AEWq_4e85G86QUc1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BYXTjdr55gMK8vaE1KCjz3MvYpaMk7DfeC8eIgR6es2ROS1JOvD
 cnYn8BI35FUlDAcmPIkW22SPj+vQFm4dipkfcpzVXNwJ5A/5cZ8EJAsYni4Si4WpnZ562/B
 AAreXvDc6dr0Vq1rcnC8kzeMmQRLiMffB7SYXmF9yYYwh8nIE7sqCKv25N3T7zQ7HtEgDWg
 rr3mVcKXvNOkstEHZHNOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UXJGJJLukS4=;auuZz/s0Psxcq9p4gQpiS9UiHHI
 wE29+6DlOdSdwNtBPs5VCrFouTj3Ud1K/o0/8QvYnmgJAaMKbGu43e9yXRvFll6jMQcpgBELe
 66ljbLeItVhj0gTzLoB2HroP3Kdld13FtDePcRSTN6c64vAbtDR/K35K6WSxMJv6IrtFdgJGj
 9HHsWuP1eZLpFdXnV7svRmzJtkfAAPTxycJyOhfh/Ud4dVpRG3O59mIZpLtquM4W0dGQlVXej
 DCRToqKS6IiO1iap2IUXIESdjQFxypuk/VdTsoMLxxNam+wXzKhJNFhyNJCJY5LeDmCC/BpPT
 muDt4jySViihqIXNVYeRqqL9HBjtLVPabJdGAg7lEk1K2+onrrshdkg64VOgm2CmoaQIGFHuO
 +cG6eatC29bRKDSO2m4yANMqcVF8X/2xSY/7QXkLP+Wh7ngHU/hb1L7ohAyvOROhTs0/ZdMBm
 Qbl9hXP+Z2d+RIfXKV9RdqH4nG4qA7aoaM4PnMHrcqq3msUXKqM3r5/5+J6HKA+QnGCAe/rcP
 8MJ1D98y4jkxso4h8p+JvvtRzkOJtwXcz8nhtl4m9xgnllvzTYy/kjZ5DXiPlKPGJhUpSMc4y
 eMQpofb2Ays4ykXO91F0yDTe3cRemguNXynyIanekGJnG5KbIr94xTKtTO7zFdph0f+hps/y7
 CJdhLiJSSN+sDbYNnL/QCzKCw5BWnMTtdy1QT1jztdDVcuNrzzAx2aK2n+J8RthlcySoFg+KV
 sc/1Ps9IrIEPs6T73Vtm162afYLqpjvJi4GIxaEvl1xWXc0ajwl2GsPNrzBgqsT7zSpfh5S7Z
 jHy+09KEX9Jlc4ElUwSsxsaw==
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, 15 Oct 2024, Linus Arver wrote:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Linus Arver <linusa@google.com>
> >
>
> Hmm. I just noticed that GGG (?) is somehow inferring my defunct
> @google.com address. Not sure how to fix this... any tips?

This email address is apparently part of the commit object, see
https://github.com/git/git/commit/a556a5c05c44e521b572d595d5d32cc4158612c0=
.patch

(you can also see it locally if you call `git show --no-mailmap
a556a5c05c44e521b572d595d5d32cc4158612c0`, but not if you omit
`--no-mailmap`)

Ciao,
Johannes
