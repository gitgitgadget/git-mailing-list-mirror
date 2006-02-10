From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Fri, 10 Feb 2006 22:17:40 +0100
Message-ID: <20060210211740.GO31278@pasky.or.cz>
References: <20060210195914.GA1350@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 10 22:17:18 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fdl-00036A-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWBJVRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWBJVRO
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:17:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:45704 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751023AbWBJVRN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 16:17:13 -0500
Received: (qmail 12050 invoked by uid 2001); 10 Feb 2006 22:17:40 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060210195914.GA1350@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15886>

  Hi,

Dear diary, on Fri, Feb 10, 2006 at 08:59:14PM CET, I got a letter
where Shawn Pearce <spearce@spearce.org> said that...
> I just posted the first public version of pg, a GIT porcelain for
> managing patches.  Think StGIT, but better in some ways:

  it sounds interesting. I've been thinking about wrapping some patch
queue tool in Cogito (post-1.0) and pg might be a better choice than
StGIT.

  One thing I dislike on both StGIT and pg is that they both try to
build a full-fledged porcelain on top of GIT, instead of just focusing
on the patch management, doing it well and providing a convenient user
interface (well, can't say about pg's interface, didn't try it yet).
Instead of having pg-add, pg-log, or pg-status it might be more fruitful
to contribute the features you are missing to git-core or Cogito.

> And for those so inclined:
> 
>   Homepage:       http://www.spearce.org/projects/scm/pg/
>   GIT Repository: http://www.spearce.org/projects/scm/pg.git

But while it claims to be compatible with all the porcelains, it at
least cannot be clone by them. ;) The GIT repository is not quite a
valid GIT repository since it is missing the HEAD and Cogito clones
based on this file instead of just assuming that your head is on the
master branch.


Also, when cloning it gives me a little unnerving errors like

error: File 6427c0154400f578d9cdff178e01e946db6f714f
(http://www.spearce.org/projects/scm/pg.git/objects/64/27c0154400f578d9cdff178e01e946db6f714f)
corrupt

(but strangely, fsck-objects later does not complain).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
