From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make xstrndup common
Date: Wed, 02 May 2007 22:07:39 -0700
Message-ID: <7vvefa336s.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705022248040.28708@iabervon.org>
	<7vzm4m35xm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705030100050.28708@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 03 07:07:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjTXc-00054E-7D
	for gcvg-git@gmane.org; Thu, 03 May 2007 07:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767389AbXECFHl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 01:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767392AbXECFHl
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 01:07:41 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50665 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767389AbXECFHk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 01:07:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070503050741.XJVA24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 3 May 2007 01:07:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uV7f1W00B1kojtg0000000; Thu, 03 May 2007 01:07:40 -0400
In-Reply-To: <Pine.LNX.4.64.0705030100050.28708@iabervon.org> (Daniel
	Barkalow's message of "Thu, 3 May 2007 01:02:22 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46063>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> Why strncpy() not memcpy()?
>
> Left over from my previous attempt. memcpy() is better with the length 
> check.

Ok, I was just sanity checking myself.  Will apply with the
change.

Thanks.
