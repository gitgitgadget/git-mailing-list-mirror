From: Michael Hendricks <michael@ndrix.org>
Subject: Re: [PATCH] Dissociating a repository from its alternates
Date: Mon, 22 Oct 2007 17:30:51 -0600
Message-ID: <20071022233050.GA18430@ginosko.ndrix.org>
References: <7vabzfhn9q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702151638130.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xex50aa.fsf@assigned-by-dhcp.cox.net> <20071022180424.GA17429@ginosko.local> <Pine.LNX.4.64.0710221957360.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 23 01:31:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik6jh-00038x-7m
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 01:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbXJVXay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 19:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbXJVXay
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 19:30:54 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34978 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750700AbXJVXay (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 19:30:54 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7A67F34AD8;
	Mon, 22 Oct 2007 19:30:53 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 22 Oct 2007 19:30:53 -0400
X-Sasl-enc: nRm5BSTyz7/j3Le6Tprp7fZXQpPX/LDHgNXbd4cXVO4R 1193095852
Received: from ndrix.org (tameion.ndrix.org [166.230.131.80])
	by mail.messagingengine.com (Postfix) with ESMTP id DAF7315326;
	Mon, 22 Oct 2007 19:30:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710221957360.25221@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62057>

On Mon, Oct 22, 2007 at 08:05:58PM +0100, Johannes Schindelin wrote:
> On Mon, 22 Oct 2007, Michael Hendricks wrote:
> > Was such a script ever incorporated into Git?
> 
> Not that I know of, but "git repack -a && rm
> .git/objects/info/alternates" should do what you want.  You can even
> make a script of it, add some documentation and a test case, and earn
> git fame by posting a patch ;-)

With 1.5.3.4, it doesn't appear to work:

 $ git clone -s git git2
 Initialized empty Git repository in /Users/michael/src/git2/.git/

 $ cd git2

 $ git repack -a && rm .git/objects/info/alternates
 Generating pack...
 Done counting 0 objects.
 Nothing new to pack.

 $ git status
 # On branch master
 fatal: bad object HEAD

-- 
Michael
