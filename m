From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why git-merge-resolve in git-am?
Date: Wed, 27 Dec 2006 18:11:26 -0800
Message-ID: <7vr6uk3h2p.fsf@assigned-by-dhcp.cox.net>
References: <20061228014525.GC16612@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 03:11:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzkk6-0005YI-LT
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 03:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWL1CLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 21:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWL1CLa
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 21:11:30 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:57879 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964862AbWL1CL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 21:11:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228021126.UXRJ16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 21:11:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 42Bg1W00A1kojtg0000000; Wed, 27 Dec 2006 21:11:40 -0500
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061228014525.GC16612@spearce.org> (Shawn Pearce's message of
	"Wed, 27 Dec 2006 20:45:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35508>

Shawn Pearce <spearce@spearce.org> writes:

> Why does git-am use git-merge-resolve while git-rebase -m uses
> git-merge-recursive?

The use of merge-resolve by am predates merge-resolve became
usable by at least six weeks, and longer before merge-resolve
became really stable for about an extra month after.

Even after it stabilized merge-recursive was way slower than
merge-resove until it was rewritten in C for another nine
months.
