From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Honor -p<n> when applying git diffs
Date: Wed, 04 Apr 2007 22:15:16 -0700
Message-ID: <7vr6qzwgez.fsf@assigned-by-dhcp.cox.net>
References: <20070404151914.GA4910@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 07:15:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZKJe-0007S6-5U
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 07:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbXDEFPT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 01:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161200AbXDEFPT
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 01:15:19 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41130 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161195AbXDEFPS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 01:15:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405051516.VNH27119.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 01:15:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jHFG1W00l1kojtg0000000; Thu, 05 Apr 2007 01:15:17 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43794>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If the user is trying to apply a Git generated diff file and they
> have specified a -p<n> option, where <n> is not 1, the user probably
> has a good reason for doing this.  Such as they are me, trying to
> apply a patch generated in git.git for the git-gui subdirectory to
> the git-gui.git repository, where there is no git-gui subdirectory
> present.

Good point.
