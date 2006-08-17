From: Junio C Hamano <junkio@cox.net>
Subject: Re: git log - filter missing changesets
Date: Thu, 17 Aug 2006 01:43:31 -0700
Message-ID: <7v7j17u4zw.fsf@assigned-by-dhcp.cox.net>
References: <20060817082558.GB2630@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 17 10:43:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDdTZ-0005I1-Ab
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 10:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWHQInd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 04:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWHQInd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 04:43:33 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43230 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932338AbWHQInc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 04:43:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060817084332.BKJZ6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 17 Aug 2006 04:43:32 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20060817082558.GB2630@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 17 Aug 2006 11:25:58 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25558>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Hi!
> git log with -- parameter seems to sometimes miss changesets that
> affect a specific directory:
> ...
> what gives?

Most likely history simplification threw away the entire side
branch.

This is getting to be a FAQ I suspect.

http://thread.gmane.org/gmane.comp.version-control.git/21633
