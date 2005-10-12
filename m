From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] gitk: Add "Refs" menu
Date: Tue, 11 Oct 2005 21:26:20 -0400
Message-ID: <1129080380.2427.21.camel@dv>
References: <1128559088.32103.8.camel@dv>
	 <17227.44393.412591.267878@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 12 03:27:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPVO3-0000Be-Lk
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 03:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVJLB02 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 21:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVJLB02
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 21:26:28 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:27549 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751128AbVJLB01
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 21:26:27 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EPVNw-0003Ef-1R
	for git@vger.kernel.org; Tue, 11 Oct 2005 21:26:24 -0400
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EPVNs-0002iA-UD; Tue, 11 Oct 2005 21:26:20 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17227.44393.412591.267878@cargo.ozlabs.ibm.com>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9997>

Hi, Paul!

On Tue, 2005-10-11 at 22:17 +1000, Paul Mackerras wrote:
> Pavel Roskin writes:
> 
> > This patch adds "Refs" menu to gitk.  It makes all branches, tags and
> > other ref objects appear as menu items.  Selecting one of the items
> > selects the corresponding line in the view.
> 
> Sorry I haven't responded before - I have got way behind with my email
> due to a vacation and to concentrating on the merge of the ppc32 and
> ppc64 kernel sources.  It will probably be a bit longer before I can
> get to look at this.

No problem.  Thank you for letting me know.

I'm not a GUI designer and I'm not experienced in Tcl/Tk, so I'll
appreciate critical look at the patches.

I think that gitk should move away from being just a frontend to
git-rev-list.  There is more information in the repository, such as
tags, branches, stgit patches etc.  All this information needs to be
represented in some way, and using the menu was just the first approach.

Browsing trees and opening files for a given commit would be great and
helpful from developers migrating from CVS.

And making gitk cooperate with stgit would be a killer application not
just for gitk and stgit, but for git itself (i.e. it could be the reason
why git is chosen for development over e.g. Mercurial for new projects).

I don't want to distract you from PPC work, but your return to gitk
development would be very welcome :-)

-- 
Regards,
Pavel Roskin
