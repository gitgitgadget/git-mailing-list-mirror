From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Odd logic in rebase--interactive
Date: Sun, 17 Feb 2008 16:24:13 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802171620060.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 22:24:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQr0F-0005fK-C3
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 22:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbYBQVYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 16:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753718AbYBQVYQ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 16:24:16 -0500
Received: from iabervon.org ([66.92.72.58]:54199 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753614AbYBQVYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 16:24:15 -0500
Received: (qmail 8507 invoked by uid 1000); 17 Feb 2008 21:24:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 21:24:13 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74184>

In 1d25c8cf, you made pick_one not use the code for current and parent 
being the same if no_ff is set, which is true if -n is given. This looks 
like it makes the "git reset --soft $current_sha1" line dead code. Did you 
just forget to remove it, is there some other situation in which it would 
be wanted, or am I misunderstanding the code somehow?

	-Daniel
*This .sig left intentionally blank*
