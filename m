From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Add support for grep searches
Date: Thu, 26 Apr 2007 21:34:50 -0700
Message-ID: <7vtzv2ph91.fsf@assigned-by-dhcp.cox.net>
References: <20070427034138.1646.15989.stgit@rover>
	<20070427034729.GU4489@pasky.or.cz>
	<alpine.LFD.0.98.0704262055270.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 27 06:34:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIAa-0005ri-By
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 06:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbXD0Eex (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 00:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755264AbXD0Eex
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 00:34:53 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:63953 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbXD0Eew (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 00:34:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427043452.JGWG1226.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Apr 2007 00:34:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id s4ar1W00A1kojtg0000000; Fri, 27 Apr 2007 00:34:51 -0400
In-Reply-To: <alpine.LFD.0.98.0704262055270.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 26 Apr 2007 20:59:29 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45684>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 27 Apr 2007, Petr Baudis wrote:
>> 
>> 	http://repo.or.cz/w?p=git.git&a=search&h=HEAD&st=grep&s=hate%5B%5Ev%5D
>
> That looks bogus. It doesn't find
>
>  - Documentation/git-cvsimport.txt:
>
> 	git-cvsimport - Salvage your data out of another SCM people love to hate
>
> Why?

Because he uses "hate[^v]" to exclude "whatever" from matching,
but the line you quoted does not have anything after "hate".
