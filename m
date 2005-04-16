From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Add "clone" support to lntree
Date: Sun, 17 Apr 2005 01:00:00 +0200
Message-ID: <20050416230000.GN19099@pasky.ji.cz>
References: <20050416024755.GX7417@pasky.ji.cz> <Pine.LNX.4.21.0504152251300.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 00:56:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwDH-0001dc-2p
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVDPXAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVDPXAI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:00:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44422 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261183AbVDPXAB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:00:01 -0400
Received: (qmail 11330 invoked by uid 2001); 16 Apr 2005 23:00:00 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504152251300.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 05:06:54AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Sat, 16 Apr 2005, Petr Baudis wrote:
> > I'm sorry but you are late, I added it about a hour and half ago or so.
> > :-) Check git fork. (I *want* separate command than git lntree. In fact,
> > I think I should make git lntree gitXlntree.sh instead, since it is
> > really internal command for git-tools and the user should probably never
> > need it for anything. git lntree is too lowlevel.)
> 
> Have you not pushed since? I don't see it.

See my last mail. :-)

> I think "fork" is as good as anything for describing the operation. I had
> thought about "clone" because it seemed to fill the role that "bk
> clone" had (although I never used BK, so I'm not sure). It doesn't seem
> useful to me to try cloning multiple remote repositories, since you'd get
> a copy of anything common from each; you just want to suck everything into
> the same .git/objects and split off working directories.

Actually, what about if git pull outside of repository did what git
clone does now? I'd kinda like clone instead of fork too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
