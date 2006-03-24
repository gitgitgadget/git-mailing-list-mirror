From: Andreas Ericsson <ae@op5.se>
Subject: Re: missing git features
Date: Fri, 24 Mar 2006 19:55:22 +0100
Message-ID: <4424409A.80503@op5.se>
References: <20060322133337.GU20746@lug-owl.de>	<Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>	<Pine.LNX.4.64.0603221607580.26286@g5.osdl.org>	<44223B90.3040500@zytor.com>	<1143128751.6850.35.camel@neko.keithp.com>	<Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>	<BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE>	<Pine.LNX.4.64.0603231134160.26286@g5.osdl.org>	<20060324123238.GA3070@linux-mips.org>	<4423ED16.9080504@op5.se> <871wwrztaz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 19:55:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMrRc-0007mL-AX
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 19:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWCXSz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 13:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbWCXSz0
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 13:55:26 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:16360 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932441AbWCXSzY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 13:55:24 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5E4046BD08; Fri, 24 Mar 2006 19:55:23 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <871wwrztaz.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17936>

Carl Worth wrote:
> On Fri, 24 Mar 2006 13:59:02 +0100, Andreas Ericsson wrote:
> 
>>See how Junio does with next and pu and recommend your users to do the 
>>same. There's no way of pulling a rebased branch, because the rebasing 
>>destroys ancestry information, meaning the original commits other people 
>>have cease to exist in your repository.
> 
> 
> But the "other people" still have those commits, so it should be
> rather straightforward for a tool to also perform a rebase for them
> when doing this kind of "rebased pull".


Yes they do, but you don't, so their tip won't match yours, meaning 
their git will try a merge, which will fail since lots of commits are 
already applied. Perhaps it would be possible to try the blobs against 
each other, if anyone's interested.


> I think there's just a single
> arc of data missing showing where a rebased commit object came from.
> 
> So this sounds solvable, and it is something I would very much enjoy
> having, (call me funny, but I prefer to rebase and avoid a merge
> commit when looking at independent lines of development for which
> logically there shouldn't be any "merge" required).
> 

For the cases where no merge is required you could rebase several 
branches on top of one and simply publish that one. If that's the case, 
git would need the ability to know what branches are exported and which 
arne't, which should be a lot simpler than implementing a rebased-merge 
strategy.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
