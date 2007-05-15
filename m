From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$  to be consistent with other VCSs
Date: Mon, 14 May 2007 17:17:20 -0700
Message-ID: <7vzm47kkj3.fsf@assigned-by-dhcp.cox.net>
References: <200705141429.58412.andyparkins@gmail.com>
	<46486FE6.16A82D9A@eudaptics.com>
	<7v646vo3pn.fsf@assigned-by-dhcp.cox.net>
	<200705142324.02929.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <J.Sixt@eudaptics.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 02:17:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnkjK-0004G5-R9
	for gcvg-git@gmane.org; Tue, 15 May 2007 02:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbXEOARX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 20:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756890AbXEOARX
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 20:17:23 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:61856 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759AbXEOARW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 20:17:22 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515001721.TWZU2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 20:17:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zCHL1W00f1kojtg0000000; Mon, 14 May 2007 20:17:21 -0400
In-Reply-To: <200705142324.02929.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 14 May 2007 23:24:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47304>

Andy Parkins <andyparkins@gmail.com> writes:

> It would be perfectly correct to overwrite it, as in the repository 
> version none of that information is present, and even if it wasn't, as 
> we've discussed at length, it's all meaningless in a git context 
> anyway - the best thing that you could do for it _is_ overwrite it.

Ok, you are right, and we should obviously do this before v1.5.2
final.
