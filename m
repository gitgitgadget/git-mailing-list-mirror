From: "Michael Johnson" <redbeard@mdjohnson.us>
Subject: Re: Segfault on merge with 1.6.2.1
Date: Wed, 01 Apr 2009 00:43:38 -0500
Message-ID: <op.uro0u0xuso3nzr@sulidor.mdjohnson.us>
References: <op.urifmtkkso3nzr@sulidor.mdjohnson.us>
 <20090329121700.GN22446@genesis.frugalware.org>
 <op.urk20nanso3nzr@sulidor.mdjohnson.us>
 <20090330110335.GF22446@genesis.frugalware.org>
 <op.urnad7jbso3nzr@sulidor.mdjohnson.us>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 01 07:45:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LotGa-0001Gq-5H
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 07:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbZDAFnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 01:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbZDAFnv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 01:43:51 -0400
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:45936 "EHLO
	looneymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751597AbZDAFnu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 01:43:50 -0400
Received: from sulidor.mdjohnson.us (216.49.248-IP-55.ckt.net [216.49.248.55])
	by looneymail-a2.g.dreamhost.com (Postfix) with ESMTP id 9E3FB16D206;
	Tue, 31 Mar 2009 22:43:46 -0700 (PDT)
In-Reply-To: <op.urnad7jbso3nzr@sulidor.mdjohnson.us>
User-Agent: Opera Mail/9.64 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115338>

On Tue, 31 Mar 2009 02:14:21 -0500, Michael Johnson  
<redbeard@mdjohnson.us> wrote:

> That said, here's my backtrace. I've tried tracing through to figure out  
> where the problem is occurring, but my gdb-foo is non-existent, I'm  
> wating for some GUIs to install, and I'm ready for some sleep :| So if I  
> haven't heard back by tomorrow evening, I'll be running one of the  
> frontends for gdb until I have something traced down :)

I tried tracing it manually with KDbg tonight. But either I'm too tired  
(and my patience is low), or I'm just not capable of understanding it. I  
hope it's the former, since I was able to follow the basic flow well  
enough. But I still wasn't terribly happy with the front end. It's obvious  
that gdb is awesome, I'm just not ready for it yet :)

Anyway, I decided to try an experiment, as I had mentioned to someone that  
if I couldn't get this bug tracked down, I'd have to do the merge  
manually. So... I figured out the common ancestor (I used git show-branch,  
but I'm betting there's an easier way), and merged the ancestor + 1 of the  
other branch into my HEAD. It segfaulted. So, I tried the resolve strategy  
at the same point. Amazingly, it worked. And a default recursive merge  
handled the rest.

That means my current problem is resolved, but I'm guessing a segfault on  
a default merge is still a bad thing, so I'll try to keep up on this. I do  
have a copy of the repository before the merge (several, right now,  
actually), so I can try fixes. If I'm lucky I'll have some time to work on  
it myself. But it will be at least two weeks before I actually have the  
time to personally track down the problem without help. However, I should  
be able to assist someone else fairly easily.

In short, I don't personally need a fix right now, but I can help figure  
out what is broken with it.

Thanks,
Michael

-- 
Michael D Johnson   <redbeard@mdjohnson.us>    
redbeardcreator.deviantart.com

"Marketing research...[has] shown that energy weapons that make sounds sell
  better..." - Kevin Siembieda (Rifts Game Master Guide, pg 111)
