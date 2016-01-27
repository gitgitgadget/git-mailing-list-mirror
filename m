From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] t0027: Add tests for get_stream_filter()
Date: Wed, 27 Jan 2016 10:05:17 +0100
Message-ID: <56A8884D.3060605@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>	<1453622143-22038-1-git-send-email-tboegi@web.de> <xmqqio2fa5uc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Wed Jan 27 10:07:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOM3c-0003Ak-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 10:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbcA0JFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 04:05:48 -0500
Received: from mout.web.de ([212.227.15.14]:53710 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbcA0JFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 04:05:45 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M8QeQ-1aBejt02iY-00vydl; Wed, 27 Jan 2016 10:05:27
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <xmqqio2fa5uc.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:jnbiHOrBWTx2qFTMbOvn4dn5D9C1n/Sx9XzU7GXerMTVZpic7gp
 TMeo2v8XMCxoTXPo42j/P7rlY9pjg6P4RS1l6Mr95ZKKgGpL9TaKRsj7fmmIxkWZNHdJg5l
 hAQQo9DqW8V51RwagKI1P2FBRFZBuxtJkEW7z0eQfJql11xq2BgHUeCBVYI6/pY77RDFuY+
 6lhxVBoeK931sOh4LNEUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fmnO9JLoG20=:6lfR/TmiGFrM14ucl98ehZ
 z6xH6weneObzwPmfSwdgji7Tz0Nqe23lT/5puaYRn8V4LX2HG0UQUzFEy/ITTBW8bWeNeLu9d
 On8NoRDKGXHiGcRwYK267pCJqgvzeRv558Vkjw9iIScLqAUsRdmj4RK7pPYYAgg41avH+qR3r
 FVIbfYmdLoPcjdWJ48AGezBJcJP/Hdgs0z8Agr0CbDyU457Gw/YJ9Ozr593pahf3pdkvHuV2X
 2E2/qG9hiHp08l9QG90jgaGuDq3g/bP8RZZ45SKxAsfYxdZ49ocEQNH4814qExqBj2E8xPJVh
 5TRnYrNDS433BchZA/FqsYR+iOSApsoBtOoAy4hKXkRBRPTBhDN3MdrTRnXnylzBN24uoxKk5
 c5LflfQAnLZs/0hWErc1VIaELUeYA5gFx6OZNADwFUTa/yo1mcWugyWNs6FOm3zozuLURXbbH
 FrmoroDeCo5cmpLRHwQ96VJ6vlhZQDHBIXUrpg01BBYMC29Kl4GAEmg+XHt4EDkaKthwVNb1Z
 qVfPSBzFPARFkoNn0Yc/E9pQDuCWSEhWBJbV8zCfRLekU1vQ+1aU2K3trMoPm+ajPF+UyYDdS
 MKaVEv3k+WoeR7vmh7Hqz9t6RUPIF+Q4Niymb3r99Fei94PsSQdIQzsHK/PE7f7zQKNG2N+K3
 Rv+0Co1ahCuZlMNfEkpspYhPNyL/2qt2pUVWHYuA/H3lejlIS+0N7iBhud4EGLSdbshjRJ6th
 90gbAZuy6KaxTo0j8Sv+taroYfZAmBvNMPDoY77H2dkvwT4l0EtpoDxPOh5ndFfk3hgPjeDN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284898>


- This needs to go on top of  tb/ls-files-eol

> With missing "separate commit", I am having a hard time to decide if
> this is something I should pick up at this moment, or I should wait
> until that separate commit materializes.  What is your intention?
>
I send a serious including this patch the next days.
If there are more review comments, they are welcome.
