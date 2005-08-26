From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Looking at multiple ancestors in merge
Date: Fri, 26 Aug 2005 01:16:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508260108290.23242@iabervon.org>
References: <Pine.LNX.4.63.0508242249030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 08:17:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8WX9-0006m7-8t
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 07:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVHZFNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 01:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbVHZFNU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 01:13:20 -0400
Received: from iabervon.org ([66.92.72.58]:27661 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751515AbVHZFNU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 01:13:20 -0400
Received: (qmail 21713 invoked by uid 1000); 26 Aug 2005 01:16:55 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Aug 2005 01:16:55 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508242249030.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7791>

On Wed, 24 Aug 2005, Daniel Barkalow wrote:

> Of course, this is going to take a bit of work, because read-tree
> currently puts all of its arguments into the cache and then works on
> merging, and taking multiple ancestors requires putting them somewhere
> else, because they won't fit in the cache.

I've started this, and have gotten as far as having read-tree accept > 3
trees and ignore everything but the last 3. Am I correct in assuming that
if I break read-tree in any way, some test will fail?

	-Daniel
*This .sig left intentionally blank*
