From: Lars Hoss <lars@woeye.net>
Subject: Git 1.6.0.2, Submodules and MacOSX Leopard
Date: Tue, 14 Oct 2008 08:53:57 +0200
Message-ID: <678FF056-2A69-49EF-B0AF-8F6C4A17B831@woeye.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 09:16:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kpe84-0008Hg-QY
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 09:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbYJNHO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 03:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbYJNHO2
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 03:14:28 -0400
Received: from mail.codewut.de ([78.47.135.140]:45553 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579AbYJNHO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 03:14:27 -0400
X-Greylist: delayed 1225 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Oct 2008 03:14:26 EDT
Received: by mail.codewut.de (Postfix, from userid 65534)
	id A092D7BEF1; Tue, 14 Oct 2008 08:56:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [10.0.1.200] (ppp-88-217-56-235.dynamic.mnet-online.de [88.217.56.235])
	(Authenticated sender: lars)
	by mail.codewut.de (Postfix) with ESMTP id 03B737BE59
	for <git@vger.kernel.org>; Tue, 14 Oct 2008 08:56:57 +0200 (CEST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98171>

Greetings everyone!

Last night I played around with submodules on MacOSX Leopard using Git  
1.6.0.2.
And it seems there is a bug.

If I add a submodule like this:

git submodule add /Users/lars/tmp/git_test/foo_lib/ lib

It says:

Initialized empty Git repository in /Users/lars/tmp/git_test/ 
sample_app/lib/.git/

And I can see the lib folder. So far so good. But when I do a git  
status it says:

# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	new file:   .gitmodules
#	new file:   lib
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	lib/

So why is lib listed under untracked files?
I did a quick test on my Linux server and there it worked as expected.  
Which means that lib wasn't listed under
untracked files. Then again I use an older version of git on my Linux  
box (1.5.x).

Yours,
Lars
