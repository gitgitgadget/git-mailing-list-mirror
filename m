From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Functions for managing the set of packs the library is using (whitespace fixed)
Date: Mon, 01 Aug 2005 01:16:39 -0700
Message-ID: <7vpssyxeag.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0507311600040.23721@iabervon.org>
	<Pine.LNX.4.62.0507312053010.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 10:17:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzVTj-0007Ib-MD
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 10:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVHAIQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 04:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVHAIQo
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 04:16:44 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:65504 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262045AbVHAIQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2005 04:16:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050801081639.UUPT19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 Aug 2005 04:16:39 -0400
To: barkalow@iabervon.org
In-Reply-To: <Pine.LNX.4.62.0507312053010.23721@iabervon.org> (barkalow@iabervon.org's message of "Sun, 31 Jul 2005 20:53:44 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

barkalow@iabervon.org writes:

> This adds support for reading an uninstalled index, and installing a
> pack file that was added while the program was running, as well as
> functions for determining where to put the file.

Thanks.  Applied and pushed out.

I removed my own version of stop-gap hack; git-fetch-script
now directly calls git-http-pull.
