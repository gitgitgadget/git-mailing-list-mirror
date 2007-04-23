From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add get_sha1_with_mode
Date: Mon, 23 Apr 2007 14:19:13 -0700
Message-ID: <7vr6qaeqlq.fsf@assigned-by-dhcp.cox.net>
References: <11773617051833-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:19:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg5wQ-0003ir-Jw
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 23:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589AbXDWVTP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 17:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754238AbXDWVTP
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 17:19:15 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43785 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbXDWVTO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 17:19:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423211914.HOAM1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 17:19:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qlKD1W00G1kojtg0000000; Mon, 23 Apr 2007 17:19:13 -0400
In-Reply-To: <11773617051833-git-send-email-mkoegler@auto.tuwien.ac.at>
	(Martin Koegler's message of "Mon, 23 Apr 2007 22:55:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45365>

I queued your previous one in 'pu' (proposed updates) already.
I'll replace it with this; thanks.

There in the 'pu' branch, I also have a fix-up patch on top of
your series to actually make "git diff tree1:path tree2:path"
work when there is only mode change between the blobs.
