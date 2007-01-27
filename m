From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: finding earliest tags descended from a given commit
Date: Fri, 26 Jan 2007 23:42:46 -0500
Message-ID: <20070127044246.GC14205@fieldses.org>
References: <20070127040618.GA14205@fieldses.org> <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 05:42:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAfOw-00066k-M2
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 05:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbXA0Ems (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 23:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbXA0Ems
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 23:42:48 -0500
Received: from mail.fieldses.org ([66.93.2.214]:45393 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877AbXA0Emr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 23:42:47 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HAfOo-0005Ob-B8; Fri, 26 Jan 2007 23:42:46 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701262022230.25027@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37918>

On Fri, Jan 26, 2007 at 08:34:15PM -0800, Linus Torvalds wrote:
> On Fri, 26 Jan 2007, J. Bruce Fields wrote:
> >
> > Just curious: every now and then somebody will ask me what kernel
> > version they need to upgrade to to get some given fix.  I can find the
> > commit with the given fix easily enough.  How do I then find the
> > earliest tagged version containing that fix?
> 
> You can name any revision based on the set of tags you have with:
> 
> 	git name-rev --tags <sha1-of-commit>
> 
> which will try to find the "simplest" way to name something by following 
> one of your tags.

That's interesting, I hadn't noticed name-rev before you and Shawn
mentioned it.

It only finds one name, though. When I tried it just now on my
repository what it found was a tag I'd created for an experimental
version, which probably wouldn't be what I wanted.  (Though it might be,
in some situations.)

--b.
