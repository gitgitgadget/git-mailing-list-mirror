From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix tests when using bash_completion
Date: Mon, 23 Apr 2007 14:15:21 -0700
Message-ID: <7vvefmeqs6.fsf@assigned-by-dhcp.cox.net>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D496D0@MBGMail01.mobot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Ron Parker" <ron.parker@mobot.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg5sc-00022F-1k
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 23:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbXDWVPX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 17:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbXDWVPX
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 17:15:23 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:42017 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215AbXDWVPW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 17:15:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423211522.HLYY1271.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 17:15:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qlFM1W0051kojtg0000000; Mon, 23 Apr 2007 17:15:21 -0400
In-Reply-To: <769697AE3E25EF4FBC0763CD91AB1B0201D496D0@MBGMail01.mobot.org>
	(Ron Parker's message of "Mon, 23 Apr 2007 15:51:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45363>

"Ron Parker" <ron.parker@mobot.org> writes:

> When using bash_completion, 'cd' echos the target directory name to
> standard
> out.  If 'cd' participates in a pipe whose output is compared against an
> expected value, this causes a false failure report.  Pipe cd's stdout to
> /dev/null in these cases.

This is way too ugly.

Are you sure bash-completion is the culprit, not your CDPATH?
