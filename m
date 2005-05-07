From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] git-tar-tree: Lift path length limit
Date: Sat, 7 May 2005 14:09:35 +0200
Message-ID: <20050507120935.GB9495@pasky.ji.cz>
References: <20050507002527.GA5082@lsrfire.ath.cx> <20050507005706.GA6093@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 14:02:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUO1C-0004co-5m
	for gcvg-git@gmane.org; Sat, 07 May 2005 14:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbVEGMJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 08:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbVEGMJk
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 08:09:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:32187 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S263059AbVEGMJg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2005 08:09:36 -0400
Received: (qmail 7192 invoked by uid 2001); 7 May 2005 12:09:35 -0000
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Content-Disposition: inline
In-Reply-To: <20050507005706.GA6093@lsrfire.ath.cx>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 07, 2005 at 02:57:06AM CEST, I got a letter
where Rene Scharfe <rene.scharfe@lsrfire.ath.cx> told me that...
> On Sat, May 07, 2005 at 02:25:27AM +0200, Rene Scharfe wrote:
> > Last minute patch?
> 
> This leaks memory.  D'oh!
> 
> Petr, would you add the (hopefully) fixed version below to your tree now
> that Linus is on vacation?  (Patch applies to tip of GIT tree.)

It appears to me that the patch currently in the git tree is this
(correct) one?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
