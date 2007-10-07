From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 03:43:47 +0400
Message-ID: <20071007234346.GA29433@potapov>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <20071007221920.GF2765@steel.home> <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:44:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iefmy-0007AU-Jz
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041AbXJGXnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756035AbXJGXnu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:43:50 -0400
Received: from smtp05.mtu.ru ([62.5.255.52]:49515 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755968AbXJGXnu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:43:50 -0400
Received: from potapov.private (ppp85-140-171-1.pppoe.mtu-net.ru [85.140.171.1])
	by smtp05.mtu.ru (Postfix) with ESMTP id DD9D398451C;
	Mon,  8 Oct 2007 03:43:47 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l97NhlEq032068;
	Mon, 8 Oct 2007 03:43:47 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l97NhlNo032067;
	Mon, 8 Oct 2007 03:43:47 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to dpotapov@gmail.com using -f
Content-Disposition: inline
In-Reply-To: <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60266>

On Sun, Oct 07, 2007 at 04:24:49PM -0600, Elijah Newren wrote:
> $ git reflog expire --all
> $ git gc --aggressive --prune

I believe this should work:

git reflog expire --all --expire-unreachable=0
git gc --prune

Warning: all unreachable references will be removed!

Dmitry
