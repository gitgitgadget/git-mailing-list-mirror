From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make 'make' quieter while building git
Date: Mon, 05 Mar 2007 23:03:02 -0800
Message-ID: <7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
References: <20070306063501.GA24355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:03:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOThU-0003sx-4p
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965823AbXCFHDG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965824AbXCFHDF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:03:05 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46475 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965823AbXCFHDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:03:04 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306070302.JGNJ26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 02:03:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XK321W00L1kojtg0000000; Tue, 06 Mar 2007 02:03:03 -0500
In-Reply-To: <20070306063501.GA24355@spearce.org> (Shawn O. Pearce's message
	of "Tue, 6 Mar 2007 01:35:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41545>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I find it difficult to see compiler warnings amongst the massive
> spewing produced by GNU make as it works through our productions.

I agree, and suspect it might even be a better idea to make this
the default, with "make V=1" to make chattier.

Now we should do the same to git-gui, shouldn't we?  Time for me
to subtree-merge git-gui to my master?
