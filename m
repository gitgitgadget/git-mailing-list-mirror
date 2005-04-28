From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: The criss-cross merge case
Date: Wed, 27 Apr 2005 21:16:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504272051390.30848-100000@iabervon.org>
References: <42703194.80409@tupshin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bram Cohen <bram@bitconjurer.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:11:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxYn-0003ot-UX
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVD1BQs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVD1BQs
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:16:48 -0400
Received: from iabervon.org ([66.92.72.58]:38918 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261154AbVD1BQq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 21:16:46 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQxdq-0001QK-00; Wed, 27 Apr 2005 21:16:34 -0400
To: Tupshin Harper <tupshin@tupshin.com>
In-Reply-To: <42703194.80409@tupshin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Apr 2005, Tupshin Harper wrote:

> Can you clarify what you mean by darcs' underlying diff not being that
> great? It seems to function pretty much identically to gnu diff. In what
> way would you want the underlying diff to be improved?

GNU diff uses an algorithm which is tuned to handle finding the shortest
diff among a large set of similar-length alternatives while comparing
files which have a lot of repeated lines. The author of the paper it cites
is really thinking about diffing DNA sequences or similar things. It also
can't detect content moves, which are a common thing to have, and which
will be important in the long run, when we're trying to track
modifications to content which also moved from place to place.

	-Daniel
*This .sig left intentionally blank*

