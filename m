From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Anomaly with the new code - Re: git-svn performance
Date: Mon, 27 Oct 2014 16:56:50 +0000
Message-ID: <20141027165650.GA18752@dcvr.yhbt.net>
References: <1414214985.98758.BPMail_high_carrier@web172306.mail.ir2.yahoo.com>
 <20141027063818.GA17332@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 17:56:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XinbE-0000wA-0n
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 17:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbaJ0Q4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 12:56:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53874 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbaJ0Q4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 12:56:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 7B9831F624;
	Mon, 27 Oct 2014 16:56:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141027063818.GA17332@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> wrote:
> Which SVN version are you using?  I'm cloning (currently on r373xx)
> https://svn.r-project.org/R using --stdlayout and
> unable to see memory growth of the git-svn Perl process beyond 40M
> (on a 32-bit system).

git-svn hit 45M and took 11:44 to finish.   My ping times to
svn.r-project.org is around 150ms (I'm running this from a server in
Fremont, California).  I'll keep the repo around and periodically fetch
to see how it runs.
