From: ryanzec <basire@gmail.com>
Subject: What Features Do I loose With git-svn?
Date: Fri, 29 Apr 2011 09:53:49 -0700 (PDT)
Message-ID: <1304096029355-6317576.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 18:53:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqx1-0005Mg-1b
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760220Ab1D2Qxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:53:50 -0400
Received: from sam.nabble.com ([216.139.236.26]:46739 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760167Ab1D2Qxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:53:50 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <basire@gmail.com>)
	id 1QFqwv-0001a1-Bg
	for git@vger.kernel.org; Fri, 29 Apr 2011 09:53:49 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172473>

I want to use git for a project I am working on however because the project
is going to possibility have a lot of binary content in size and number of
files (game project), it is probably going to be hard to convince my team to
make the switch since I have no real solution besides just use git for the
code and svn for the binary data.  I am hoping git-svn will do the trick for
me.  The question is are they any features I loose (like cherry picking) or
anything that I have to look out for (does updating from svn cause merging
issues just like working all in SVN does).  Right now the only things I know
to look out for is:

<ul>
<li>Instead of git pull/push I have to use the git-svn equivalents</li>
<li>If I have changes that are not in the index and I need to pull the
latest code form SVN, I have to stash first, update from svn, and then apply
the stash back.</li>
</ul>

Any other things I have to look out for?  I am mainly concerned that using
git-svn will re-introduce the merge issues of SVN the git is great at doing.--
View this message in context: http://git.661346.n2.nabble.com/What-Features-Do-I-loose-With-git-svn-tp6317576p6317576.html
Sent from the git mailing list archive at Nabble.com.
