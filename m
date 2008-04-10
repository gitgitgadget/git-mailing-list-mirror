From: Mark Dodwell <web@mkdynamic.co.uk>
Subject: Git (SHA1) problem on Mac
Date: Thu, 10 Apr 2008 22:12:36 +0100
Message-ID: <FAA4D842-DCB2-45B4-AB40-6F7D1F0A0320@mkdynamic.co.uk>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 23:13:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk44y-0007PV-La
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 23:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbYDJVMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 17:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756100AbYDJVMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 17:12:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.174]:54583 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755971AbYDJVMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 17:12:24 -0400
Received: from [192.168.1.66] (host86-158-113-105.range86-158.btcentralplus.com [86.158.113.105])
	by mrelayeu.kundenserver.de (node=mrelayeu1) with ESMTP (Nemesis)
	id 0MKwpI-1Jk44F1JaH-0001iX; Thu, 10 Apr 2008 23:12:23 +0200
X-Mailer: Apple Mail (2.753)
X-Provags-ID: V01U2FsdGVkX1/c6HtP+UzfmgnZLXCVM6HKWWjGQgpfN2Wrc7e
 SynmfKmWqztPVORmf4DOn6afs3amMywxrE1P1mEup5I3w9zup6
 wup3Cf5QROZPujOH47p3WQL0KWzAmnm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79250>

Hi,

I've got a problem with Git on my Mac, and I've exhausted Google and  
#git (irc), perhaps somebody can help?

I'm using git version X installed from source, I'm on Mac OS X 10.4.11.

Here's the problem I'm seeing:

[imac:~]$   mkdir git-test
[imac:~]$   cd git-test
[imac:~/git-test]$   git init
Initialized empty Git repository in .git/
[imac:~/git-test]$   touch README
[imac:~/git-test]$   git add README
[imac:~/git-test]$   git commit -m 'first commit'
Created initial commit b6e6cb6: first commit
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 README
[imac:~/git-test]$   git remote add origin git@github.com:mkdynamic/ 
git-test.git
[imac:~/git-test]$   git push origin master
Counting objects: 3, done.
Writing objects: 100% (3/3), 215 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
fatal: final sha1 did not match
error: unpack failed: unpacker exited with error code
To git@github.com:mkdynamic/git-test.git
  ! [remote rejected] master -> master (n/a (unpacker error))
error: failed to push some refs to 'git@github.com:mkdynamic/git- 
test.git'

I can confirm that it is not an issue with the remote repo, as I  
similar 'final sha1 did not match' errors when i try to do local  
fetches.

Any clues/advice on what to do next?

Many thanks,

~ Mark
