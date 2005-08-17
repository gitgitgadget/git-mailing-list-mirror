From: Paul Mackerras <paulus@samba.org>
Subject: gitk with hyperspace support
Date: Wed, 17 Aug 2005 10:21:04 +1000
Message-ID: <17154.33520.584666.701545@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 17 02:21:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5BgC-0007BW-6r
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 02:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVHQAVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 20:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVHQAVN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 20:21:13 -0400
Received: from ozlabs.org ([203.10.76.45]:13205 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750770AbVHQAVN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 20:21:13 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4BD8567F73; Wed, 17 Aug 2005 10:21:12 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have been trying a new approach to drawing the commit graph in gitk.
This involves sending a lot of the really long lines into
"hyperspace", by terminating them with an arrow pointing down when the
graph gets too wide, and then reintroducing them later with an arrow
pointing up, as though they had used a warp drive to dive beneath the
screen (into the mysterious 3rd dimension :) and then reappear later.
The result is that the graph stays at a reasonable width and doesn't
need to be compressed.

My reasoning is that it is the local short-range connections which are
interesting and informative.  The long-range connections aren't really
visually informative; if you want to know about the long-range
connections, the parent and child lists in the details pane are much
more useful.

I would like to get some feedback about what people think of the
visual effect of this new approach, and in particular whether having
the lines jump into hyperspace loses information that people find
useful.  The new version is at:

http://ozlabs.org/~paulus/gitk/gitk.hs

If the reaction is positive I'll check this into my gitk.git
repository.

Thanks,
Paul.
