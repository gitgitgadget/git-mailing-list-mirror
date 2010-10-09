From: Maaartin <grajcar1@seznam.cz>
Subject: Best single user practice
Date: Sat, 9 Oct 2010 22:24:58 +0000 (UTC)
Message-ID: <loom.20101009T233356-82@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 00:26:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4hs6-0004vg-Sa
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 00:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab0JIWZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 18:25:15 -0400
Received: from lo.gmane.org ([80.91.229.12]:37492 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753550Ab0JIWZO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 18:25:14 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P4hqo-0004Ui-8n
	for git@vger.kernel.org; Sun, 10 Oct 2010 00:25:10 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 00:25:10 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 00:25:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.62)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158633>

I've started using git maybe one month ago, and I'd like to use it for many 
things including some one-man projects, browser settings backups, and such 
things. So I always do a local git init, ssh to my server and create a repo 
there. I copy the .git/config from a working project, and change the remote 
URL. It all works, but it's not perfect.

- Is it not possible to create a remote repository from my own computer without 
ssh?

- There's only version 1.5.4.3 on the server and I don't want to update it 
unless strongly recommended so. Should I?

- Because of the low version, I can't use "git init --bare" on the server. So I 
create an usual depository and change the configuration to bare=true. Is it OK 
(I really don't mind the repo being placed in DIR/.git instead of DIR itself.)?

- The very first time I need to do "git push origin master", later "git push" 
suffices. I wonder why.

- My local repository created by "git init" (version 1.7.2.3 under cygwin) 
contains
[core]
 repositoryformatversion = 0
 filemode = true
 bare = false
 logallrefupdates = true
 ignorecase = true
but I'd prefer to specify there as little as possible, since the settings for 
all my repositories should be the same (at least for the moment). What can be 
safely removed?

- Sometimes, I use "git push --force", how do I clean up the resulting garbage 
on the server?

- How can I ensure that everything important gets pushed to the server? Maybe 
by using "git push --mirror"? Obviously and logically, .git/config doesn't get 
pushed, but maybe I miss something more important, too?
