From: Jon Loeliger <jdl@freescale.com>
Subject: git-pull.sh's bad mode
Date: Tue, 08 Nov 2005 08:19:38 -0600
Message-ID: <E1EZUK2-0005EG-56@jdl.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 15:22:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZUKb-0005qJ-22
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 15:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVKHOTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 09:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965216AbVKHOTn
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 09:19:43 -0500
Received: from www.jdl.com ([66.118.10.122]:53705 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S965214AbVKHOTm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 09:19:42 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EZUK2-0005EG-56
	for git@vger.kernel.org; Tue, 08 Nov 2005 08:19:38 -0600
To: git@vger.kernel.org
In-Reply-To: 81b0412b0511080023k1384dc26j944e9a07987be436@mail.gmail.com
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11331>


Public apology and brown paper bag.  My patch
accidentally twiddled the mode on git-pull.sh:

    Signed-off-by: Jon Loeliger <jdl@freescale.com>

    ---

     Documentation/git-pull.txt        |   17 +++++++----------
     Documentation/merge-options.txt   |   16 ++++++++++++++++
     Documentation/merge-pull-opts.txt |   14 --------------
     git-format-patch.sh               |    4 ++++
     git-pull.sh                       |   12 +++++++++++-
     9 files changed, 70 insertions(+), 48 deletions(-)
     create mode 100644 Documentation/fetch-options.txt
     create mode 100644 Documentation/merge-options.txt
     delete mode 100644 Documentation/merge-pull-opts.txt
     mode change 100755 => 100644 git-pull.sh
