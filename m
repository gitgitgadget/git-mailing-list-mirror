From: Daniel Barkalow <barkalow@iabervon.org>
Subject: USE_CURL_MULTI and http.h in general
Date: Wed, 18 Jul 2007 17:19:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707181711450.14596@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 23:19:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBGvX-0002C1-QN
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 23:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580AbXGRVTQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 17:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbXGRVTQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 17:19:16 -0400
Received: from iabervon.org ([66.92.72.58]:1827 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838AbXGRVTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 17:19:15 -0400
Received: (qmail 4423 invoked by uid 1000); 18 Jul 2007 21:19:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jul 2007 21:19:14 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52899>

The changes I made to the commit-walker fetch code turn out not to work 
with USE_CURL_MULTI, and I'm not at all clear on how to deal with it. I 
think the current code for USE_CURL_MULTI also can't work for having 
multiple things in the same executable using http.h, which will be a 
problem for having both ls-remote and http-fetch as part of builtin-fetch, 
as well as eventually calling http-push without an exec from builtin-push. 
Is there anyone around who understands it?

	-Daniel
*This .sig left intentionally blank*
