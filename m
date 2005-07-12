From: Marc Singer <elf@buici.com>
Subject: How to get a directory filled with v2.6.11?
Date: Mon, 11 Jul 2005 22:03:47 -0700
Message-ID: <20050712050347.GA10751@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 12 07:04:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsCwB-0001Hs-7A
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 07:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVGLFDx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 01:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVGLFDx
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 01:03:53 -0400
Received: from florence.buici.com ([206.124.142.26]:18075 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262375AbVGLFDu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 01:03:50 -0400
Received: (qmail 10928 invoked by uid 1000); 12 Jul 2005 05:03:47 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I switched to using the git version in source control.
Checkout/branching works great.  :-)

But, this version of git doesn't let me do

  # git checkout -f v2.6.11
  error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
  Needed a single revision

which I suspect is protection added to prevent my special sort of
shenanigans.  If I cannot perform the checkout anymore, is there
another way to fill a directory with the contents of that particular
tree?

What am I doing?  I've got some updates against 2.6.11 orphaned in
another develpment directory.  I could just upack a tar.bz2 file for
2.6.11, but git is more clever.  I want to perform a diff against the
tagged v2.6.11 and my development tree.
