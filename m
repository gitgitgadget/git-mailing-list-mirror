From: Eric Davis <endavis@gmail.com>
Subject: git stash clear
Date: Wed, 10 Oct 2007 12:42:33 -0400
Message-ID: <feivdo$sgi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 20:14:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifg4o-0000eM-AK
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 20:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924AbXJJSOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 14:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619AbXJJSOZ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 14:14:25 -0400
Received: from main.gmane.org ([80.91.229.2]:60313 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753874AbXJJSOY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 14:14:24 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Iffva-0008Ac-7g
	for git@vger.kernel.org; Wed, 10 Oct 2007 18:05:02 +0000
Received: from 128.164.129.241 ([128.164.129.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 18:05:02 +0000
Received: from endavis by 128.164.129.241 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 18:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 128.164.129.241
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60524>

Hey Everyone,

  I have a problem that happened when using git stash.

I was working on a branch and applied a stash to it.  There were no
conflicts. I figured I was done with the stuff in stash, so I did a git
stash clear.  Not good.  It also reverted my branch to before I did the
stash apply and now I have none of the changes because the stash is also
gone.  Is this by design?  If so, why?

Is there anyway to get this stash back?


Thanks,
Eric
