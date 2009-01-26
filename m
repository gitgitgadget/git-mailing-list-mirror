From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Common ancestor in merge diffs?
Date: Mon, 26 Jan 2009 13:41:41 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901261318030.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 19:43:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWQO-0005f7-KS
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 19:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbZAZSlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 13:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbZAZSln
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 13:41:43 -0500
Received: from iabervon.org ([66.92.72.58]:41304 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbZAZSln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 13:41:43 -0500
Received: (qmail 25272 invoked by uid 1000); 26 Jan 2009 18:41:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jan 2009 18:41:41 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107244>

I was just doing an annoying merge (I'd reorganized code while other 
people made changes to it), and I kept having the problem that it was hard 
to figure out what each side had done. Is there some way to ask git for 
the diffs between the common ancestor (which is unique in my case, so it's 
actually useful) and each of the sides of the merge? Ideally, it would 
give essentially the converse of the --cc diff: first column is -stage 1 
+stage 2; second column is -stage 1 +stage 3.

I think this would generally be more useful than the current diff output 
for the unresolved portions (-stage 3 +working tree, -stage 2 +working 
tree) because you're generally quite familiar with the working tree (since 
you're trying to resolve there), and stage 1 is not obvious.

	-Daniel
*This .sig left intentionally blank*
