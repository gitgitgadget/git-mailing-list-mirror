From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 17:47:54 -0700
Message-ID: <7vfy35iekl.fsf@assigned-by-dhcp.cox.net>
References: <20070730180710.GA64467@nowhere>
	<alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
	<20070730192922.GB64467@nowhere>
	<alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
	<7vy7gximkc.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707301624050.4161@woody.linux-foundation.org>
	<7vsl75igtt.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.999.0707301744050.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Craig Boston <craig@olyun.gank.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 02:48:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFfu3-0004Vz-VT
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 02:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934505AbXGaAr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 20:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933886AbXGaAr5
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 20:47:57 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:32857 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756806AbXGaAr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 20:47:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070731004756.HQMA7349.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 30 Jul 2007 20:47:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id W0nv1X0031kojtg0000000; Mon, 30 Jul 2007 20:47:56 -0400
In-Reply-To: <alpine.LFD.0.999.0707301744050.4161@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 30 Jul 2007 17:45:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54299>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 30 Jul 2007, Junio C Hamano wrote:
>> 
>> I guess so, but can higher stage entries have cached stat
>> information that are valid and match the working tree?
>
> Probably unlikely, but I could imagine that it's the case for things that 
> failed to merge entirely (ie binaries), where you end up just saying "pick 
> the old/base binary", and it ends up matching in stage1.

Probably.  In any case, what I'll commit will have the stage#0
check, just to be safe anyway.

Thanks for the sanity.  Really appreciate it.
