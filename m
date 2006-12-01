X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Fri, 01 Dec 2006 09:44:03 +0100
Message-ID: <456FEB53.7080703@op5.se>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>	<87ejrlvn7r.wl%cworth@cworth.org>	<7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>	<7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611291859070.3513@woody.osdl.org>	<456EBBE7.8030404@op5.se>	<Pine.LNX.4.64.0611300749560.3513@woody.osdl.org>	<20061130164046.GB17715@thunk.org>	<Pine.LNX.4.64.0611300903080.3513@woody.osdl.org>	<Pine.LNX.4.64.0611301229290.9647@xanadu.home>	<87irgwu6e6.wl%cworth@cworth.org>	<ekn8s3$lh6$1@sea.gmane.org> <87fyc0u56z.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 08:44:22 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <87fyc0u56z.wl%cworth@cworth.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32873>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq40H-0002Xe-Sz for gcvg-git@gmane.org; Fri, 01 Dec
 2006 09:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967556AbWLAIoO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 03:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967558AbWLAIoO
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 03:44:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:8071 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S967556AbWLAIoM (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 03:44:12 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id D81E36BCC3; Fri,  1 Dec 2006 09:44:06 +0100 (CET)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth wrote:
> 
> See? Git _is_ harder to learn, and a user really cannot learn it
> without being careful about the index right from the very beginning.
> 

I'm not so sure about that. I came from CVS / SVN, although I've fiddled 
quite a bit with other scm's as well. The two-step commit process of git 
didn't terrify me at all, and I had used git at least a month before I 
joined the mailing-list and found out that there's this thing called an 
"index". I knew about it before, since back then (June or July 2005) 
there was only git-update-index to mark things to commit. I just didn't 
worry about it but expected the scm to tell me if I was about to break 
something horribly (which it often but not always did).

I think the main thing people are having difficulties with when it comes 
to git is that it doesn't do things like other SCM's do it. Imo this is 
a good thing, because it allows git to be more powerful than other 
SCM's. Otoh it forces users migrating from 
darcs/hg/monotone/perforce/whatever to git actually read the 
documentation (and quite a lot of it), while hg -> bzr migrators use 
pretty much the same commands for pretty much the same actions. This 
makes users accustomed to not reading docs / trying things out before 
attempting Real Work(tm), which breaks down horribly when user 
expectations doesn't match reality. The simplest and usually most 
effective solution is to meet the users half-way, and tell them early on 
that this power comes at the cost of having to read the documentation 
and do the tutorials.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
