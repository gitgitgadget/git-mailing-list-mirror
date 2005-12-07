From: Mark Allen <mrallen1@yahoo.com>
Subject: Failure in t6021 on Red Hat Enterprise Linux 4
Date: Wed, 7 Dec 2005 08:49:09 -0800 (PST)
Message-ID: <20051207164909.24221.qmail@web34304.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Dec 07 17:49:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek2To-0003Or-4D
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 17:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVLGQtL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 11:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVLGQtL
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 11:49:11 -0500
Received: from web34304.mail.mud.yahoo.com ([66.163.178.136]:32397 "HELO
	web34304.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750813AbVLGQtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 11:49:10 -0500
Received: (qmail 24223 invoked by uid 60001); 7 Dec 2005 16:49:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uzCvXDPkJYzph9nsAGjQIWKwfwguGJXPUUdP+zgTzK/g7ozkKzfwMLAag+zdBCmoKIzMgaoBG2bZTSpWSbzGGzQUFM/3ylXUMokmzb0ueanmgp9twsQFCChs7tl/bWoFwWnpnRe9IeWgytRC7kx5E+mLhxmYVcMjMIYC1NhWgEw=  ;
Received: from [65.173.207.2] by web34304.mail.mud.yahoo.com via HTTP; Wed, 07 Dec 2005 08:49:09 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13331>

Running t/t6021-crisscross-merge.sh -v -i on Red Hat Enterprise Linux 4 Workstation with
python 2.3.4 installed, I found a fatal error in the test.

Apparently, this release of python doesn't have the subprocess module installed. In what
package is that located? How can I fix this error?

Thanks!

--Mark

-- BEGIN --

[mallen@mrhat t]$ rpm -q python
python-2.3.4-14.1

...SNIP...

git commit -m D8 file
Committing initial tree ec103796f9a6ca8367bd90cd88edf39c5dd2ae26
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Traceback (most recent call last):
  File "/home/mallen/git/git.git/t/../git-merge-recursive", line 13, in ?
    from gitMergeCommon import *
  File "/home/mallen/git/git.git/gitMergeCommon.py", line 18, in ?
    import subprocess
ImportError: No module named subprocess
Automatic merge failed/prevented; fix up by hand

...SNIP...

--- END ---
