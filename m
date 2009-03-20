From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-push on packed refs via HTTP
Date: Fri, 20 Mar 2009 11:38:22 +0100
Message-ID: <49C3721E.7000005@op5.se>
References: <loom.20090320T094550-421@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steve <shrotty@gmx.ch>
X-From: git-owner@vger.kernel.org Fri Mar 20 11:40:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkc9j-0004l4-Ag
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 11:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757108AbZCTKi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 06:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760784AbZCTKi1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 06:38:27 -0400
Received: from spsmtp02oc.mail2world.com ([74.202.142.148]:1448 "EHLO
	spsmtp02oc.mail2world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760653AbZCTKi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 06:38:26 -0400
Received: from mail pickup service by spsmtp02oc.mail2world.com with Microsoft SMTPSVC;
	 Fri, 20 Mar 2009 03:36:47 -0700
auth-sender: exon@home.se
Received: from 212.112.174.166 unverified ([212.112.174.166]) by spsmtp02oc.mail2world.com with Mail2World SMTP Server; 
	Fri, 20 Mar 2009 03:36:46 -0700
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <loom.20090320T094550-421@post.gmane.org>
X-OriginalArrivalTime: 20 Mar 2009 10:36:47.0357 (UTC) FILETIME=[C53BC2D0:01C9A947]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113938>

Steve wrote:
> Hi
> 
> Using HTTP as transport, I've noticed that after using git-gc on a git server, I
> can't push to that repo anymore: "No refs in common and none specified." Client
> and server are both 1.6.2. Is ths a bug or do I have to do something after
> executing git-gc on the server?
> 

I had this happen once after having upgraded git on the server in question and
then running "git gc" against a repo. I didn't remove the old (not packed-refs
knowing) git though, and when I later tried to push to it, it couldn't find
any refs since the old receive-pack was being used, and it didn't know about
packed refs.

Worth checking, possibly.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
