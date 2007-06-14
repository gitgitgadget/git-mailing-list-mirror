From: Olivier Galibert <galibert@pobox.com>
Subject: Re: pull into dirty working tree
Date: Thu, 14 Jun 2007 22:20:27 +0200
Message-ID: <20070614202027.GA47039@dspnet.fr.eu.org>
References: <18031.64456.948230.375333@lisa.zopyra.com> <alpine.LFD.0.98.0706132216300.14121@woody.linux-foundation.org> <18033.14520.846510.640130@lisa.zopyra.com> <alpine.LFD.0.98.0706140836450.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 22:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyvnx-0001hd-WA
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 22:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbXFNUU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 16:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbXFNUU3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 16:20:29 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:2503 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbXFNUU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 16:20:28 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 740D3A4987; Thu, 14 Jun 2007 22:20:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706140836450.14121@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50218>

On Thu, Jun 14, 2007 at 08:46:27AM -0700, Linus Torvalds wrote:
> So it might be easier to take a "git stash ; git pull ; git unstash" 
> approach instead of making "git pull" handle working tree conflicts 
> itseld.

Isn't that "git add .; git commit; git fetch; git rebase <something>;
git reset ^HEAD"?  With the conflict resolution happening at rebase
time.

  OG.
