From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 07 Aug 2006 16:05:49 -0700
Message-ID: <7vr6zsywmq.fsf@assigned-by-dhcp.cox.net>
References: <7vu04o1fwm.fsf@assigned-by-dhcp.cox.net>
	<20060807221914.GA24393@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 01:05:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAEAU-0004iR-Pu
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 01:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWHGXFv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 19:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWHGXFv
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 19:05:51 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19689 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751031AbWHGXFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 19:05:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060807230550.UQXV12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Aug 2006 19:05:50 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060807221914.GA24393@mellanox.co.il> (Michael S. Tsirkin's
	message of "Tue, 8 Aug 2006 01:19:14 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25052>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> The following seems to fix this issue: simply scan the full
> refspec list for each remote instead of breaking on the first match.
> I had to touch the git-fetch.sh script as well as it is scanning
> the remote list, too. Works for me.

Looks Ok, although I have to admit I just gave a cursory look.
Thanks.
