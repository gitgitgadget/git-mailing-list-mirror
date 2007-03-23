From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix path-limited "rev-list --bisect" termination condition.
Date: Fri, 23 Mar 2007 15:32:11 -0700
Message-ID: <7vps6zoal0.fsf@assigned-by-dhcp.cox.net>
References: <7vtzwboc6v.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703231524520.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 23:32:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUsJ5-0008SJ-NQ
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 23:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbXCWWcN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 18:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbXCWWcN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 18:32:13 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60463 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXCWWcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 18:32:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323223212.LBJY748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Mar 2007 18:32:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id eNYB1W00f1kojtg0000000; Fri, 23 Mar 2007 18:32:12 -0400
In-Reply-To: <Pine.LNX.4.64.0703231524520.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 23 Mar 2007 15:25:08 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42968>

Is this the only issue you know about with respect to the
BISECT_NAMES?  You earlier said it was broken and suggested to
remove it,...
