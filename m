From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 6/9] Use uint32_t for pack-objects counters.
Date: Wed, 07 Mar 2007 13:52:09 -0800
Message-ID: <7vodn4en7a.fsf@assigned-by-dhcp.cox.net>
References: <20070307014424.GG26482@spearce.org>
	<7v1wk0g9mp.fsf@assigned-by-dhcp.cox.net>
	<20070307203721.GD27922@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:52:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP43a-0004wG-Oz
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 22:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992640AbXCGVwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 16:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992641AbXCGVwN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 16:52:13 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65428 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992640AbXCGVwK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 16:52:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307215210.WUUK2394.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 16:52:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xxs91W00L1kojtg0000000; Wed, 07 Mar 2007 16:52:09 -0500
In-Reply-To: <20070307203721.GD27922@spearce.org> (Shawn O. Pearce's message
	of "Wed, 7 Mar 2007 15:37:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41696>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Its always scanned backwards.  I've read the patch like 8 times
> now (and I just reread the part you quoted).  The patch implements
> the same backwards scan that has always been there.

Sorry, false alarm.  Yes we scanned from larger to smaller and
you still do.
