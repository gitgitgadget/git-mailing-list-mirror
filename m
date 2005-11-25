From: Petr Baudis <pasky@suse.cz>
Subject: Re: files are disappearing in git
Date: Fri, 25 Nov 2005 20:39:32 +0100
Message-ID: <20051125193932.GY10680@pasky.or.cz>
References: <20051123142303.GJ22568@schottelius.org> <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org> <43866EDA.9050203@michonline.com> <20051125103048.GB30691@schottelius.org> <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>,
	Ryan Anderson <ryan@michonline.com>,
	Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 20:39:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfjPr-000560-IT
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 20:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbVKYTjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 14:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVKYTjY
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 14:39:24 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43920 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751463AbVKYTjX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 14:39:23 -0500
Received: (qmail 15570 invoked by uid 2001); 25 Nov 2005 20:39:32 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12747>

Dear diary, on Fri, Nov 25, 2005 at 08:12:00PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> The problem is a bad merge. And in fact, that merge lost _more_ than just 
> the three files under Code/Spikes/Statistik/, it also lost a file called 
> Code/lw1/Client/Pics/icon/lw1-icon.png.
> 
> I don't quite see _how_ it lost them. The merge in question is a totally 
> trivial in-index merge, and when I re-do it, I don't lose those files. In 
> this case, all the lost files were from the "other branch" of the merge, 
> and they were new to that branch. IOW, in git-merge-one-file parlance, it 
> is that trivial "added in one" case.
> 
> Pasky - do you know of any historical cogito problems like this?

Puzzling. In the past, cg-merge might get confused by merging on top of
tree with some uncommitted changes (either deleting them, or possibly
intermixing them with the merge - not sure about the latter now), but a
quick scan of Cogito changes over the last few months shows no other
bugs, and I can't remember any major bugfixes besides this either.

Any idea what Cogito version (roughly) could have been used to perform
the merge, Nico?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
