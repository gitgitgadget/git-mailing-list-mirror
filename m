From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Wed, 15 Feb 2006 02:14:25 +0100
Message-ID: <20060215011425.GM31278@pasky.or.cz>
References: <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz> <43F2745D.4010800@vilain.net> <20060215003510.GA25715@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 15 02:13:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9BEk-0000dD-TO
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 02:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422907AbWBOBNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 20:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422908AbWBOBNk
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 20:13:40 -0500
Received: from w241.dkm.cz ([62.24.88.241]:21633 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422907AbWBOBNj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 20:13:39 -0500
Received: (qmail 20960 invoked by uid 2001); 15 Feb 2006 02:14:25 +0100
To: Sam Vilain <sam@vilain.net>, Chuck Lever <cel@citi.umich.edu>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060215003510.GA25715@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16200>

Dear diary, on Wed, Feb 15, 2006 at 01:35:10AM CET, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> Publishing a repository with a stg (or pg) patch series isn't
> a problem; the problem is that no clients currently know how to
> follow along with the remote repository's patch series.  And I can't
> think of a sensible behavior for doing so that isn't what git-core is
> already doing today for non patch series type clients (as in don't go
> backwards by popping but instead by pushing a negative delta).  :-)

New Cogito will automagically do the right thing if you are just
fast-forwarding and you are using cg-update - if the branch rebased, it
will happily follow (but cg-fetch + cg-merge will NOT and it will fall
back to the tree merge).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
