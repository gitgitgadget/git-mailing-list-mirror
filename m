From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to merge FETCH_HEAD?
Date: Tue, 16 Jan 2007 22:14:28 -0800
Message-ID: <7vk5zmtc1n.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701162235200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070117050955.GC4329@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 07:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H744J-0006GY-H4
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 07:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbXAQGOa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 01:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbXAQGOa
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 01:14:30 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:64693 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbXAQGO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 01:14:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117061428.JKBN7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 01:14:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id C6El1W00Z1kojtg0000000; Wed, 17 Jan 2007 01:14:46 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
In-Reply-To: <20070117050955.GC4329@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 17 Jan 2007 07:09:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36987>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

>> No. FETCH_HEAD is local. And for local merges, you should use git-merge, 
>> not git-pull.
>
> But, that can not take FETCH_HEAD either.
> Would it be useful for git-merge FETCH_HEAD to work?

Please try again, starting from the "git fetch".

I suspect the reason you think "merge FETCH_HEAD" does not work
is because you lost FETCH_HEAD when you did "git pull . FETCH_HEAD",
as I explained to you in an earlier message.
