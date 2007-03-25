From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge strategy request
Date: Sun, 25 Mar 2007 00:17:59 -0700
Message-ID: <7v648paj14.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz>
	<Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703242130050.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 25 09:18:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVMzN-0001SD-IV
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 09:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbXCYHSC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 03:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbXCYHSB
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 03:18:01 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:51498 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbXCYHSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 03:18:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325071800.OZNX1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Mar 2007 03:18:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id evHz1W0051kojtg0000000; Sun, 25 Mar 2007 03:18:00 -0400
In-Reply-To: <Pine.LNX.4.64.0703242130050.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 24 Mar 2007 21:31:45 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43037>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 25 Mar 2007, Johannes Schindelin wrote:
>> 
>> Basically, just write a program named "git-merge-david-lang", which takes 
>> arguments of the form
>> 
>> 	merge-base [merge-base2...] -- head remote [remote...]
>
> I think you are missing what David wants.
>
> David does *not* want a new global strategy. Adding those is fairly easy.
>
> David seems to want a new per-file merge strategy, with the bog-standard 
> recursive merge. We've talked about that possibility in the past, but we 
> don't do it now. We always end up doing just the three-way merge.
>
> 		Linus

Right.  In the current system, git-mergetool might be a better
place to add support for special perpose 3-version file-level
merge backend than merge-recursive, at least until gitattributes
materializes.
