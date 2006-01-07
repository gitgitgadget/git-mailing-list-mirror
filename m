From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 07 Jan 2006 02:33:27 -0600 (CST)
Organization: USAGI/WIDE Project
Message-ID: <20060107.023327.18175855.yoshfuji@linux-ipv6.org>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>
	<20060107.021614.94523887.yoshfuji@linux-ipv6.org>
	<20060107.002904.87767885.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 09:32:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev9VJ-0006ZH-T5
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 09:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWAGIco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWAGIco
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 03:32:44 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:24076 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1030357AbWAGIco
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 03:32:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id 790A033CC2; Sat,  7 Jan 2006 17:33:32 +0900 (JST)
To: davem@davemloft.net
In-Reply-To: <20060107.002904.87767885.davem@davemloft.net>
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14243>

In article <20060107.002904.87767885.davem@davemloft.net> (at Sat, 07 Jan 2006 00:29:04 -0800 (PST)), "David S. Miller" <davem@davemloft.net> says:

> >  	name->commit = commit;
> > +	name->path = sizeof(*name);
> >  	name->prio = prio; 

> Why are you assigning an integer to a pointer? :-)
> Probably you meant something like:
> 
> 	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
> 
> 	...
> 	name->path = xmalloc(len);
> 	...

oops.... you're right...

--yoshfuji @ about to fly
