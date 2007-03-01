From: Junio C Hamano <junkio@cox.net>
Subject: Re: Updated version, was Re: RFC: Patch editing
Date: Thu, 01 Mar 2007 15:59:21 -0800
Message-ID: <7vwt20o6qu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702252156190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0703020020470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 01:00:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMvC8-0004Hy-Cb
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 01:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289AbXCAX7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 18:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161312AbXCAX72
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 18:59:28 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59583 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161289AbXCAX7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 18:59:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301235923.FUYC2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Mar 2007 18:59:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VbzM1W00C1kojtg0000000; Thu, 01 Mar 2007 18:59:22 -0500
In-Reply-To: <Pine.LNX.4.63.0703020020470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 2 Mar 2007 00:30:03 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41153>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> My plans are _not_ to turn this into git-rebase--interactive.sh, as I 
> originally planned. Instead, I will try to make git-rebase a builtin, and 
> add a "-i" flag which does the equivalent of this script.
>
> BTW would people be mad at me if I did _not_ imitate git-rebase.sh (call 
> format-patch and feed that into apply), but rather used cherry-pick 
> throughout?

Then that C built-in would not replace git-rebase but only
"git-rebase -m".

I very often find it easier to deal with a conflicting rebase by
editing the patch text, so yes I would imagine I would be rather
upset, but I do not know about others.
