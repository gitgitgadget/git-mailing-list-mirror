From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix up "git log --follow" a bit..
Date: Thu, 21 Jun 2007 12:30:46 -0700
Message-ID: <7vbqf9w1eh.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706211017190.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 21:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1SMs-0004fy-NR
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 21:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbXFUTas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 15:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXFUTas
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 15:30:48 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:48192 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXFUTar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 15:30:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621193047.VBAV17635.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 15:30:47 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id EKWm1X0041kojtg0000000; Thu, 21 Jun 2007 15:30:46 -0400
In-Reply-To: <alpine.LFD.0.98.0706211017190.3593@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 21 Jun 2007 10:22:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50651>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> As to "diff_queued_diff", I think it would be better off not as a global 
> at all, but as being just an entry in the "struct diff_options" structure, 
> but that's a separate issue, and there may be some subtle reason for why 
> it's currently a global.

There is no subtle issue that I know of, but I have to double
check.  It is just that the code is one of the most ancient part
of the system by now.
