From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add -C[NUM] to git-am
Date: Wed, 07 Feb 2007 12:23:50 -0800
Message-ID: <7vejp17m3t.fsf@assigned-by-dhcp.cox.net>
References: <20070207201511.GF12140@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Feb 07 21:23:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtKd-0005tJ-76
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 21:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbXBGUXw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 15:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbXBGUXw
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 15:23:52 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54208 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422770AbXBGUXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 15:23:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207202352.PBRM1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 15:23:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LkPq1W00z1kojtg0000000; Wed, 07 Feb 2007 15:23:51 -0500
In-Reply-To: <20070207201511.GF12140@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 7 Feb 2007 22:15:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38961>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Add -C[NUM] to git-am so that patches can be applied even
> if context has changed a bit.
>
> Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
>
> ---
>
> I just had to apply a largish number of patches on a project
> that has evolved since, and I found the following to be useful.
>
> What do others think.

FWIW, I am in favor although I do not foresee myself ever using
it.  However, this has slight ramifications.

 - we will be keeping applymbox after all.  shouldn't this be
   side-ported to it?

 - am is used as a workhorse for rebase.  shouldn't this be
   accessible through its command line as well?

The same goes for Andy's --patchdepth thing.
