From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-remote to list pushed branches.
Date: Tue, 20 Mar 2007 20:03:58 -0700
Message-ID: <7v1wjj70wx.fsf@assigned-by-dhcp.cox.net>
References: <200703182134.46450.johannes.sixt@telecom.at>
	<200703192016.46894.johannes.sixt@telecom.at>
	<7v648wg8sy.fsf@assigned-by-dhcp.cox.net>
	<200703210027.32307.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Mar 21 04:04:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTr7a-0005xE-2E
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 04:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbXCUDEA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 23:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932833AbXCUDEA
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 23:04:00 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63489 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932425AbXCUDD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 23:03:59 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321030359.IEUI748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 20 Mar 2007 23:03:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dF3y1W00Z1kojtg0000000; Tue, 20 Mar 2007 23:03:59 -0400
In-Reply-To: <200703210027.32307.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Wed, 21 Mar 2007 00:27:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42776>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> BTW, the .git/remotes parser does not allow multiple refspecs on one 'Push:' 
> line, if I understand it correctly (I'm looking at get_remotes_uri in 
> builtin-push.c).

Sheesh, you are right.  That is a regression introduced, when
git-push was rewritten as a built-in, and I did not know about
it until now.
