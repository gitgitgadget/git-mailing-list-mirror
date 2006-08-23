From: Junio C Hamano <junkio@cox.net>
Subject: Re: git cherry-pick feature request
Date: Wed, 23 Aug 2006 02:51:10 -0700
Message-ID: <7vfyfnixv5.fsf@assigned-by-dhcp.cox.net>
References: <17643.62896.396783.890223@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 11:51:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFpOI-0002tG-82
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 11:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWHWJvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 05:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWHWJvN
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 05:51:13 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41895 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751515AbWHWJvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 05:51:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823095111.ZVGL12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Aug 2006 05:51:11 -0400
To: Paul Mackerras <paulus@samba.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25905>

Paul Mackerras <paulus@samba.org> writes:

> Could I have a flag to git cherry-pick (-q for quiet, maybe) that
> tells it not to print anything if the command succeeds?  Could I also
> have a flag that tells it to clean up if the merge fails and leave the
> tree in its previous state?

Quiet sounds sane.

Reverting to its "previous state" I am not quite sure if it is
worth making it an option and run it as part of cherry-pick.
