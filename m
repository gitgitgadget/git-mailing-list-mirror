From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Re: Most elegant way to reference to SVN from GIT?
Date: Sun, 18 Sep 2011 13:20:47 +0200
Message-ID: <j54keg$ug9$1@dough.gmane.org>
References: <j53c2h$gff$2@dough.gmane.org> <20110918034318.GC17977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 13:26:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5FVX-0005jj-ST
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 13:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab1IRLZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 07:25:18 -0400
Received: from lo.gmane.org ([80.91.229.12]:56198 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935Ab1IRLZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 07:25:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R5FUq-0005TA-K9
	for git@vger.kernel.org; Sun, 18 Sep 2011 13:25:16 +0200
Received: from p4fd19684.dip0.t-ipconnect.de ([79.209.150.132])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 13:25:16 +0200
Received: from Manuel.Spam by p4fd19684.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 13:25:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fd19684.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0.2) Gecko/20110902 Firefox/6.0.2 SeaMonkey/2.3.3
In-Reply-To: <20110918034318.GC17977@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181604>

Jeff King wrote:
> You can pull their commits into git using git-svn, and then merge them.

Tried that, but maybe I did something wrong.

If I have a git-svn repo inside my git repo, then for some reason my own repo 
doesn't known the git-svn repo. Means that I cannot push changes, that occured 
in the SVN repo, to my GIT server.

So I'm still searching for an elegant way to get SVN into my GIT repo. As 
submodules make it more difficult to clone the project, I think it would be nice 
to be just able to fetch the stuff from SVN "commit by commit" and then have 
them as git commits in my own tree. So far I wasn't able to get this done...

Yours

Manuel
