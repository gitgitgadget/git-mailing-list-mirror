From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: baffled again
Date: Fri, 26 Aug 2005 15:50:39 -0400
Message-ID: <200508261950.j7QJodQX024981@laptop11.inf.utfsm.cl>
References: <tony.luck@gmail.com>
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, tony.luck@intel.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 21:53:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8kFJ-00077Y-Hk
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 21:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVHZTwK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 15:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbVHZTwK
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 15:52:10 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26275 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030242AbVHZTwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 15:52:09 -0400
Received: from laptop11.inf.utfsm.cl (fw.inf.utfsm.cl [200.1.19.2])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id j7QJoeq1010663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Aug 2005 15:50:40 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j7QJodQX024981;
	Fri, 26 Aug 2005 15:50:39 -0400
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: Message from Tony Luck <tony.luck@gmail.com> 
   of "Wed, 24 Aug 2005 22:58:23 MST." <12c511ca05082422584e6b1bfb@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 26 Aug 2005 15:50:41 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7823>

Tony Luck <tony.luck@gmail.com> wrote:
> >  * Even if it does always choose the nicer choice of the two,
> >    Tony was lucky (no pun intended).  Rather, we were lucky that
> >    Tony was observant.  A careless merger may well have easily
> >    missed this mismerge (from the human point of view).

> Actually I can't take credit here. This was a case of the "many-eyes" of
> open source working at its finest ... someone e-mailed me and told me
> that I should have backed out the old patch before applying the new one.
> While typing the e-mail to say that I already had in the release branch,
> I found the problem that it had been "lost" in the merge into the test
> branch.

> But this is a good reminder that merging is not a precise science, and
> there is more than one plausible merge in many situations ... and while
> GIT will pick the one that you want far more often than not, there is
> the possibility that it will surprise you.  Maybe there should be a note
> to this effect in the tutorial.  Git is not magic, nor is it imbued with
> DWIM technology.

I have to disagree. If in some corner case it can do the wrong thing, no
amount of "I told you so in the docu!" will save the day. People /will/
overlook it, or be bitten when they have all but forgotten about it.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
