From: Adrian Bunk <bunk@stusta.de>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 21:19:09 +0100
Message-ID: <20060110201909.GB3911@stusta.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de> <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932574AbWAJUT1@vger.kernel.org Tue Jan 10 21:20:42 2006
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932574AbWAJUT1@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwPyc-0007WE-8p
	for glk-linux-kernel-3@gmane.org; Tue, 10 Jan 2006 21:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWAJUT1 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 10 Jan 2006 15:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWAJUT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:19:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932574AbWAJUTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:19:12 -0500
Received: (qmail 9286 invoked from network); 10 Jan 2006 20:19:10 -0000
Received: from r063144.stusta.swh.mhn.de (10.150.63.144)
  by mailout.stusta.mhn.de with SMTP; 10 Jan 2006 20:19:10 -0000
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 6E0C519736C; Tue, 10 Jan 2006 21:19:10 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14446>

On Sun, Jan 08, 2006 at 07:26:50PM -0800, Linus Torvalds wrote:
>...
> THIS is what "rebase" is for. It sounds like what you really want to do is 
> not have a development branch at all, but you just want to track my tree 
> and then keep track of a few branches of your own. In other words, you 
> don't really have a "real" branch - you've got an odd collection of 
> patches that you really want to carry around on top of _my_ branch. No?

Yes.

> Now, in this model, you're not really using git as a distributed system. 
> In this model, you're using git to track somebody elses tree, and track a 
> few patches on top of it, and then "git rebase" is a way to move the base 
> that you're tracking your patches against forwards..

I am using the workaround of carrying the patches in a mail folder, 
applying them in a batch, and not pulling from your tree between 
applying a batch of patches and you pulling from my tree.

> It's also entirely possible that you may want to look at "stacked git"
> (stg), which is really more about a "quilt on top of git" approach. Which
> again, may or may not suit your needs better.
>...

After a quick look, stg seems to be an interesting project that might 
suit my needs.

I'd say the main problem is that git with several other projects like 
cogito and stg on top of it allow many different workflows. But finding 
the one that suits one's needs without doing something in a wrong way
is non-trivial.

It might help if someone could write some kind of "Git for dummies" that 
focusses only on the usage and advantages/disadvantages of user 
interfaces like cogito, stg and (H)GCT and restricts the discussion of 
git internals to a short paragraph in the introduction.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
