From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do 3-way diff between HEAD, index and working directory
Date: Mon, 04 Sep 2006 15:23:16 -0700
Message-ID: <7vpsebl19n.fsf@assigned-by-dhcp.cox.net>
References: <17660.4160.642852.177249@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 00:22:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKMqG-0000qD-3s
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWIDWWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 18:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWIDWWx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:22:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:50597 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965009AbWIDWWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:22:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904222251.OFVC13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Mon, 4 Sep 2006 18:22:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JNNl1V00A1kojtg0000000
	Mon, 04 Sep 2006 18:22:45 -0400
To: Paul Mackerras <paulus@samba.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26440>

Paul Mackerras <paulus@samba.org> writes:

> This implements a 3-way diff between the HEAD commit, the state in the
> index, and the working directory.  This is like the n-way diff for a
> merge, and uses much of the same code.  It is invoked with the -c flag
> to git-diff-index, which it already accepted and did nothing with.
>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> Junio, does this look right?

Seems correct from a cursory look.  This also seems to change
the behaviour for an unmerged entry case slightly but I think
it is for the better (depending on the definition of "better" --
some people may feel combined diff to be weird and confusing).
