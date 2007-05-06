From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Have git-revert, git-cherry-pick cleanup ./.msg upon successful completion.
Date: Sat, 05 May 2007 23:49:15 -0700
Message-ID: <7vps5efnv8.fsf@assigned-by-dhcp.cox.net>
References: <20070504143022.8539.qmail@4071cc1c178e73.315fe32.mid.smarden.org>
	<20070504143210.8690.qmail@a4171e0dbe98e3.315fe32.mid.smarden.org>
	<20070505034615.GE16538@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 06 08:49:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkaYn-0004x6-31
	for gcvg-git@gmane.org; Sun, 06 May 2007 08:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbXEFGtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 02:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754702AbXEFGtR
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 02:49:17 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:36948 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbXEFGtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 02:49:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070506064916.LOKP26353.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 6 May 2007 02:49:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id vipF1W00C1kojtg0000000; Sun, 06 May 2007 02:49:16 -0400
In-Reply-To: <20070505034615.GE16538@spearce.org> (Shawn O. Pearce's message
	of "Fri, 4 May 2007 23:46:15 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46305>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> What about this change instead?  We make cherry-pick/revert
> use the same temporary file as merge, which is under .git/
> (something Alex mentioned he wanted).  I think the use of ".msg"
> in cherry-pick/revert has always just been a bug, and not a feature,
> so I'm really not against changing things around like this.

While I would not say this is not an improvement, this makes
MERGE_MSG even less about merges and pushes us away from a
sensible "git whatnow".
