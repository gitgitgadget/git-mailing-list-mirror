From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 1/1] add, rm + status patches
Date: Tue, 19 Apr 2005 00:41:14 +0200
Message-ID: <20050418224114.GL5554@pasky.ji.cz>
References: <42641AE4.9050700@dgreaves.com> <20050418204814.GF5554@pasky.ji.cz> <4264321F.2050107@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 00:37:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNerr-000212-07
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDRWlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDRWlW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:41:22 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13488 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261170AbVDRWlP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 18:41:15 -0400
Received: (qmail 16194 invoked by uid 2001); 18 Apr 2005 22:41:14 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4264321F.2050107@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 12:18:07AM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Petr Baudis wrote:
> 
> > Thanks. Could you please send the patches signed off and either with
> > content-disposition: inline or in the mail body?
> Is this OK.
> Thunderbird isn't the best for attaching patches.

Yes. The patch you inserted is useless, whitespaces are mangled away.

> > I think it would be cleaner to do the testing for the dash in the for
> > loop, so that I can do git add foo bar -. Also, don't forget to
> > update git add's documentation at the top. For the usage string, I'd
> > probably prefer (-|FILE)...
> >
> > thanks,
> 
> Here you are:
> * git add and git rm now take (-|FILE)...
> * noted some bugs to be fixed
> * introduced de-dupe code into add and rm
> * git status reports added/removed files (although there are extra entries)
> * README, git and command docs updated
> 
> I realise as I write this that I should have split these patches up - I 
> will do so next time.

Well, I didn't ask you to split the patch the first time since it was
quite trivial for me to do, but this is too much. ;-)

> Has a decision been reached to _not_ code the cogito part of the git 
> suite in perl?
> 
> I ask because the code in git status is getting pretty ugly.
> I'd be happy to help with a preliminary port to perl.

I'm fine with Perl. I chose shell for the very initial implementation since
it actually was simplest, but now, I wouldn't have anything against Perl
if it makes is simpler. (And as long as your Perl is nice. I'm harsh
reviewer. ;-)

> Index: gitadd.sh
> ===================================================================
> --- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/gitadd.sh (mode:100755 
> sha1:3ed93ea0fcb995673ba9ee1982e0e7abdbe35982)
> +++ cd5cd7a9272ce1966aca3bfce15f703e33cafc04/gitadd.sh (mode:100755 
> sha1:a3e83ac52abd5a9cdc6abd560f95b2f19646fd99)
> \ No newline at end of file

Note this. Something is wrong with your text editor, too.

Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
