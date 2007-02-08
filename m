From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add -C[NUM] to git-am
Date: Wed, 07 Feb 2007 23:52:09 -0800
Message-ID: <7vfy9h13yu.fsf@assigned-by-dhcp.cox.net>
References: <7vejp17m3t.fsf@assigned-by-dhcp.cox.net>
	<20070207211910.GK12140@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu Feb 08 08:52:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF44l-0003mo-VV
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 08:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161451AbXBHHwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 02:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161515AbXBHHwL
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 02:52:11 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:47413 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161451AbXBHHwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 02:52:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208075210.XIJK4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 02:52:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Lvs91W00J1kojtg0000000; Thu, 08 Feb 2007 02:52:10 -0500
In-Reply-To: <20070207211910.GK12140@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 7 Feb 2007 23:19:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39038>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

>> Quoting r. Junio C Hamano <junkio@cox.net>:
>> 
>> FWIW, I am in favor although I do not foresee myself ever using
>> it.  However, this has slight ramifications.
>> 
>>  - we will be keeping applymbox after all.  shouldn't this be
>>    side-ported to it?
>
> OK.
>
>>  - am is used as a workhorse for rebase.  shouldn't this be
>>    accessible through its command line as well?
>
> How will it be used?

Although I do not foresee myself using -C<num> that applies to
the whole series inexactly for "git am" to begin with, I would
imagine somebody who wants to say "git am -C1" may want to say
something like "git rebase -C1 origin/master",
