From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH] Implement safe_strncpy() as strlcpy() and use it more.
Date: Sun, 11 Jun 2006 19:15:40 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20060611.191540.68073375.yoshfuji@linux-ipv6.org>
References: <20060611100628.GA10430@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Sun Jun 11 12:15:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpMyB-0001cc-Fx
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 12:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWFKKO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 06:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWFKKO5
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 06:14:57 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:51218 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1750836AbWFKKO4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 06:14:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 6C5BF33CC2; Sun, 11 Jun 2006 19:15:41 +0900 (JST)
To: s022018@student.dtu.dk
In-Reply-To: <20060611100628.GA10430@bohr.gbar.dtu.dk>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21644>

In article <20060611100628.GA10430@bohr.gbar.dtu.dk> (at Sun, 11 Jun 2006 12:06:28 +0200), "Peter Eriksen" <s022018@student.dtu.dk> says:

> I've taken strlcpy() from the OpenBSD CVS without attribution.  Is this
> allowed?  If it is, how should it be stated?

Please include full copyright information.

--yoshfuji
