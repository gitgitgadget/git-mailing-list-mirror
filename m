From: Maaartin <grajcar1@seznam.cz>
Subject: Missing git-svn on cygwin
Date: Sun, 19 Sep 2010 12:56:16 +0000 (UTC)
Message-ID: <loom.20100919T144741-228@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 14:57:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxJSG-0005ad-N6
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 14:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab0ISM43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 08:56:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:33570 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755060Ab0ISM40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 08:56:26 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OxJRQ-0005Dl-ON
	for git@vger.kernel.org; Sun, 19 Sep 2010 14:56:24 +0200
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 14:56:24 +0200
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 14:56:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.61)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156495>

I tried to reinstall potentially relevant parts of my cygwin, I tried to google 
out what else I could do, but without success. According to
http://figures.oreilly.com/tagoreillycom20090514oreillybooks296915I_book_d1e1/
figs/I_mediaobject2_d1e1431-web.png
from
http://oreilly.com/software-engineering/excerpts/version-control-git/installing-
git.html
there should be four git* packages, but there's only one.

#git version
git version 1.7.0.4

#git svn
git: 'svn' is not a git command. See 'git --help'.

#(cd /c/Programs/cygwin/lib/git-core/; ls git-s*)
git-send-email*     git-shortlog.exe*     git-show.exe*    git-stripspace.exe*
git-send-pack.exe*  git-show-branch.exe*  git-stage.exe*   git-submodule*
git-sh-setup*       git-show-index.exe*   git-stash*       git-symbolic-ref.exe*
git-shell.exe*      git-show-ref.exe*     git-status.exe*

There are more tools missing, eg. gitk and git-gui. Any idea?
