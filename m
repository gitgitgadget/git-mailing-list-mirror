From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: use SVN::Ra::get_dir2 when possible
Date: Fri, 31 Oct 2014 21:42:17 +0000
Message-ID: <20141031214217.GA15591@dcvr.yhbt.net>
References: <1414789740.30576.BPMail_high_carrier@web172302.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, stoklund@2pi.dk, fabian.schmied@gmail.com,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:42:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkJxe-0006hx-HG
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 22:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbaJaVmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 17:42:18 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48765 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbaJaVmR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 17:42:17 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD0C1F838;
	Fri, 31 Oct 2014 21:42:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414789740.30576.BPMail_high_carrier@web172302.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> On Fri, Oct 31, 2014 19:08 GMT Eric Wong wrote:
> >Filed a bug in Debian since I hit it in sid, too:
> >http://bugs.debian.org/767530
> >
> >Thanks all.
> 
> Hmm, but why are you filing at debian? I had the error when i applied
> the dev code patches on top of 2.1.0, and the error disappeared as
> soon as I reverted the patches. So it looks like a issue for the
> upstream developers, rather than distro. Are you saying debian is
> shipping a dev snapshot of git svn?

I don't track SVN upstream development, so haven't checked if it affects
newer SVN, yet.  It is the distro maintainer's job to get this resolved.

This bug affects existing cases of "git svn show-ignore",
we just happened to find it with "git svn fetch", first.

Debian's bug tracker also has the lowest barrier to entry:
no login/registration is necessary (just like this git list).
If you want to handle this with upstream directly, please do.
I try to avoid logins/accounts as much as possible.
