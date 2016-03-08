From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Tue, 8 Mar 2016 13:30:21 +0100
Message-ID: <56DEC5DD.2070407@web.de>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com>
 <56D97C8C.1060205@web.de> <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com>
 <56D9D8C6.2060104@ramsayjones.plus.com>
 <8C785DB2-CEDB-435B-945B-00E4D98DBF99@fournova.com> <56DD41D5.60100@web.de>
 <5C6A30EF-ED0A-4D64-B971-CF873C64B46E@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Alexander Rinass <alex@fournova.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 13:30:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adGmZ-0003gR-11
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 13:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbcCHMab convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2016 07:30:31 -0500
Received: from mout.web.de ([212.227.17.12]:53730 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbcCHMa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 07:30:28 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M2MUi-1ZlA5a2EAm-00s7pf; Tue, 08 Mar 2016 13:30:22
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.6.0
In-Reply-To: <5C6A30EF-ED0A-4D64-B971-CF873C64B46E@fournova.com>
X-Provags-ID: V03:K0:EfwUI328/ZbWEwwkntaUOYUYppzPDCQJJxnk5p28DyXyJ+Jy8aP
 DUCvpsRmxh3syemeeVxvafSbcVtSiw7DkTuj6wEeAgzyzw6JGWtXs+VvP60uwLDCN0Qjqg2
 hCsH2bjgAjKtvsvT22yIT0v9/WcklVPYo9srm5Es+lyivQsGyzdnaPvCKEk0MznbKH4IfYa
 Uwl37JJRu27SZfZuMFZXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RAZRgDfhOF8=:lfVAcs440GaZZEKSoAz2OI
 JhAERj7Ul8rQaogAHPRMufDql2D4eNUbhYVsloeHitcBK1pfx/zsjYJjBNMe3AiZcC+kdHhnT
 PNSlEQA591Sim/7Ze7z4SQ1oAPghD+iuCIr4U0lA8sm1AVDr8M+qDAf373Q/dsZLC4dto4FOC
 uoxn3rHxrOkTu6vY3vL45SzcJELRsjDRkOg2nITzReWr7BdkZV0mswk8le4VzZBqRJo6NePM/
 56WMzsgulS2q5xs4YJPQT1IVga/S++qOOXftO6VPVxfn2todfExA70FgkzaYDhLZ18IbepTa/
 Uwwahk2ubASeObDlbUJ1q9h8WWwM4k3sKBSZlmP/LB2qyFlXrO79X3bj/49elD3LIsQNAytlr
 hOwM+QZTEIY+sr2fqMSbAsCqeU/0nbWeu+VZTo3A6AKp4+TE2O9HsgcT8yRo5BS7m7zuUnfGi
 vMWrp4uqNMrdlKtjr+wlU+BwiEENYzYChfYtJHvtXKy4aTAWTZv4C99CilIORXljSLEph9vip
 2V92XoUlcq07R69K/Dpsl+StTksrLUE9Ojz8D6HSK0uIXwGDZaZnRKzGUUZtwvHWtoVEfddFM
 wIYjY7XxNtkYKGJiCtQg/M78pZrDz2uRE1t8Ijsx+Vl3GxrpYU/kTCKBAOGtASzszLjRCy+wc
 GXc6VAKfc+Qlq0PygG9JPETpHb2aq/WuqRARJtbjI3uLoG3T3Nn3NJKXrk8CrTojdUVIZbYsY
 KRq7iWnsExcnmkckerW++Cb50UjppheaKhT94ER2kpXvLPyEGWAHKfneEpPTiOrBAj9n3Fs+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288430>

>> And if not, I can put it on my TODO-stack.
> I have read through the official contribution guidelines and I think =
I can
> send an official patch.
>
> In this case, would you prefer to have a single commit since the chan=
ge
> is related? Or would you prefer keeping it in separate commits, since
> they are different commands and I can use commit subjects like =E2=80=
=9Cdiff:=E2=80=9D
> and =E2=80=9Cdiff-index:=E2=80=9D, etc.?
>
Thanks for the work.
The same issue fixed at different places:
I personally would prefer a single commit.

Another thing is, if we want to add TC in t3910,
to avoid future regressions.
(Otherwise I can help with those)
