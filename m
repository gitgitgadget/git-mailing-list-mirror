From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] refer to post-patch lines in whitespace warnings
Date: Wed, 9 Jan 2008 10:57:40 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801091046100.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 16:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCdJo-0004ey-RD
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 16:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbYAIP5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 10:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYAIP5m
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 10:57:42 -0500
Received: from iabervon.org ([66.92.72.58]:40928 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbYAIP5m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 10:57:42 -0500
Received: (qmail 8298 invoked by uid 1000); 9 Jan 2008 15:57:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Jan 2008 15:57:40 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69998>

When I rebase series with bad whitespace, I end up with unhelpful messages 
like:

.dotest/patch:412: trailing whitespace.
-- 
.dotest/patch:446: trailing whitespace.
-- 

These line numbers obviously refer to lines in a file that's been removed 
by the time I can do anything about it. It seems to me like the message 
would be more useful if, in the case where it leaves the working tree 
modified with the non-compliant whitespace, it gave this location rather 
than the patch's location (because, even if you have the patch still, 
you'd need to revert it first in order to be able to apply a fixed version 
anyway). Anybody see any problems with this theory?

	-Daniel
*This .sig left intentionally blank*
