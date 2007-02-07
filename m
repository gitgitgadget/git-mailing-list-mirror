From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH for 'next'] fast-import: in_merge_bases() has a different signature now
Date: Wed, 07 Feb 2007 13:05:27 -0800
Message-ID: <7vtzxx65m0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702071235370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 22:05:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtyu-0005J6-L5
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 22:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbXBGVFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 16:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422743AbXBGVF3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 16:05:29 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:35784 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422724AbXBGVF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 16:05:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207210528.PDJH1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 16:05:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ll5U1W0041kojtg0000000; Wed, 07 Feb 2007 16:05:28 -0500
In-Reply-To: <Pine.LNX.4.63.0702071235370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 7 Feb 2007 12:37:32 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38967>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The function in_merge_bases() can take more than one reference now,
> and therefore we need to call it differently.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Yes, yes, I know. BAD Dscho. Still not using master. Maybe 
> 	tomorrow I will find the time to rebase my changes on top of
> 	next to master. That will be my first experience with git-rebase!

Thanks for a heads-up.

It _might_ be worth merging the in_merge_bases() from 'next' to
'master', either up to 03840fc3 or all the way to dc3806d3.

But I'd resist the temptation for now.
