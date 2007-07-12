From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/4] The rest of builtin-fetch
Date: Wed, 11 Jul 2007 21:36:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707112113460.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 03:37:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ncA-0000Bo-8Y
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 03:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760361AbXGLBg7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 21:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760301AbXGLBg7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 21:36:59 -0400
Received: from iabervon.org ([66.92.72.58]:1581 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759513AbXGLBg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 21:36:58 -0400
Received: (qmail 31919 invoked by uid 1000); 12 Jul 2007 01:36:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jul 2007 01:36:57 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52228>

This series is the rest of builtin-fetch. It should probably not be used 
without a "[PATCH 3.5/4] Support bundles in transport fetch" which 
Johannes was going to write.

The first patch of this is independant of anything else, but the rest 
depend on all of the other series I have sent recently. One thing I 
already plan to fix while doing revisions for comments is that the 
"remote.<name>.tagopt" config variable parsing is added by the second 
patch, when it would be more logically added by the first.

When the development cycle is at the right point for getting all this in, 
I'll be sending out the complete set of patches (aside from the pair that 
were already accepted). I'm also going to send out another revision of 
builtin-fetch-pack.c that adds a bit of memory freeing and depends on the 
first of the accepted pair. And I've got a builtin-send-pack (with a 
function for transport.c to call directly), although that's not in the 
critical path.

	-Daniel
*This .sig left intentionally blank*
