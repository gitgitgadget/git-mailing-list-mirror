From: Ryan Anderson <ryan@michonline.com>
Subject: [MERGE] Combine git-tools repository into example-tools/ subdirectory of git
Date: Sat, 16 Jul 2005 03:55:53 -0400
Message-ID: <20050716075553.GI20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 16 09:56:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DthWv-0001RS-0i
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 09:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVGPH4A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 03:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVGPH4A
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 03:56:00 -0400
Received: from mail.autoweb.net ([198.172.237.26]:16365 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261413AbVGPHz5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2005 03:55:57 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DthWc-0005HZ-7g; Sat, 16 Jul 2005 03:55:54 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dthdr-0005c0-00; Sat, 16 Jul 2005 04:03:23 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DthWb-0000Km-Eb; Sat, 16 Jul 2005 03:55:53 -0400
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Linus, it seems, well, odd to me that you maintain two different git
trees.

So I used your example of the gittk merge to move git-tools into the
main git-repository.

Summary of changes:
1) Create an example-tools directory

2) Move all of the git-tools tree, except the outdated cvs2git script
into this directory.

3) Rename dotest to applymbox

4) Minor cleanup inside applymbox of comments to apply to the new name.

Given that I don't think anyone wants to look at the diff of this, with
all the git history involved, I have a git tree up at:

	rsync://h4x0r5.com::git-ryan.git/

-- 

Ryan Anderson
  sometimes Pug Majere
