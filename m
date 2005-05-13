From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Stop git-rev-list at sha1 match
Date: Fri, 13 May 2005 07:26:33 +0200
Message-ID: <20050513052633.GA16464@pasky.ji.cz>
References: <1115839456.22180.79.camel@tglx> <7vy8alr0mz.fsf@assigned-by-dhcp.cox.net> <1115843429.22180.90.camel@tglx> <7vis1pqvi4.fsf@assigned-by-dhcp.cox.net> <20050511221719.GH22686@pasky.ji.cz> <1115851742.22180.154.camel@tglx> <20050511225058.GK22686@pasky.ji.cz> <1115852914.22180.170.camel@tglx> <20050511234455.GL22686@pasky.ji.cz> <1115857873.22180.253.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 07:19:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWSZY-00005b-Rg
	for gcvg-git@gmane.org; Fri, 13 May 2005 07:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVEMF0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 01:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVEMF0j
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 01:26:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63204 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262236AbVEMF0h (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 01:26:37 -0400
Received: (qmail 16789 invoked by uid 2001); 13 May 2005 05:26:33 -0000
To: Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
In-Reply-To: <1115857873.22180.253.camel@tglx>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 02:31:13AM CEST, I got a letter
where Thomas Gleixner <tglx@linutronix.de> told me that...
> On Thu, 2005-05-12 at 01:44 +0200, Petr Baudis wrote:
> > for extensive discussion on how (it is impossible or very hard) to do
> > better.
> 
> :)
> 
> > So how would you order the list of commits?
> 
> Rn
>   merged Mn
>   merged Mn-1
> Rn-1
> ....
> 
> That's the relevant information in repository R. Looking at it from
> repository M after M updated to Rn
> 
> (Mn+1) == Rn	; Mn+1 is not created due to head forward
>   merged Rn
>   .. 
>   merged Rn-3
> Mn
> Mn-1
> 
> Thats the historical correct ordering from a repository point of view.
> Thats the only relevant information IMNSHO.

But it is impossible to reconstruct without the repoid or something. So
my point that it makes no sense and is actually dangerous with the
current rev-list output order holds.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
