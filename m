From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Tue, 14 Feb 2006 23:29:13 +0100
Message-ID: <20060214222913.GK31278@pasky.or.cz>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 23:28:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F98es-00019I-KU
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 23:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422833AbWBNW21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 17:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWBNW21
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 17:28:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:22947 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422833AbWBNW20 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 17:28:26 -0500
Received: (qmail 20788 invoked by uid 2001); 14 Feb 2006 23:29:14 +0100
To: Chuck Lever <cel@citi.umich.edu>
Content-Disposition: inline
In-Reply-To: <43F2445A.6020109@citi.umich.edu>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16186>

Dear diary, on Tue, Feb 14, 2006 at 09:58:02PM CET, I got a letter
where Chuck Lever <cel@citi.umich.edu> said that...
> my impression of git is that you don't change stuff that's already 
> committed.  you revert changes by applying a new commit that backs out 
> the original changes.  i'm speculating, but i suspect that's why there's 
> a "stg pick --reverse" and not a "stg uncommit."

It is ok as long as you know what are you doing - if you don't push out
the commits you've just "undid" (or work on a public accessible
repository in the first place, but I think that's kind of rare these
days; quick survey - does anyone reading these lines do that?), there's
nothing wrong on it, and it gives you nice flexibility.

For example, to import bunch of patches (I guess that's the original
intention behind this) you just run git-am on them and then stg uncommit
all of the newly added commits.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
