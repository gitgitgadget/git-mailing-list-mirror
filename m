From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Wed, 18 Jul 2007 20:15:24 +0200
Message-ID: <20070718181524.GA3396@cip.informatik.uni-erlangen.de>
References: <20070716133602.GB26675@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org> <alpine.LFD.0.999.0707161004550.20061@woody.linux-foundation.org> <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716133602.GB26675@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707161001300.20061@woody.linux-foundation.org> <20070716171732.GE6134@cip.informatik.uni-erlangen.de> <20070716180910.GB16878@cip.informatik.uni-erlangen.de> <20070718085055.GL25037@cip.informatik.uni-erlangen.de> <alpine.LFD.0.999.0707180844150.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 20:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBE3c-0004pW-UC
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 20:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbXGRSP0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 14:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762759AbXGRSPZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 14:15:25 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:41178 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762141AbXGRSPZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 14:15:25 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 4A6283F3AE; Wed, 18 Jul 2007 20:15:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707180844150.27353@woody.linux-foundation.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52887>

Hello,

> I don't think the recipient "got it", since it already has a comment about 
> "just use rmdir".  Can you please tell them that that isn't the point?

I already did. They got the point. I have confidence that they fix it.
But there is no ETA. And the fix will not be backported.

	Thomas
