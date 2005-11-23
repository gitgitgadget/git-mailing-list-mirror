From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: pack-redundant.c:689: warning: long unsigned int format,
 size_t arg (arg 3)
Date: Wed, 23 Nov 2005 09:49:59 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20051123.094959.53535561.yoshfuji@linux-ipv6.org>
References: <118833cc0511221734r33b20f6au97fe2e93243f5ccf@mail.gmail.com>
	<4383CA08.4080604@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: mwelinder@gmail.com, git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Wed Nov 23 02:51:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EejlS-0000AW-BB
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 02:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVKWBtf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 20:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVKWBtf
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 20:49:35 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:10767 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S965085AbVKWBte
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 20:49:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 1B54133CC2; Wed, 23 Nov 2005 09:50:00 +0900 (JST)
To: hpa@zytor.com
In-Reply-To: <4383CA08.4080604@zytor.com>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12596>

In article <4383CA08.4080604@zytor.com> (at Tue, 22 Nov 2005 17:46:48 -0800), "H. Peter Anvin" <hpa@zytor.com> says:

> Morten Welinder wrote:
> > Maybe cast the size to unsigned long to make it match the format.
> > 
> > M.
> > 
> > pack-redundant.c: In function `main':
> > pack-redundant.c:689: warning: long unsigned int format, size_t arg (arg 3)
> 
> Or use %zu for the format.

It is not widely supported, I think.

--yoshfuji
