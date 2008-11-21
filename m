From: Ryan Phillips <ryan@trolocsis.com>
Subject: git-svn and svn branches
Date: Fri, 21 Nov 2008 13:58:36 -0600
Message-ID: <20081121195835.GA12141@athena.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 21:00:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3cAa-0002If-DS
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 21:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbYKUT6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 14:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbYKUT6p
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 14:58:45 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:61326 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbYKUT6o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 14:58:44 -0500
Received: by qyk4 with SMTP id 4so1036659qyk.13
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 11:58:43 -0800 (PST)
Received: by 10.214.44.2 with SMTP id r2mr829760qar.146.1227297522497;
        Fri, 21 Nov 2008 11:58:42 -0800 (PST)
Received: from athena.lan (66-90-184-91.dyn.grandenetworks.net [66.90.184.91])
        by mx.google.com with ESMTPS id 5sm4366897yxt.1.2008.11.21.11.58.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Nov 2008 11:58:41 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101537>

I followed the following instructions on adding a remote svn branch to my
local git-svn repository. http://www.dmo.ca/blog/20070608113513

Are these still accurate?

I started the repository with
  # git svn init [url/trunk]`
  # cd project.git
  # git svn fetch -r[HEAD revision]
which works fine. I added something like Snippet 1 to the .git/config and
issued a `git svn fetch -r[HEAD revision of the branch]` and nothing
happens. It takes git-svn a few seconds to run, but the git-remote svn
branch doesn't get initialized.

Does this procedure only work with a full mirror of a git-svn repository?
or perhaps I'm doing something wrong. Any help would be appreciated.

Thanks,
Ryan

Snippet 1
=========

[svn-remote "svn34"]
url = svn+ssh://your-server/home/svn/project-name/branches/3.4.x
fetch = :refs/remotes/git-svn-3.4
