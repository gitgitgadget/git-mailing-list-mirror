From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 21:51:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504272143260.30848-100000@iabervon.org>
References: <427026AB.4070809@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 03:47:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQy7F-0006Sz-QN
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVD1Bvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVD1Bvt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:51:49 -0400
Received: from iabervon.org ([66.92.72.58]:64518 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261669AbVD1BvL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 21:51:11 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQyBG-0002XO-00; Wed, 27 Apr 2005 21:51:06 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427026AB.4070809@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, H. Peter Anvin wrote:

> There are a fair number of tools one may want that deal with reachability.

Do you agree that installing a new libgit.so when you want to apply such a
tool to a new tag is sufficient? If the library is shared, and everything
for parsing the objects (to the point of getting struct object filled
out) is in the library, and you want to have some tool able to validate or
use any new tag that you want reachability-only tools to process, not
having a standard header proto-format for future tags isn't a problem,
since you'll get upgrades to the parser portion of all of your tools
together.

	-Daniel
*This .sig left intentionally blank*


