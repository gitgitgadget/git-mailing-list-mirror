From: Levente Kovacs <leventelist@gmail.com>
Subject: few questions from a git newbie
Date: Thu, 25 Feb 2010 20:26:34 +0100
Organization: logonex.eu
Message-ID: <20100225202634.6a687a6c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 20:30:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkjQ2-0004va-Uu
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 20:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933377Ab0BYTaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 14:30:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:32809 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932882Ab0BYTaF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 14:30:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NkjPP-0004XY-LX
	for git@vger.kernel.org; Thu, 25 Feb 2010 20:30:03 +0100
Received: from fxip-006cc.externet.hu ([92.52.216.204])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 20:30:03 +0100
Received: from leventelist by fxip-006cc.externet.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 20:30:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: fxip-006cc.externet.hu
X-Newsreader: Claws Mail 3.7.5 (GTK+ 2.18.7; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141063>

Hi,


I am a git newbie, so forgive my ignorance.

I've set up a working system with gitosis.

http://logonex.eu/git/

Currently I can add a repository by doing the following
stuff:

edit gitosis.conf

ssh git@server
mkdir REPO.git
cd REPO.git
git --bare init
exit

git clone git@server:REPO.git
cd REPO
git remote add REPO git@server:REPO.git
touch .gitignore
git add .gitignore
git commit -a
git push origin master

Is this flow is the "right way"? How can I add a repository without ssh'ing to
the server?

Next question is about SVN.

I was using SVN, and now I am migrating from SVN to git. I could import
everything to a new repository. However, I want to reorganize my stuff, and
break it to several repositories. Can I move directories to other
repositories? Or can I partially import a directory from SVN to another
directory in a git repository?

How can I make gitosis to hide certain repositories?

Thank you very much for your answers.

Levente

-- 
Levente Kovacs
http://logonex.eu
