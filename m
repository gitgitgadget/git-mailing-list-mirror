From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Anomaly with the new code - Re: git-svn performance
Date: Mon, 27 Oct 2014 06:38:18 +0000
Message-ID: <20141027063818.GA17332@dcvr.yhbt.net>
References: <1414214985.98758.BPMail_high_carrier@web172306.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 07:38:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xidwd-0004Kw-O6
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 07:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbaJ0GiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 02:38:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47156 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbaJ0GiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 02:38:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02421F624;
	Mon, 27 Oct 2014 06:38:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414214985.98758.BPMail_high_carrier@web172306.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> On Sat, Oct 25, 2014 00:34 BST Eric Wong wrote:
> >0006 is insufficient and incompatible with older SVN.
> >I pushed "git-svn: reload RA every log-window-size"
> >(commit dfa72fdb96befbd790f623bb2909a347176753c2) instead
> >which saves much more memory:
>
> it is fetching against the new clone taking twice as long and
> consuming twice as much memory.

Which SVN version are you using?  I'm cloning (currently on r373xx)
https://svn.r-project.org/R using --stdlayout and
unable to see memory growth of the git-svn Perl process beyond 40M
(on a 32-bit system).

I also tried http:// (not https), svn+ssh:// on my local (64-bit) system
and did not see memory growth, either:

	http://mid.gmane.org/20141027014033.GA4189@dcvr.yhbt.net

I'm using svn 1.6.17 on Debian stable in all cases.
