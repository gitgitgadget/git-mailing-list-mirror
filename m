From: Andreas Ericsson <ae@op5.se>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 12:52:06 +0200
Message-ID: <47134656.4070707@op5.se>
References: <20071014221446.GC2776@steel.home>	<023101c80eb5$e3b6b310$2e08a8c0@CAM.ARTIMI.COM> <20071015000347.GA13033@old.davidb.org> <E1IhJ7T-0008AC-8b@fencepost.gnu.org> <47133DEC.6020600@op5.se> <4713431C.7030103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eli Zaretskii <eliz@gnu.org>, David Brown <git@davidb.org>,
	dave.korn@artimi.com, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org, make-w32@gnu.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 12:52:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhNYj-0006sp-Sc
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 12:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757893AbXJOKwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 06:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757068AbXJOKwM
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 06:52:12 -0400
Received: from mail.op5.se ([193.201.96.20]:57213 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756363AbXJOKwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 06:52:10 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E2D24173070E;
	Mon, 15 Oct 2007 12:52:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.43
X-Spam-Level: 
X-Spam-Status: No, score=-2.43 tagged_above=-10 required=6.6 tests=[AWL=0.069,
	BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HHBojHskMrQd; Mon, 15 Oct 2007 12:52:08 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 9F289173070B;
	Mon, 15 Oct 2007 12:52:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <4713431C.7030103@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60980>

Johannes Sixt wrote:
> Andreas Ericsson schrieb:
>> Eli Zaretskii wrote:
>>>
>>>> If you know what the library on the other end is doing to re-parse the
>>>> arguments back into separate strings, it might be possible to quote 
>>>> things
>>>> enough to handle names with spaces, but it is hard.
>>>
>>> It's not hard, it's just a bit of work.  And it needs to be done
>>> exactly once.
>>
>> Before someone beats me to it: "Patches welcome" ;-)
> 
> Let others do the research for you, hm?
> 
> http://repo.or.cz/w/git/mingw.git?a=blob;f=compat/mingw.c;h=2554f19765da5709b787e873da225c59f9d22bb7;hb=HEAD#l306 
> 

Yup. Although it was more in the nature of "whoever wrote it surely knows
he/she did it and where to find the patch", so I expect this wasn't much
of a timesink for you. My apologies if I was incorrect.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
