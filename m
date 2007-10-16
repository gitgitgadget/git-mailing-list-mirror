From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH] tail -n not supported in all OSs
Date: Wed, 17 Oct 2007 02:16:06 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20071017.021606.45991429.yoshfuji@linux-ipv6.org>
References: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
To: jari.aalto@cante.net
X-From: git-owner@vger.kernel.org Tue Oct 16 19:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihq1k-0002jk-G4
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759825AbXJPRQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759111AbXJPRQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:16:09 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:34469 "EHLO
	yue.st-paulia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758845AbXJPRQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:16:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP id CE21A33B46;
	Wed, 17 Oct 2007 02:16:07 +0900 (JST)
In-Reply-To: <1192553837-18302-1-git-send-email-jari.aalto@cante.net>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61222>

In article <1192553837-18302-1-git-send-email-jari.aalto@cante.net> (at Tue, 16 Oct 2007 19:57:14 +0300), Jari Aalto <jari.aalto@cante.net> says:

> 
> SunOS/Solaris tail(1) does not support option '-n'. The
> following patches change occurrances of:
> 
>    tail -n <N>
> 
> to
> 
>    tail <N>

You should say "tail -<N>".

--yoshfuji
