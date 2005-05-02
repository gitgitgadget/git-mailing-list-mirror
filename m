From: Petr Baudis <pasky@ucw.cz>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Tue, 3 May 2005 01:17:43 +0200
Message-ID: <20050502231743.GL20818@pasky.ji.cz>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org> <20050429172235.21c1af10.pj@sgi.com> <Pine.LNX.4.58.0504291956030.2296@ppc970.osdl.org> <20050429232922.03057aba.pj@sgi.com> <20050430110410.GA25322@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Jackson <pj@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 01:15:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSk55-0002Z1-6r
	for gcvg-git@gmane.org; Tue, 03 May 2005 01:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVEBXR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 19:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVEBXR6
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 19:17:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42676 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261213AbVEBXRq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 19:17:46 -0400
Received: (qmail 26244 invoked by uid 2001); 2 May 2005 23:17:43 -0000
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Content-Disposition: inline
In-Reply-To: <20050430110410.GA25322@lsrfire.ath.cx>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 30, 2005 at 01:04:10PM CEST, I got a letter
where Rene Scharfe <rene.scharfe@lsrfire.ath.cx> told me that...
> On Fri, Apr 29, 2005 at 11:29:22PM -0700, Paul Jackson wrote:
> > Linus replied to pj:
> > > > Code Sample 2:
> > > > ...
> > > Didn't change anything for me. Same thing.
> > 
> > I don't believe you did what I did.
> > 
> > The source code for bash, both 2.x and 3.x versions, clearly displays a
> > simpler error message (no line number or redisplay of your script
> > commands) in the case that you set a trap.  And I tested both shells on
> > a multiprocessor, to verify that they behaved as I expected, running
> > these silly little scripts.
> 
> I don't have a multiprocessor and I see the same.  Are you sure it's SMP
> dependant?
> 
> Your solution (trapping _inside_ the job, too) works for me, btw.  Here's
> a patch for cg-log that reduces the clutter to two "Broken pipe" lines
> (pun not intended).

Could you elaborate on how exactly is it supposed to help? I see
identical behaviour with the traps and without them (UP, bash-2.05b).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
