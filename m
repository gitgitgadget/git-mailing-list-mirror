From: Petr Baudis <pasky@suse.cz>
Subject: Re: still unclear on setting up a repository
Date: Sun, 27 Nov 2005 15:50:35 +0100
Message-ID: <20051127145035.GH22159@pasky.or.cz>
References: <86br0g883v.fsf@blue.stonehenge.com> <437FCC60.3090100@op5.se> <86y83k6ry0.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 15:51:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgNrF-0001bz-GD
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 15:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVK0OuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 09:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVK0OuW
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 09:50:22 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33674 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750936AbVK0OuV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 09:50:21 -0500
Received: (qmail 3875 invoked by uid 2001); 27 Nov 2005 15:50:35 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86y83k6ry0.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12810>

Dear diary, on Sun, Nov 20, 2005 at 02:14:47AM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> >>>>> "Andreas" == Andreas Ericsson <ae@op5.se> writes:
> 
> Andreas> Randal L. Schwartz wrote:
> >> And then, another "go-boom" problem:
> >> % cg-fetch
> >> Hard links don't work - using copy
> >> Fetching head...
> >> cp: illegal option -- d
> 
> 
> Andreas> I think this was resolved some weeks ago. Perhaps you could try the
> Andreas> latest cogito from git://git.kernel.org/pub/scm/cogito/cogito.git ?
> 
> I'm grabbing nearly hourly.
> 
>     localhost:~/MIRROR/cogito-GIT % cg-status
>     Heads:
>        >master      22ff47e9b3c5fc8aa2efbc5ac8690b06b868ef6f
>       R origin      22ff47e9b3c5fc8aa2efbc5ac8690b06b868ef6f
> 
> Error with this version.

Hmm, right. I changed the -d to -P, which is basically equivalent for
our situation, and -P is supposed to be POSIX. Thanks.

> Andreas> On a side-note, could you please turn off your spamvertising
> Andreas> auto-reply? It sends me some info about your perl-expertise and
> Andreas> contact-numbers every now and then. It's getting a bit annoying.
> 
> If you email me directly, you'll get that note no more than once per
> month.  Some day, I'll create a system to whitelist people that never
> want to see it again.  Damn TUIT shortage. :)

If you don't want to receive mailing list traffic related to your mails
directly, you can setup your mailer to adjust the 'mail-followup-to'
header appropriately and you should stop getting it twice.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
