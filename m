From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Finally implement "git log --follow"
Date: Wed, 20 Jun 2007 18:37:59 -0700
Message-ID: <7v4pl25bpk.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706191358180.3593@woody.linux-foundation.org>
	<alpine.LFD.0.98.0706201811440.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 03:38:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Bcm-00031b-Al
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 03:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbXFUBiB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 21:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753383AbXFUBiB
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 21:38:01 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44799 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbXFUBiB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 21:38:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621013759.OBHD6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 21:37:59 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E1dz1X0081kojtg0000000; Wed, 20 Jun 2007 21:37:59 -0400
In-Reply-To: <alpine.LFD.0.98.0706201811440.3593@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 20 Jun 2007 18:15:11 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50581>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> My burping and scratching wasn't really *meant* to be part of the official 
> record, but hey, there you have it.

Well, burping and scratching is already part of the public
record ;-)  gmane hopefully remembers it forever.

But you are right.  I should re-do that one when moving it to master.
