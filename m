From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pushing into a repository with working directory?
Date: Fri, 05 Jan 2007 00:54:05 -0800
Message-ID: <7vwt41j1le.fsf@assigned-by-dhcp.cox.net>
References: <20070102045108.GC27690@spearce.org> <459E1182.201@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 09:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2kq5-0002RE-87
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 09:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbXAEIyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 03:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161028AbXAEIyJ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 03:54:09 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:47344 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161026AbXAEIyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 03:54:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105085405.XICA16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jan 2007 03:54:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7LuL1W00J1kojtg0000000; Fri, 05 Jan 2007 03:54:20 -0500
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <459E1182.201@shadowen.org> (Andy Whitcroft's message of "Fri, 05
	Jan 2007 08:51:14 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35981>

Andy Whitcroft <apw@shadowen.org> writes:

> Special casing the 'current' branch makes any sort of automated push
> setup unreliable.  Indeed the special case preventing a fetch into the
> current branch is pretty annoying for the same reason.  I would almost
> prefer to relax that than add the same for push.

How would you relax the fetch case?  Fetching into the current
branch, unless the repository is bare, is always a fishy
operation.
