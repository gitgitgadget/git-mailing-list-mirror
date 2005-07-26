From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Add git-request-pull-script, a short script that generates a summary of pending changes
Date: Tue, 26 Jul 2005 03:36:57 -0400
Message-ID: <20050726073657.GK6098@mythryan2.michonline.com>
References: <20050726073036.GJ6098@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 26 09:37:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxK0K-000203-AI
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 09:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVGZHhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 03:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVGZHhH
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 03:37:07 -0400
Received: from mail.autoweb.net ([198.172.237.26]:59022 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261837AbVGZHhA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 03:37:00 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DxJzm-00014q-FI; Tue, 26 Jul 2005 03:36:58 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DxK8a-0006Hx-00; Tue, 26 Jul 2005 03:46:04 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DxJzl-0004vU-Sk; Tue, 26 Jul 2005 03:36:57 -0400
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050726073036.GJ6098@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 26, 2005 at 03:30:36AM -0400, Ryan Anderson wrote:
> 
> A short message requesting a pull from the repository is also included.

And, an example (which has a correct version of my fixes to
git-rename-script included in it.)

To generate this I used:
	git request-pull origin x rsync://h4x0r5.com/git-ryan.git/

The git repository at:
    rsync://h4x0r5.com/git-ryan.git/
contains the following changes since commit 154d3d2dd2656c23ea04e9d1c6dd4e576a7af6de

Ryan Anderson:
  Add git-request-pull-script, a short script that generates a summary of pending changes
  Make git-rename-script behave much better when faced with input contain Perl
  Update the documentation for git-tag-script to reflect current behavior.
  Add documentation for git-rename-script
  Add support for directories to git-rename-script.

 Documentation/git-rename-script.txt |   34 ++++++++++++++++
 Documentation/git-tag-script.txt    |   12 +++--
 Makefile                            |    3 -
 git-rename-script                   |   74 +++++++++++++++++++++++++++++++++---
 git-request-pull-script             |   36 +++++++++++++++++
 5 files changed, 149 insertions(+), 10 deletions(-)

-- 

Ryan Anderson
  sometimes Pug Majere
