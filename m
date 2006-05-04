From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Fetching a tree from a remote server
Date: Wed, 3 May 2006 20:41:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605032026070.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu May 04 02:41:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbRu8-0000qq-U6
	for gcvg-git@gmane.org; Thu, 04 May 2006 02:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWEDAlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 20:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWEDAlN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 20:41:13 -0400
Received: from iabervon.org ([66.92.72.58]:64008 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750822AbWEDAlN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 20:41:13 -0400
Received: (qmail 8302 invoked by uid 1000); 3 May 2006 20:41:52 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2006 20:41:52 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19539>

Is there something to do the opposite of git clone -n? That is, I want to 
fill a directory with a treeish ref, and I don't care about any history or 
bookkeeping. I'm doing automated builds of things stored on a slow 
machine, so I'd really benefit from not getting the history. As it is, 
it's only twice as fast as arch, when it really ought to be hundreds of 
times faster.

Also, git-archimport in 1.2.4 seems to leave master as the initial import, 
rather than either not having it or having it at the end, which is a bit 
confusing.

	-Daniel
*This .sig left intentionally blank*
