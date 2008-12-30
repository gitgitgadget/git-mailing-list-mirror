From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: new home for libgit2 project
Date: Tue, 30 Dec 2008 09:04:58 -0800
Message-ID: <20081230170458.GD29071@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 18:06:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHi2w-0003kP-MP
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 18:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbYL3RFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 12:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYL3RE7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 12:04:59 -0500
Received: from george.spearce.org ([209.20.77.23]:59851 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYL3RE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 12:04:59 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id BE81438200; Tue, 30 Dec 2008 17:04:58 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104194>

I've (mostly) moved libgit2 to repo.or.cz (thanks Pieter for
releasing the mirror, thanks Pasky for the free hosting!):

  http://repo.or.cz/w/libgit2.git
  git://repo.or.cz/libgit2.git

Thus far its able to format and parse SHA-1 strings, and read
loose objects from a repository.  It also doesn't compile on
Mac OS X as the Mach-O file format doesn't support the use of
__thread declarations on variables...

-- 
Shawn.
