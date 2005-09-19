From: Pavel Roskin <proski@gnu.org>
Subject: Re: Joining cg-*-id
Date: Mon, 19 Sep 2005 18:30:21 -0400
Message-ID: <1127169021.26772.58.camel@dv>
References: <1127166049.26772.26.camel@dv>
	 <20050919215608.GA13845@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:31:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHU9c-00019j-Ee
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 00:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbVISWaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 18:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbVISWaZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 18:30:25 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:8666 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932713AbVISWaZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 18:30:25 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EHU9X-0002Ey-Lz
	for git@vger.kernel.org; Mon, 19 Sep 2005 18:30:23 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EHU9V-0000kK-8d; Mon, 19 Sep 2005 18:30:21 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050919215608.GA13845@pasky.or.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8917>

Hello, Petr!

Thanks for quick replies.  I'm replying to both your messages.

On Mon, 2005-09-19 at 23:56 +0200, Petr Baudis wrote:
> Dear diary, on Mon, Sep 19, 2005 at 11:40:49PM CEST, I got a letter
> where Pavel Roskin <proski@gnu.org> told me that...
> > Hello!
> 
> Hello,
> 
> > I believe Cogito should keep the command list short.  When the *-id
> > utilities got the cg-prefix, the list became longer by 3 commands.
> 
> well, those commands are semi-public, actually. E.g. cg-help does not
> list them.

But cg-<TAB><TAB> does.

> > What if we join cg-commit-id, cg-parent-id and cg-tree-id into one cg-id
> > (or cg-admin-id) utility?  It would work like cg-commit-id in absence of
> > switches, -p would make it work like cg-parent-id, and -t would make it
> > cg-tree-id.
> 
> Perhaps cg-object-id? I'm not principially opposed to that, but I don't
> see much value in it either. Perhaps if this would come along with
> the usage of git-rev-parse (see below)...

The value is having one command, one manpage and one place to fix little
bugs and add more functionality.  Potentially, cg-Xnormid could be
incorporated into that script, so bash wouldn't have to open one more
file.

> > Alternatively, this functionality should go to git.  It's low-level
> > enough to be there.
> 
> There is git-rev-parse, but it is not as powerful (cannot take dates and
> sha1 completion does not work when listing parents) - OTOH it can
> complete sha1 ids even inside packs, which is really useful. Still, IMHO
> its usage is awful, so it'd take place for cg-Xnormid, but we would
> still keep the *-id frontends (which would also handle the dates).

I see.  I guess time for git is just as abstract as phases of the moon -
nobody would goes crazy when they repeat.

Please don't apply my patch yet - I forgot to document the optional
argument.  I'll try to make cg-object-id now.

-- 
Regards,
Pavel Roskin
