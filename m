From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-update (cogito-0.13) bug: changed heads
Date: Wed, 7 Sep 2005 01:17:56 +0200
Message-ID: <20050906231756.GC26934@pasky.ji.cz>
References: <431E03A5.6060709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 07 01:19:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECmhX-0000jT-80
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 01:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVIFXR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 19:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbVIFXR7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 19:17:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41116 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S1751029AbVIFXR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2005 19:17:58 -0400
Received: (qmail 8245 invoked by uid 2001); 6 Sep 2005 23:17:56 -0000
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <431E03A5.6060709@zytor.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8155>

Dear diary, on Tue, Sep 06, 2005 at 11:01:25PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> I just found a bug in cogito-0.13, at least to the best of my 
> understanding of the situation.
> 
> Simplified, the problem looks like this: two sides, A and B, pull from 
> repository C.  The head of this pull we call 0.
> 
> Now commit 1 is added to A.  B pulls commit 1 from A, not though C. 
> Later, A pushes commit 1 to C.
> 
> Next time B tries to pull from C, cg-update will not advance 
> refs/heads/origin, even though C now has a new head.  Thus, B will think 
> that C is in a different state than it actually is.

So, C surely has its head updated? Does cg-update "fail" silently, or
does it utter anything?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
