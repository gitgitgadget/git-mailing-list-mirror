From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 'git commit' duplicates parents?
Date: Sun, 19 Jun 2005 22:28:16 -0400
Message-ID: <42B629C0.6030008@pobox.com>
References: <42B59CF7.3080509@pobox.com> <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 04:22:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkBvl-0006aq-LL
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFTC2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVFTC2U
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:28:20 -0400
Received: from mail.dvmed.net ([216.237.124.58]:58007 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261164AbVFTC2T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 22:28:19 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DkC1K-0000IM-HX; Mon, 20 Jun 2005 02:28:18 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> As to why you had a .git/MERGE_HEAD in your tree, it's probably because 
> your merge scripts haven't kept up with mine.

Nope, I use vanilla latest ones.  FWIW my setup is 100% vanilla git plus 
two small scripts, 'git-switch-tree' and 'git-new-branch', which switch 
around .git/HEAD.

Doing some experimenting, it seems that git-pull-script does not remove 
MERGE_HEAD and ORIG_HEAD after its done.

This is reproducible by updating vanilla linux-2.6.git using vanilla 
git-pull-script.  Just a standard update-to-latest-kernel, with no 
conflicts/merges/etc.

	Jeff


