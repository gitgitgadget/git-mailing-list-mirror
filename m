Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2D91F744
	for <e@80x24.org>; Tue, 21 Jun 2016 07:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbcFUHql (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 03:46:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:55969 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932811AbcFUHqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 03:46:40 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MY75A-1atAzj0YSW-00Uto5; Tue, 21 Jun 2016 09:38:27
 +0200
Date:	Tue, 21 Jun 2016 09:38:25 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/7] log-tree: respect diffopt's configured output
 file stream
In-Reply-To: <alpine.DEB.2.20.1606210920510.22630@virtualbox>
Message-ID: <alpine.DEB.2.20.1606210937440.22630@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de> <babf95df5f610feb6c2ae7f2ed3cff98bab47fe2.1466420060.git.johannes.schindelin@gmx.de> <xmqqwplju74a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1606210920510.22630@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qFYwiFjacJDsniZuC6YXaB28kdW5a+HkDOFAUR70VzuCW2XmQEU
 dz5tBzCUr7rIrvsmTHSfl3SjKorKSyeNU/J31/N/w19IkcspNqt8wSwQknz6hiE8bRxFaRI
 zGXSrc6yaImjtiNS+pFqwIxaPapLe9KkZ5LiVFifrImmYEEySUNJwjv8GFCfusWZonezKwn
 KGtz9MpLEhFpjDI2DcftA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:OtqqjcBYZlY=:bc7Jw2As1kYHGOGJO8LEDB
 UBdcpEK/qE1VyMsvfxBeuQLx1AlSxeD8Yfe920VV/6MVYOXQyLd3b/1AmyhPUHlIa8Mz5Nqi4
 Pn0l5LX5qzWjzY17O7/gFf1KxUXxF3ueWg2Vj7TeAun1Fd5oyl0DdjyAo+MnkjHhvjfW/Y6XD
 GRUMVZVepNEwi68FBFMLS6OjySkjh51MWWVn8YbV/PsFqVIEkmvqEBZEmnARTk84VH20LZPGc
 35y5QWU/kAxB4Mb2IQZACxRG2sryq78TRovpuDKHweqfjHnoJhSk8jo4Lf8RuFsoRVHilMGla
 A02KbjUWT8UquBKByDs/evEmHme5zZiJ8rCUzv3DAlpmdPrdgc3Nyemul/GFZylRmnaP8YbEm
 0vShN2GNv8muiwxdBigO06DkK7JqLLB3iDCjN2kLItyBTe74gK8AAG+J8bEv11ST2oW7USUTO
 GjRWgQ2y23LqSPgb1sE4eJSBoWWL2QqyvGPwkzeGxY+u3+WD8HLJ4h6yWXu115PhXhyrqdulW
 zHFt+v8Me2mXlo/rePg0kupD02aJQM0hl9bit4tn5GX3WHwyAxWN6U3PDJoTvcU8Rz3H60Tj4
 oDVdoV8XNgB0ViY3CgQ+wiEUqpzm5m3Aqx7z52/ZhBtkITlgfjxsSiZu4Fs2q6UsW6vWM4LeH
 thN+BQUJnrWbwI9xQAEy0vsJEVmVwRLyRJmyBtMuBzXq1eZeLYEH8dVMOL9KX4EPfKvKtMrNs
 nIdIWvr+haWilhvjETwjGX0FSrL7qnjyMkJ3l26Uv9YHXYTvslhMUgZIbrcAT8VdJnPXS0dN8
 YL+2un5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Tue, 21 Jun 2016, Johannes Schindelin wrote:

> Expect v3 in a moment.

I am sorry. The regression test suite just sounded red alert. So: do not
expect v3 in a moment, but later today.

Ciao,
Dscho
