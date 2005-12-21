From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH] GIT: Support [address] in URLs
Date: Thu, 22 Dec 2005 07:20:45 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20051222.072045.31468866.yoshfuji@linux-ipv6.org>
References: <20051221.192342.132228413.yoshfuji@linux-ipv6.org>
	<7vr7866uww.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Wed Dec 21 23:20:46 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpCJy-000315-41
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 23:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVLUWU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 17:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVLUWU1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 17:20:27 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:8968 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S964824AbVLUWU0
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 17:20:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id CF47F33CC2; Thu, 22 Dec 2005 07:20:53 +0900 (JST)
To: junkio@cox.net
In-Reply-To: <7vr7866uww.fsf@assigned-by-dhcp.cox.net>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13907>

In article <7vr7866uww.fsf@assigned-by-dhcp.cox.net> (at Wed, 21 Dec 2005 12:45:51 -0800), Junio C Hamano <junkio@cox.net> says:

> That is, how does one do something like this, with an ipv6
> literal address?
> 
> 	telnet 127.0.0.1 80
> 
> Is it done like this
> 
> 	telnet '[::1]' 80
> 
> or
> 	telnet '::1' 80
> 
> Your patch suggests the former, but I just wanted to make sure.

In this case (telnet), we do the latter.
But, we definitely do
        scp file1 file2 ... '[3ffe:ffff:...:1]:/tmp/'
like
        scp file1 file2 ... remote.example.com:/tmp/

Hope this helps.

--yoshfuji
