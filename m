From: Peter Eriksen <s022018@student.dtu.dk>
Subject: git-clone seems dead
Date: 11 Sep 2005 20:13:24 +0200
Message-ID: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 11 20:30:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWbK-000771-IB
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVIKSar (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVIKSar
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:30:47 -0400
Received: from main.gmane.org ([80.91.229.2]:15548 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750752AbVIKSar (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 14:30:47 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EEWbE-00075L-QN
	for git@vger.kernel.org; Sun, 11 Sep 2005 20:30:44 +0200
Received: from ebar091.ebar.dtu.dk ([192.38.93.106])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 20:30:44 +0200
Received: from s022018 by ebar091.ebar.dtu.dk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 20:30:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ebar091.ebar.dtu.dk
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8315>

Hello,

The command "git clone" doesn't work for me, and I have no idea why.
What I want to do is exactly what the tutorial describes:

<cite>
Again, this can all be simplified with

git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ my-git
cd my-git
git checkout
</cite>

See
http://kernel.org/git/?p=git/git.git;a=blob;h=6e100dbb60f5756db0f453193e53c28bf947d7cc;hb=720d150c48fc35fca13c6dfb3c76d60e4ee83b87;f=Documentation/tutorial.txt#l652

The problem is reproduced by the following sequence of commands:

mkdir ~/bin
wget http://kernel.org/pub/software/scm/git/git-core-0.99.6.tar.gz
tar -zxf git-core-0.99.6.tar.gz
cd git-core-0.99.6
make
make install
cd ..
git clone rsync://rsync.kernel.org/pub/scm/git/git.git/ my-git

All commands works fine except "git clone" which prints:

<cite>
defaulting to local storage area
* git clone [-l [-s]] [-q] [-u <upload-pack>] <repo> <dir>
</cite>

and leaves my-git/.git empty.  So the problem is, that I can't
get "git clone" to work, and I think, I am making correct steps.

Regards,

Peter
