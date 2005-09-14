From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 21/22] teach the merge algorithm about cache iterators
Date: Wed, 14 Sep 2005 10:50:10 -0700
Message-ID: <7vbr2vlest.fsf@assigned-by-dhcp.cox.net>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
	<20050912145629.28120.70337.stgit@dexter.citi.umich.edu>
	<Pine.LNX.4.63.0509121633480.23242@iabervon.org>
	<43284368.8010004@citi.umich.edu>
	<Pine.LNX.4.63.0509141214490.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 19:50:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFbOi-00074O-Er
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 19:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbVINRuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 13:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVINRuN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 13:50:13 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53668 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030304AbVINRuL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 13:50:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914175011.MQJD24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 13:50:11 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509141214490.23242@iabervon.org> (Daniel
	Barkalow's message of "Wed, 14 Sep 2005 12:41:36 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8545>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Another thing to try would be the original dynamic table implementation, 
> plus a hashtable for name lookups, generated the first time a lookup is 
> attempted (since some programs don't do any lookups by name). This has the 
> advantage of skipping the O(n) startup.

How about just the original dynamic table implementation with
the original binary search name lookups?  Am I missing
something?
