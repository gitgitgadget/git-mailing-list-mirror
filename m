From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 13:55:49 -0400
Message-ID: <20070905135549.b5k3etn94wos4g4o@intranet.digizenstudio.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<69b0c0350709050947k5e32ba7fj38924a0968569d9a@mail.gmail.com>
	<87ir6pc9n1.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 8BIT
Cc: Govind Salinas <govindsalinas@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 19:56:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISz6j-0005YF-Aq
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 19:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbXIERz7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 13:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbXIERz7
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 13:55:59 -0400
Received: from k2smtpout04-01.prod.mesa1.secureserver.net ([64.202.189.166]:48618
	"HELO k2smtpout04-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753014AbXIERz6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 13:55:58 -0400
Received: (qmail 24704 invoked from network); 5 Sep 2007 17:55:57 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout04-01.prod.mesa1.secureserver.net (64.202.189.166) with ESMTP; 05 Sep 2007 17:55:57 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id C62641000A2;
	Wed,  5 Sep 2007 17:55:57 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g53u2zkuwaxD; Wed,  5 Sep 2007 13:55:57 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id 62843100A18; Wed,  5 Sep 2007 13:55:49 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Wed, 05 Sep 2007 13:55:49 -0400
In-Reply-To: <87ir6pc9n1.wl%cworth@cworth.org>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57731>


Quoting Carl Worth <cworth@cworth.org>:

> I don't think the warning message alone is a good fix. I think the
> people who would understand the warning and appreciate that they could
> then take care of repacking as convenient are the same people that
> already understand the repacking concept, and are likely already
> repacking occasionally, (so would likely never see the warning).
>
> But the problematic case is the user who knows nothing of the
> issue. And in that case, giving this warning isn't useful education,
> it's just forcing the user to learn more and do more work. "If git
> notices it has too many 'loose object' and 'git gc' would fix the
> problem, then why didn't it do that itself? And what the heck is a
> 'loose object' anyway?"

(my 2 cents as another ordinary new git user)
Hmm, not necessarily. That a system knows what the best action is  
doesn't meant that _right now_ is the best time to take that action.   
One subtle difference I think between git's gc and Java/python/etc.'s  
gc is that in the latter case it is, at least metaphorically, a life  
and death situation - if gc isn't run, the application will run out of  
memory, where as in git, it's more of a performance degradation issue,  
which, sort of, can wait.

On the issue of implementation awareness, a warning message saying  
something along the lines of "your repository is getting slower. You  
might want to consider running 'git gc', and remember to do that from  
time to time." is not much different from "your file system is getting  
slower. You might want to consider running <whatever-defrag-tool>, and  
remember to do that from time to time."

Neither these messages nor the actions they propose _require_ users to  
learn what "repacking", "loose object", or "file fragments" are about  
before they can proceed.

Cheers.
-- 
Jing Xue
