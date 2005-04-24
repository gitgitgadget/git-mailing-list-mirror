From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git-changes-script to show inter tree changes
Date: Sun, 24 Apr 2005 14:36:21 +0200
Message-ID: <20050424123621.GB1507@pasky.ji.cz>
References: <1114281792.5068.10.camel@mulgrave> <20050423230937.GF13222@pasky.ji.cz> <1114306762.4805.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 14:31:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPgH3-0005ID-2d
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 14:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVDXMg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 08:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbVDXMg1
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 08:36:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42179 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262319AbVDXMgW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 08:36:22 -0400
Received: (qmail 14233 invoked by uid 2001); 24 Apr 2005 12:36:21 -0000
To: James Bottomley <James.Bottomley@SteelEye.com>
Content-Disposition: inline
In-Reply-To: <1114306762.4805.3.camel@mulgrave>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 03:39:22AM CEST, I got a letter
where James Bottomley <James.Bottomley@SteelEye.com> told me that...
> On Sun, 2005-04-24 at 01:09 +0200, Petr Baudis wrote:
> > Linus isn't probably the right person to Cc on this, since this is
> > git-pasky thing.  Can you please post it as a signed-off patch?
> 
> I'm just offering it as one of the scripts I need to operate a git tree
> as a maintainer.  I don't have git-pasky installed, so I can't patch it
> against anything.  However, feel free to incorporate any pieces you
> need.

Aha,  I thought this is based on the current gitlog.sh, sorry.

> > I don't get what are you doing anyway. I don't know the "bk changes"
> > tool. Can't you just do
> > 
> > 	git log theothertree yourtree
> 
> No idea .. not used it.  However, how does this show the -L and -R diffs
> since there are two possible views of changes between trees?  It's
> primarily -L (changes in local) I need to keep the changes in my local
> tree.  -R (changes in remote) is just useful to show what changes I'm
> missing and might need to merge.

For -R, you'd probably do

	git log yourtree theothertree

(the range of changes between yourtree and theothertree, literally).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
