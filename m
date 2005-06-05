From: Zack Brown <zbrown@tumblerings.org>
Subject: cg-init bug
Date: Sun, 5 Jun 2005 08:30:53 -0700
Message-ID: <20050605153053.GA6890@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 17:28:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dex2F-0005DZ-1e
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 17:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVFEPbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 11:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFEPbD
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 11:31:03 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:19692 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261543AbVFEPa7
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 11:30:59 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1Dex5R-00030a-9z; Sun, 05 Jun 2005 08:30:53 -0700
To: pasky@ucw.cz
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I've been tracking Cogito. This problem occurred with Cogito version
1e2673d606dd39dc44b4eed2204ba349a448bc4d

I have a directory tree with several layers of subdirectories and about 1700
files. I tried to convert it to a git repository with 'cg-init'.

The first thing I noticed was that not all the files and subdirectories had been
added. Doing a cg-status listed many files with '?' in front of them.

I tried adding these files with "cg-add */*", "cg-add */*/*" etc, followed by
"cg-commit", and this seemed at first glance to work. I was able to reduce
the number of files reported by "cg-status". But eventually "cg-add" would
say there were no files left to add, while "cg-status" would still list many
files unadded. It seemed that "cg-add" would only selectively add files.

At that point I blew away the .git directory and gave up on repo-izing that
project for now.

I can reproduce this problem easily. Please let me know if you need any more
information.

Be well,
Zack

-- 
Zack Brown
