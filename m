From: Junio C Hamano <junkio@cox.net>
Subject: Re: reflog for HEAD (detached or between branches)
Date: Fri, 26 Jan 2007 15:45:13 -0800
Message-ID: <7vbqkluzcm.fsf@assigned-by-dhcp.cox.net>
References: <11698503133039-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 00:45:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAal2-0007If-5m
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbXAZXpV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 18:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbXAZXpV
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:45:21 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:37661 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbXAZXpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 18:45:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126234514.LVZJ29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 18:45:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FzkG1W00m1kojtg0000000; Fri, 26 Jan 2007 18:44:17 -0500
In-Reply-To: <11698503133039-git-send-email-nico@cam.org> (Nicolas Pitre's
	message of "Fri, 26 Jan 2007 17:25:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37899>

I suspect that "git-reflog --expire", "git-fsck-objects" and
"git-prune" need to be updated to take the reflog associated
with the HEAD into account, as for_each_ref() does not call you
with HEAD.

Other than that, I think the series is beautifully done.

Thanks.
