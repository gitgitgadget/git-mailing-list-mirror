From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCHv2] put FETCH_HEAD data in merge commit message
Date: Wed, 21 Mar 2007 11:09:00 -0700
Message-ID: <7vmz261nb7.fsf@assigned-by-dhcp.cox.net>
References: <20070321120643.GI20583@mellanox.co.il>
	<20070321172916.GC5233@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Mar 21 19:09:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU5FF-0004o6-4r
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 19:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbXCUSJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752310AbXCUSJF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 14:09:05 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42987 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbXCUSJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 14:09:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321180903.CTHX18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 14:09:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dW931W0061kojtg0000000; Wed, 21 Mar 2007 14:09:03 -0400
In-Reply-To: <20070321172916.GC5233@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 21 Mar 2007 19:29:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42810>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> Quoting Michael S. Tsirkin <mst@dev.mellanox.co.il>:
>> Subject: [PATCH] have merge put FETCH_HEAD data in commit message
>> 
>> Hi!
>> I often like to fetch some code from others, review and
>> then merge. So:
>> 
>> git fetch <URL>
>> git log -p FETCH_HEAD
>> git merge FETCH_HEAD
>> 
>> which is all good but gets me this message in commit log:
>> 
>>     Merge commit 'FETCH_HEAD' into master
>> 
>> which is not very informative.
>> I can always fix this up with git commit --amend, but
>> I'd like to avoid the extra step.
>> 
>> Would the following patch be appropriate?
>
> OK, I since discovered git-fmt-merge-msg does all the necessary formatting,
> so here's a better and smaller patch. Seems to work well for me.
>
> Junio, could you apply this?

I am afraid not.  You missed all the points I raised in my reply.
