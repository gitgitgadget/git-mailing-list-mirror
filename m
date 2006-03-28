From: Petr Baudis <pasky@suse.cz>
Subject: Re: git pull fails
Date: Wed, 29 Mar 2006 00:48:07 +0200
Message-ID: <20060328224807.GC27689@pasky.or.cz>
References: <20060328162831.af1bd4c0.tihirvon@gmail.com> <20060328141140.GC3113@linux-mips.org> <20060328173827.3d64d91e.tihirvon@gmail.com> <200603281700.17233.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Timo Hirvonen <tihirvon@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>
X-From: git-owner@vger.kernel.org Wed Mar 29 00:48:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOMyu-0007Vf-6Y
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 00:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWC1WsE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 17:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWC1WsE
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 17:48:04 -0500
Received: from w241.dkm.cz ([62.24.88.241]:62617 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932483AbWC1WsD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Mar 2006 17:48:03 -0500
Received: (qmail 24658 invoked by uid 2001); 29 Mar 2006 00:48:07 +0200
To: Radoslaw Szkodzinski <astralstorm@o2.pl>
Content-Disposition: inline
In-Reply-To: <200603281700.17233.astralstorm@o2.pl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18134>

Dear diary, on Tue, Mar 28, 2006 at 05:00:11PM CEST, I got a letter
where Radoslaw Szkodzinski <astralstorm@o2.pl> said that...
> On Tuesday 28 March 2006 16:38, Timo Hirvonen wrote yet:
> > Thanks, but forcing everyone to edit their git/remotes/origin file
> > is not very nice solution.  I think git-fetch should update refs for the
> > other non-'broken' branches and leave "pu" and "next" refs untouched.
> 
> How do you know a non-broken branch from something weird?

If I understand it right, Timo complains that git-fetch got
non-fastforward commits for "pu" and "next" and a good fastforward
commit for "master", but it didn't update the ref for ANY head, not even
the "master".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
