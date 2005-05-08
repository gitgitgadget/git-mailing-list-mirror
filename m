From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Sun, 8 May 2005 19:51:56 +0200
Message-ID: <20050508175156.GA9495@pasky.ji.cz>
References: <1115564550.9031.96.camel@pegasus> <20050508152529.GU9495@pasky.ji.cz> <1115566990.9031.108.camel@pegasus> <20050508155656.GV9495@pasky.ji.cz> <1115568937.9031.129.camel@pegasus> <20050508171209.GX9495@pasky.ji.cz> <1115572667.9031.139.camel@pegasus> <20050508173003.GY9495@pasky.ji.cz> <1115574035.9031.145.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 19:45:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUppo-0000pX-Bp
	for gcvg-git@gmane.org; Sun, 08 May 2005 19:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVEHRv7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 13:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVEHRv7
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 13:51:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33242 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262914AbVEHRv6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 13:51:58 -0400
Received: (qmail 7291 invoked by uid 2001); 8 May 2005 17:51:56 -0000
To: Marcel Holtmann <marcel@holtmann.org>
Content-Disposition: inline
In-Reply-To: <1115574035.9031.145.camel@pegasus>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 07:40:34PM CEST, I got a letter
where Marcel Holtmann <marcel@holtmann.org> told me that...
> > > Sometime you don't have any other choice, because diff is not perfect.
> > > Do you wanna apply that patch or should I change the mktemp templates
> > > first?
> > 
> > It looks like it'll be most painless when I just reinvent parts of your
> > patch here locally and you can send me patches on top of that.
> 
> it is your choice. I can change that if you like. My latest version
> should apply cleanly against your current tree.

I've pushed my changes, please have a look at them. I think I've got
everything important, but I might've forgot something.

> If you want the extra newline(s) then it is a good idea to add something
> that strips heading and trailing empty lines from the final commit
> message, because otherwise it will be ugly if you don't enter extra text
> for the merge.

Isn't that what I initially suggested? :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
