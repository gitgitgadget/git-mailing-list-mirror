From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] patch-id: "diff-tree" => "commit"
Date: Fri, 23 Jun 2006 18:07:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606231800240.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606231731280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0606230849290.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jun 23 18:07:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtoCL-0008FR-57
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 18:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWFWQHx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 12:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbWFWQHx
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 12:07:53 -0400
Received: from mail.gmx.net ([213.165.64.21]:64434 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751732AbWFWQHx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 12:07:53 -0400
Received: (qmail invoked by alias); 23 Jun 2006 16:07:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 23 Jun 2006 18:07:51 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606230849290.6483@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22428>

Hi,

On Fri, 23 Jun 2006, Linus Torvalds wrote:

> On Fri, 23 Jun 2006, Johannes Schindelin wrote:
> > 
> > Some time ago we changed git-log in a massive way, and one consequence is
> > that the keyword changed. Adjust patch-id for that.
> 
> Ahh. Yes. Except I think you should allow both, for historical reasons (ie 
> not remove the old case).

Hmm. If you are alluding to mailboxes, where there could be mails from 
older git versions, then this might not be enough. Look at my patch, for 
example. There is no "diff-tree", and no "commit".

However, the only official user of patch-id is git-cherry (and indirectly, 
all users of git-cherry). And this user works on data which is generated 
on the fly, i.e. there will be no "diff-tree" at the beginning.

Of course, there is a Pandora's box: a line in a commit message is much 
more likely to start with "commit <sha1>" than "diff-tree <sha1>". So my 
patch probably breaks many cases.

Ciao,
Dscho
