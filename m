From: Yann Dirson <ydirson@altern.org>
Subject: git-svn: peeking into another repo
Date: Sun, 14 Jun 2009 00:53:34 +0200
Message-ID: <20090613225334.GH5867@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 14 00:52:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFc5Z-0005Ji-Uy
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 00:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756975AbZFMWwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 18:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755984AbZFMWwH
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 18:52:07 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:43131 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755603AbZFMWwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 18:52:06 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 6FA5EE08033;
	Sun, 14 Jun 2009 00:52:00 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g21.free.fr (Postfix) with ESMTP id C8699E0807E;
	Sun, 14 Jun 2009 00:51:57 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1A45C11011; Sun, 14 Jun 2009 00:53:35 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121524>

Hi Eric,

I have started to work on conversion of svn:externals into git
submodules [1].

I need to access the revmap of the submodules git-svn repos, but at
first glance I'm under the impression the Git::SVN class is not able
to provide me that support.  Do you confirm this ?  What approach
would you advise ?

Best regards,
-- 
Yann

[1] http://repo.or.cz/w/git/ydirson.git?a=shortlog;h=refs/heads/t/svn-externals
