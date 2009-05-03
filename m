From: elupus <elupus@ecce.se>
Subject: Re: git 1.5.4.3 push incorrectly honors grafts file
Date: Sun, 3 May 2009 19:14:22 +0200
Message-ID: <atsddmx5kuva.1fyy780hhh9t2$.dlg@40tude.net>
References: <d5uvsf40ln1i.fbvskgg1w9e6$.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 19:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0fH0-0004q9-5u
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 19:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504AbZECROd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 13:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbZECROd
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 13:14:33 -0400
Received: from main.gmane.org ([80.91.229.2]:45197 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbZECROc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 13:14:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M0fGl-0006hn-Ig
	for git@vger.kernel.org; Sun, 03 May 2009 17:14:27 +0000
Received: from ua-83-227-158-203.cust.bredbandsbolaget.se ([83.227.158.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 May 2009 17:14:27 +0000
Received: from elupus by ua-83-227-158-203.cust.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 May 2009 17:14:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ua-83-227-158-203.cust.bredbandsbolaget.se
User-Agent: 40tude_Dialog/2.0.15.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118179>

On Mon, 27 Apr 2009 17:51:05 +0200, elupus wrote:

> Hi, 
> 
> I recently had a problem with git push honoring the grafts file. It caused
> it not to push all data required for a branch to the remote repository,
> rendering it impossible to clone the remote repository (missing blobs)
> 
> This was with an not so fresh git version of 1.5.4.3 (ubuntu hardy).
> 
> Has this issue been fixed in later git version? I saw a thread talking
> about it a long time ago (long before my release in question) on this
> mailing list, but nothing was mentioned about if it was actually solved.
> 
> Regards
> Joakim Plate

Bump, anybody know of a way to avoid this? The problem even occurs on the
local machine in that git gc will cleanup stuff that isn't required due to
the grafts file, rendering the repo invalid if the graft file is removed.

I don't think running filter-branch on the git svn imported branches seems
like a good idea. since that would also wreak havoc on any repo that pulls
from mine (ie still private repo like usb stick or other dev machine). 

Imho, grafts shouldn't be honored on either push/pull/gc operations. 

Joakim
