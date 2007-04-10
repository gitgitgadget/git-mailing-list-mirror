From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 11/10] allow forcing index v2 and 64-bit offset treshold
Date: Tue, 10 Apr 2007 00:31:24 -0700
Message-ID: <7vlkh0wur7.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.98.0704091727300.28181@xanadu.home>
	<7vps6dxjvb.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704091901290.28181@xanadu.home>
	<7vejmtxekj.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704092046080.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 11:53:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbAp7-00066f-Et
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 09:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXDJHb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 03:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbXDJHb0
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 03:31:26 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:39293 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXDJHbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 03:31:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070410073123.SYNY1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 10 Apr 2007 03:31:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id lKXQ1W00G1kojtg0000000; Tue, 10 Apr 2007 03:31:24 -0400
In-Reply-To: <alpine.LFD.0.98.0704092046080.28181@xanadu.home> (Nicolas
	Pitre's message of "Mon, 09 Apr 2007 21:03:35 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44115>

Nicolas Pitre <nico@cam.org> writes:

>> They are _not_ even in 'pu'.  I am talking about things that
>> have been cooking.
>
> Remember that positive comments are by default much less verbose than 
> negative ones. In other words, no news is probably good news.

No news means one or more of the following:

 - Immediately before 1.5.1, people were asked to test 'master'
   rigorously, and they did, and they are still on 'master'.
   Nobody noticed breakages in 'next'.

 - Some people use 'next' but the new features, fixes or
   enhancements the topics introduce are totally irrelevant to
   how they use git, so problems are not noticed.  This would
   indicate that some of the topics may not even deserve to
   be in 'next'.

 - Most people are generally 'wait and see' and even when warned
   that some new features cooking in 'next' may change the user
   experience (even in good ways), they do not try to see if the
   change may adversely affect them to voice their objection
   early, to catch the changes they do not like before they
   graduate to 'master', and then complain.  This would indicate
   that it is futile to have 'next' as a holding area.  It would
   be more effective to push out unproven stuff on 'master' to
   make sure people complain.

None of the above does not sound a good news at all to me.

>> >> > ddiff --git a/t/Makefile b/t/Makefile
>> >> 
>> >> ???
>
> $ touch t/Makefile
> $ git diff

This still does not give me doubled d in diff.
