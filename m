From: Derek D <darek.dade@gmail.com>
Subject: Private remote repo setup
Date: Tue, 24 Nov 2009 19:04:16 +0000 (UTC)
Message-ID: <loom.20091124T195818-835@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 24 20:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND0h1-00036F-BG
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 20:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933962AbZKXTEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 14:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933910AbZKXTEk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 14:04:40 -0500
Received: from lo.gmane.org ([80.91.229.12]:42904 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933768AbZKXTEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 14:04:39 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1ND0gv-00033D-6S
	for git@vger.kernel.org; Tue, 24 Nov 2009 20:04:45 +0100
Received: from 207.61.177.4 ([207.61.177.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 20:04:45 +0100
Received: from darek.dade by 207.61.177.4 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 20:04:45 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 207.61.177.4 (Opera/9.80 (Windows NT 5.1; U; en) Presto/2.2.15 Version/10.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133587>

Hi all, I am new to Git and I am getting quite frustrated with setting a repo 
on my server so that people with Windows machines can ssh to it and contribute.

This is what I am doing:
On the server:
#git --bare init
Initialized empty Git repository in /opt/apps/git-test/

In tortoiseGIT I go to git clone, provide correct url:
ssh://user@domain/opt/apps/git-test/
tortoiseGIT asks me for a password, I provide it, it's correct, the repository 
gets created on the local machine and...

fatal: '/opt/apps/git-test': unable to chdir or not a git archive
Initialized empty Git repository in C:/path/.git/
fatal: The remote end hung up unexpectedly
Failed

What happened there?
