From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-files -m lists the same file multiple times
Date: Wed, 25 Apr 2007 11:25:45 -0700
Message-ID: <7v8xcgz4ye.fsf@assigned-by-dhcp.cox.net>
References: <200704251035.33713.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 20:25:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgmBh-0006AQ-R0
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 20:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423377AbXDYSZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 14:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423378AbXDYSZr
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 14:25:47 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62244 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423377AbXDYSZr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 14:25:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425182546.SESP22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 14:25:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rWRl1W00G1kojtg0000000; Wed, 25 Apr 2007 14:25:46 -0400
In-Reply-To: <200704251035.33713.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 25 Apr 2007 10:35:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45540>

Andy Parkins <andyparkins@gmail.com> writes:

> I did a merge, which had conflicts, and then fixed the conflicts.  To see what 
> files I'd changed I did git-ls-files -m.  This listed the same file multiple 
> times.  Some of them twice and some of them three times.
>
> I guess that it's showing different stages; but as the list is just filename, 
> there is no way to tell which is which and it is just confusing.

I did not imagine that anybody actually found 'ls-files -m'
useful, either during a conflicted merge or under the normal
situation.  'git diff --stat' is usually much more pleasant to
see.

Use 'ls-files -u' during conflicted merge and be happy.
