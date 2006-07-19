From: Petr Baudis <pasky@suse.cz>
Subject: Re: Tracking CVS
Date: Wed, 19 Jul 2006 14:38:09 +0200
Message-ID: <20060719123808.GH13776@pasky.or.cz>
References: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com> <20060622135831.GB21864@pasky.or.cz> <9e4733910606220717of2ba299ta8a38c7d63fd5635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 19 14:38:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3BJl-0004fn-Gm
	for gcvg-git@gmane.org; Wed, 19 Jul 2006 14:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWGSMiN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 08:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWGSMiN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 08:38:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51399 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964800AbWGSMiM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 08:38:12 -0400
Received: (qmail 19659 invoked by uid 2001); 19 Jul 2006 14:38:09 +0200
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910606220717of2ba299ta8a38c7d63fd5635@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24002>

Dear diary, on Thu, Jun 22, 2006 at 04:17:15PM CEST, I got a letter
where Jon Smirl <jonsmirl@gmail.com> said that...
> On 6/22/06, Petr Baudis <pasky@suse.cz> wrote:
> >Dear diary, on Thu, Jun 22, 2006 at 02:41:16PM CEST, I got a letter
> >where Jon Smirl <jonsmirl@gmail.com> said that...
> >> I'm tracking cvs using this sequence.
> >>
> >> cvs update
> >> cg rm -a
> >> cg commit
> >> cg add -r .
> >> cg commit
> >>
> >> Is there a way to avoid the two commits? If you do the add with out
> >> the intervening commit it just adds the files back.
> 
> How about a cg-sync? Tracking cvs (or other SCM) with git is probably
> a common activitiy while you try to convince the other CVS users to
> switch. It is probably worth a little write up in the readme on the
> best way to do it.

I have added and pushed out support for cg-add -a, now it should be
merely a matter of

	cg-rm -a && cg-add -a

and I have documented that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
