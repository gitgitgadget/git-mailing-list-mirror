From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 24 Apr 2007 10:23:09 -0400
Message-ID: <20070424142309.GD18538@fieldses.org>
References: <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org> <Pine.LNX.4.64.0704191118050.8822@racer.site> <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org> <4627ABBB.8060709@softax.com.pl> <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org> <877is29b1l.wl%cworth@cworth.org> <7vps5ud91x.fsf@assigned-by-dhcp.cox.net> <87vefm7l6g.wl%cworth@cworth.org> <alpine.LFD.0.98.0704231609440.9964@woody.linux-foundation.org> <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Carl Worth <cworth@cworth.org>,
	Marcin Kasperski <Marcin.Kasperski@softax.com.pl>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 16:24:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgLw9-00056W-J8
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 16:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161779AbXDXOX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 10:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161780AbXDXOXZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 10:23:25 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56388 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161775AbXDXOXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 10:23:16 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HgLvB-0005Ix-FR; Tue, 24 Apr 2007 10:23:09 -0400
Content-Disposition: inline
In-Reply-To: <7v1wiabbfr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45452>

On Mon, Apr 23, 2007 at 10:15:04PM -0700, Junio C Hamano wrote:
> If Carl is also happy with the syntax, we can conclude this
> discussion and:
> 
>  (1) have that as an enhancement to git-clone;
> 
>  (2) add a how-to document or a section to the manual to teach
>      people how to track one or more branches, based on the
>      messages already posted on this thread.

Note that we almost have the tutorials for the "two very simple cases"
that Linus identifies:

	- case #1, the "anonymous CVS" replacement: chapter 2 of
	  user-manual.txt (the first chapter after the quick start) covers
	  this.  Perhaps in greater generality than necessary, and maybe
	  detached heads and/or --track should be mentioned earlier.

	- tutorial.txt, the "how to start tracking your own project"
	  case, starts with git-init, git-add, etc.

One problem is that it's not immediately obvious which one to look at
for each case.

--b.
