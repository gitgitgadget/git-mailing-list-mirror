From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Anomaly with the new code - Re: git-svn performance
Date: Sat, 25 Oct 2014 05:51:18 +0000
Message-ID: <20141025055118.GB30872@dcvr.yhbt.net>
References: <1414214985.98758.BPMail_high_carrier@web172306.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 20:51:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi6QV-0001gg-E8
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 20:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbaJYSuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 14:50:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47619 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619AbaJYSux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 14:50:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0851FB0D;
	Sat, 25 Oct 2014 05:51:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414214985.98758.BPMail_high_carrier@web172306.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> On Sat, Oct 25, 2014 00:34 BST Eric Wong wrote:
> >Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> >> 0006-git-svn-clear-global-SVN-pool-between-get_log-invoca.patch   
> >
> >0006 is insufficient and incompatible with older SVN.
> >I pushed "git-svn: reload RA every log-window-size"
> >(commit dfa72fdb96befbd790f623bb2909a347176753c2) instead
> >which saves much more memory:
> >
> it is fetching against the new clone taking twice as long and
> consuming twice as much memory.

Ugh, I've only tested "git-svn: reload RA every log-window-size" with
file:// repos so far, so it looks like I'll need to setup remote repos
on my test system to test.
