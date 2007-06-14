From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 00:49:05 -0700
Message-ID: <7vps3zascu.fsf@assigned-by-dhcp.pobox.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
	<alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 09:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyk5L-0003EE-Dw
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 09:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbXFNHtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 03:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbXFNHtI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 03:49:08 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37316 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbXFNHtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 03:49:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070614074906.VLRF3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Jun 2007 03:49:06 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id BKp61X0011kojtg0000000; Thu, 14 Jun 2007 03:49:07 -0400
In-Reply-To: <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 13 Jun 2007 22:21:38 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50175>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It might make it a bit easier for CVS people to get used to the git model: 
> keep your dirty working tree, and do "git pull" to update it, and fix up 
> any conflicts in the working tree. That's how CVS works - it's a bad 
> model, but it's a model that may be worth supporting just to get people 
> more easily into the _good_ model.

If a bad model _is_ supported, what incentive is there for these
people to move into the good model, I honestly wonder...
