From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 20:36:56 +0200
Message-ID: <20050416183656.GI19099@pasky.ji.cz>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> <1113679421.28612.16.camel@tglx.tec.linutronix.de> <20050416183232.GH19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:33:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMs6b-0002zN-SG
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVDPSg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbVDPSg7
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:36:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:899 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262724AbVDPSg5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 14:36:57 -0400
Received: (qmail 3606 invoked by uid 2001); 16 Apr 2005 18:36:56 -0000
To: Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
In-Reply-To: <20050416183232.GH19099@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 08:32:32PM CEST, I got a letter
where Petr Baudis <pasky@ucw.cz> told me that...
> Dear diary, on Sat, Apr 16, 2005 at 09:23:40PM CEST, I got a letter
> where Thomas Gleixner <tglx@linutronix.de> told me that...
> > One remark on the tree blob storage format. 
> > The binary storage of the sha1sum of the refered object is a PITA for
> > scripting. 
> > Converting the ASCII -> binary for the sha1sum comparision should not
> > take much longer than the binary -> ASCII conversion for the file
> > reference. Can this be changed ?
> 
> Huh, you aren't supposed to peek into trees directly. What's wrong with
> ls-tree?

(I meant, you aren't supposed to peek into trees from scripts. Or well,
not "not supposed", but it does not make much sense when you have
ls-tree.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
