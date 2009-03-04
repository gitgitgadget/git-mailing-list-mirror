From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Wed, 04 Mar 2009 11:53:14 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903041151440.8926@perkele.intern.softwolves.pp.se>
References: <450196A1AAAE4B42A00A8B27A59278E709F076D2@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Leol0-0004HN-2w
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 11:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbZCDKxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 05:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbZCDKxy
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 05:53:54 -0500
Received: from smtp.getmail.no ([84.208.20.33]:57528 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbZCDKxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 05:53:54 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KFZ0082NA9SB400@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 11:53:52 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFZ000ZSA8TXPB0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 11:53:17 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KFZ005LEA8TZ130@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 04 Mar 2009 11:53:17 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 43791189B20; Wed,
 04 Mar 2009 11:53:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 40C091A97FE; Wed, 04 Mar 2009 11:53:14 +0100 (CET)
In-reply-to: <450196A1AAAE4B42A00A8B27A59278E709F076D2@EXCHANGE.trad.tradestation.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112204>

John Dlugosz:

> Actually, UTF-8 is a valid code page on Windows.

Yes, but I am unsure whether it can be set as a thread locale for the sake 
of file APIs.

> Also, there is a national code page that =will= represent all file names 
> on the systems and is supported: That is the Chinese GB18030, code page 
> 54936.

Yeah, but unfortunately it is explicitly documented that it is only 
supported in MultiByteToWideChar, WideCharToMultiByte and some text painting 
APIs in Windows, i.e the stdio functions and others may break horribly.

-- 
\\// Peter - http://www.softwolves.pp.se/
