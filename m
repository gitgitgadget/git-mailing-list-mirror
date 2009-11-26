From: Alan Stern <stern@rowland.harvard.edu>
Subject: Strange behavior of gitweb
Date: Thu, 26 Nov 2009 12:32:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911261225130.17259-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 18:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDiD9-0007oI-LC
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 18:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbZKZRco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 12:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbZKZRcn
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 12:32:43 -0500
Received: from netrider.rowland.org ([192.131.102.5]:42371 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752274AbZKZRcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 12:32:42 -0500
Received: (qmail 17875 invoked by uid 500); 26 Nov 2009 12:32:48 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Nov 2009 12:32:48 -0500
X-X-Sender: stern@netrider.rowland.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133815>

If this isn't the right place to post this, could somebody please let 
me know where would be better?

I recently ran across this strange behavior in the gitweb server at 
git.kernel.org.  The following URL:

http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.27.y.git;a=commit;h=2d93148ab6988cad872e65d694c95e8944e1b62

brings up a page containing commit 2d93148[...].  But that commit isn't
part of the 2.6.27.y tree!  It belongs to Linus's main tree, and it was
added long after 2.6.27.y was forked off.  The actual commit applied to
2.6.27.y was 070bb0f3b6df167554f0ecdeb17a5bcdb1cd7b83.

So what's going on here?  Shouldn't the correct behavior be to report
an error, since the requested commit isn't in the history of the
specified tree?

Thanks,

Alan Stern
