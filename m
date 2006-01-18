From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 18:05:37 +0100
Message-ID: <20060118170536.GS28365@pasky.or.cz>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz> <20060118140917.GA15438@mythryan2.michonline.com> <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Mathias Waack <Mathias.Waack@rantzau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:07:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzGjv-0007PH-8n
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWARRE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 12:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWARRE2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:04:28 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43676 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751363AbWARRE1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 12:04:27 -0500
Received: (qmail 13579 invoked by uid 2001); 18 Jan 2006 18:05:37 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601180813170.3240@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14839>

Dear diary, on Wed, Jan 18, 2006 at 05:23:03PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Wed, 18 Jan 2006, Ryan Anderson wrote:
> > merging with the old repositories should, at least theoretically, work, 
> > etc.
> 
> No. This - and the history rewriting - both have a fundamental problem: it 
> becomes totally impossible to merge back any changes of the subprojects, 
> at least automatically. The renaming just ends up making pretty much any 
> merge a manual affair (git can _help_, but it's going to be a matter of 
> luck if it works or not - and it usually won't work very well, because 
> you'll probably end up having files that have the same name in the new and 
> the old repo, and eventually you'll just have tons of confusion).

Well, the recursive merge strategy is at least advertised to be able to
merge across renames (as long as they are autodetected). Not that I
would have any practical experiences with it and I don't know how smart
is it done (if it just runs rename detection between the merge base and
current head, yes, that might not give very good results in this case).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
