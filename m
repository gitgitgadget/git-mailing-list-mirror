From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 00:58:38 +0200
Message-ID: <20050919225838.GH18320@pasky.or.cz>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz> <1127169021.26772.58.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:59:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHUb5-00081f-Ic
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 00:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVISW6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVISW6l
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 18:58:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14553 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750715AbVISW6k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 18:58:40 -0400
Received: (qmail 30226 invoked by uid 2001); 20 Sep 2005 00:58:38 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1127169021.26772.58.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8921>

Dear diary, on Tue, Sep 20, 2005 at 12:30:21AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> On Mon, 2005-09-19 at 23:56 +0200, Petr Baudis wrote:
> > Dear diary, on Mon, Sep 19, 2005 at 11:40:49PM CEST, I got a letter
> > where Pavel Roskin <proski@gnu.org> told me that...
> > > I believe Cogito should keep the command list short.  When the *-id
> > > utilities got the cg-prefix, the list became longer by 3 commands.
> > 
> > well, those commands are semi-public, actually. E.g. cg-help does not
> > list them.
> 
> But cg-<TAB><TAB> does.

Good point.

> > > What if we join cg-commit-id, cg-parent-id and cg-tree-id into one cg-id
> > > (or cg-admin-id) utility?  It would work like cg-commit-id in absence of
> > > switches, -p would make it work like cg-parent-id, and -t would make it
> > > cg-tree-id.
> > 
> > Perhaps cg-object-id? I'm not principially opposed to that, but I don't
> > see much value in it either. Perhaps if this would come along with
> > the usage of git-rev-parse (see below)...
> 
> The value is having one command, one manpage and one place to fix little
> bugs and add more functionality.  Potentially, cg-Xnormid could be
> incorporated into that script, so bash wouldn't have to open one more
> file.

Well, cg-Xnormid is basically pointless if it's not going to be a common
backend for multiple other commands. So I'd say either supersede it with
git-rev-parse or just merge it with cg-object-id.

> Please don't apply my patch yet - I forgot to document the optional
> argument.  I'll try to make cg-object-id now.

Which patch?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
