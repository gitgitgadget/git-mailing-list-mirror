From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Fix typo in tutorial-2.txt
Date: Mon, 5 Jun 2006 19:44:41 -0400
Message-ID: <20060605234441.GB14993@fieldses.org>
References: <Pine.LNX.4.64.0606051245470.5498@g5.osdl.org> <Pine.LNX.4.63.0606060111570.25344@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 01:44:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnOka-000729-P2
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 01:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWFEXoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 19:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWFEXoo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 19:44:44 -0400
Received: from mail.fieldses.org ([66.93.2.214]:1716 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1750801AbWFEXoo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 19:44:44 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FnOkT-00042F-7b; Mon, 05 Jun 2006 19:44:41 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606060111570.25344@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21354>

On Tue, Jun 06, 2006 at 01:15:32AM +0200, Johannes Schindelin wrote:
> On Mon, 5 Jun 2006, Linus Torvalds wrote:
> 
> > I didn't actually _test_ the tutorial, but if the old command worked, 
> > something is really wrong!
> 
> Maybe some new gitter wants to get dirty hands? We used to have a test 
> which just replayed the commands in the tutorial, to make sure that new 
> users would not hit a regression or a syntax change...

Might be a nice idea.

But don't commit SHA1's, e.g., depend on times, authors, etc., that we
can't count on being the same?  So you'd have to be clever to deal with
stuff like

	git cat-file commit a344bd52

Also, note that I didn't even attempt to keep a consistent scenario
throughout the first tutorial.

--b.
