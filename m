From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] git-rev-list(1): group options; reformat; document more options
Date: Fri, 1 Sep 2006 01:08:11 +0200
Message-ID: <20060831230811.GE482@diku.dk>
References: <20060831223715.GC482@diku.dk> <Pine.LNX.4.64.0608311557470.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 01 01:08:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIvdz-0004XF-Mi
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 01:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWHaXIQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 19:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWHaXIQ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 19:08:16 -0400
Received: from [130.225.96.91] ([130.225.96.91]:60620 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750751AbWHaXIP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 19:08:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 95C4777004C;
	Fri,  1 Sep 2006 01:08:12 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08762-12; Fri,  1 Sep 2006 01:08:11 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 766D5770007;
	Fri,  1 Sep 2006 01:08:11 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A864C6DF88D; Fri,  1 Sep 2006 01:06:44 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5DE3E62A06; Fri,  1 Sep 2006 01:08:11 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608311557470.27779@g5.osdl.org>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26286>

Linus Torvalds <torvalds@osdl.org> wrote Thu, Aug 31, 2006:
> 
> 
> On Fri, 1 Sep 2006, Jonas Fonseca wrote:
> >
> > An attempted facelift to the neglected git-rev-list manpage. One
> > question if I may, the diff-related -r and -t options, how are they
> > supposed to work?
> 
> Umm? You should get a "usage" error, no?

Yes, ok, they do not seem to make sense for git-rev-list, however if you
pass either to git-log, the output seems to make room for a diff, adding
one extra newline, but without appending any diff.

-- 
Jonas Fonseca
