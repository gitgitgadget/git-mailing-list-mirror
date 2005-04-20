From: Daniel Barkalow <barkalow@iabervon.org>
Subject: More transport methods
Date: Tue, 19 Apr 2005 21:49:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504192144010.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Apr 20 03:46:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO4HZ-00089Q-09
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 03:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVDTBtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 21:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVDTBtq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 21:49:46 -0400
Received: from iabervon.org ([66.92.72.58]:29959 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261285AbVDTBtl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 21:49:41 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DO4Lk-00064m-00
	for git@vger.kernel.org; Tue, 19 Apr 2005 21:49:56 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Just in case someone else is considering trying it, I've just written a
pair of programs to transfer a commit and everything it uses directly over
ssh (i.e., without rsync); it is also clever enough to reject anything
that either doesn't inflate or doesn't hash correctly. It also doesn't
transfer anything that the recipient already has or doesn't need.

I have some more cleaning to go on it, but I could post it if others want
to hack on it.

	-Daniel
*This .sig left intentionally blank*

