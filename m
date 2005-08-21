From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: Make "git-ls-files" work in subdirectories
Date: Mon, 22 Aug 2005 08:50:19 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20050822.085019.32290547.yoshfuji@linux-ipv6.org>
References: <Pine.LNX.4.58.0508211210500.3317@g5.osdl.org>
	<20050821224622.GB26241@taniwha.stupidest.org>
	<Pine.LNX.4.58.0508211613340.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: cw@f00f.org, junkio@cox.net, git@vger.kernel.org,
	yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Mon Aug 22 01:50:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6zYw-0002hh-3R
	for gcvg-git@gmane.org; Mon, 22 Aug 2005 01:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVHUXtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Aug 2005 19:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVHUXtI
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Aug 2005 19:49:08 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:5896 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751168AbVHUXtH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2005 19:49:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 9A22233CC2; Mon, 22 Aug 2005 08:50:20 +0900 (JST)
To: torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.58.0508211613340.3317@g5.osdl.org>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In article <Pine.LNX.4.58.0508211613340.3317@g5.osdl.org> (at Sun, 21 Aug 2005 16:17:52 -0700 (PDT)), Linus Torvalds <torvalds@osdl.org> says:

> getopt() is too limited, and getopt_long() is very glibc-specific and thus
> inherently evil. And the complexity of doing autoconf or similar is worse
> than just doing it by hand.

(I'm not against having our own getopt_long()
or alike, but anyway...)

Well, not really "glibc-specific" now.

NetBSD (>=1.5) has thir own implementation of getopt_long()
(w/ 4-clause BSD licence, which is not compatible w/ GPL2).
OpenBSD (>=3.3), FreeBSD (>=5.0), too.
Solaris (>=9?) seems to have one, too.

NetBSD: http://cvsweb.netbsd.org/bsdweb.cgi/src/lib/libc/stdlib/getopt_long.c
OpenBSD: http://www.openbsd.org/cgi-bin/cvsweb.cgi/src/lib/libc/stdlib/getopt_long.c
FreeBSD: http://www.freebsd.org/cgi/cvsweb.cgi/src/lib/libc/stdlib/getopt_long.c
Solaris: http://iforce.sun.com/protected/solaris10/adoptionkit/general/getopt_long.txt

--yoshfuji
