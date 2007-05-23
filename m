From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add another verbosity level to git-fetch
Date: Wed, 23 May 2007 14:53:13 -0700
Message-ID: <7viraj1a2e.fsf@assigned-by-dhcp.cox.net>
References: <20070523213113.GF2554@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 23:53:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqylk-0005RG-Up
	for gcvg-git@gmane.org; Wed, 23 May 2007 23:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbXEWVxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 17:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756065AbXEWVxP
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 17:53:15 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:65208 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbXEWVxP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 17:53:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523215315.EOEU19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 17:53:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2ltD1X0061kojtg0000000; Wed, 23 May 2007 17:53:13 -0400
In-Reply-To: <20070523213113.GF2554@steel.home> (Alex Riesen's message of
	"Wed, 23 May 2007 23:31:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48181>

Alex Riesen <raa.lkml@gmail.com> writes:

> Use "-v -v" to run git-fetch-pack in verbose mode.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Otherwise there is no way to show connect messages for git-fetch

How about just a single -v to do so?
