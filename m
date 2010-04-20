From: Stephen Kelly <steveire@gmail.com>
Subject: Re: SVN to Git: trunk moved during repository history
Date: Tue, 20 Apr 2010 02:07:40 +0200
Message-ID: <hqir8c$sqh$1@dough.gmane.org>
References: <l2x2f0f6ced1004191416jd8db7d5eyf8fc7a55f5efa2cc@mail.gmail.com> <o2i2f0f6ced1004191418i6a144652sd9ac38b07fb7b661@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 02:08:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O410S-0005P7-Gn
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 02:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab0DTAHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 20:07:55 -0400
Received: from lo.gmane.org ([80.91.229.12]:56148 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164Ab0DTAHy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 20:07:54 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O410L-0005Mz-1k
	for git@vger.kernel.org; Tue, 20 Apr 2010 02:07:53 +0200
Received: from dslb-188-103-017-106.pools.arcor-ip.net ([188.103.17.106])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 02:07:53 +0200
Received: from steveire by dslb-188-103-017-106.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 02:07:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-188-103-017-106.pools.arcor-ip.net
User-Agent: KNode/4.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145345>

Bradley Wagner wrote:

> I'm trying to port an SVN project to Git. We have gone through
> multiple layouts for our SVN repository. It started off with just a
> mainline branch in the root folder. Then we went to the standard
> layout (branches, trunk, tags).
> 
> The problem is that when I do a "git svn clone --stdlayout" of the
> repository, it's not picking up any of the revisions from when the
> trunk previously resided in the root directory.
> Is there any way to specify that the trunk had multiple paths the way
> you can specify multiple branch folders with -b flag? What would be
> the best course of action for reporting an SVN repo who's layout had
> changed during its history?

One option is svn2git

http://gitorious.org/svn2git/svn2git

http://techbase.kde.org/Projects/MoveToGit/UsingSvn2Git

examples:

http://gitorious.org/svn2git/kde-ruleset

> 
> Thanks,
> Bradley
