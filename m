From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-update-ref: add --no-deref option for overwriting/detaching ref
Date: Wed, 09 May 2007 08:22:42 -0700
Message-ID: <7vk5viuim5.fsf@assigned-by-dhcp.cox.net>
References: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Wed May 09 17:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlo09-0001dE-Ak
	for gcvg-git@gmane.org; Wed, 09 May 2007 17:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbXEIPWo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 11:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbXEIPWo
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 11:22:44 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:41613 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbXEIPWn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 11:22:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509152243.XHMZ13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 11:22:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x3Ni1W00V1kojtg0000000; Wed, 09 May 2007 11:22:43 -0400
In-Reply-To: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Wed, 09 May 2007 12:33:20 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46726>

Sven Verdoolaege <skimo@kotnet.org> writes:

> git-checkout is also adapted to make use of this new option
> instead of the handcrafted command sequence.
>
> Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
> ---
> All tests pass, except the recently added cvsserver tests,
> but they fail without this patch too.

Can you retry after installing libdbi and libdbd-sqlite-perl?
