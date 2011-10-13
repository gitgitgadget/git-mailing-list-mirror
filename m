From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: [Bug] git pull doesn't recognize --work-tree parameter
Date: Thu, 13 Oct 2011 12:38:53 +0400
Message-ID: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 10:39:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REGof-00031M-Qv
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 10:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab1JMIi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 04:38:57 -0400
Received: from mail1.intellij.net ([46.137.178.215]:34943 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab1JMIi4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 04:38:56 -0400
Received: (qmail 10430 invoked by uid 89); 13 Oct 2011 08:38:54 -0000
Received: by simscan 1.1.0 ppid: 10376, pid: 10421, t: 0.0937s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 13 Oct 2011 08:38:54 -0000
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183463>


'git pull' doesn't work from outside the working tree even if '--work-tree' is specified:

# git version
git version 1.7.6
# git --git-dir=/Users/loki/sandbox/git/child/.git --work-tree=/Users/loki/sandbox/git/child pull
fatal: /opt/local/libexec/git-core/git-pull cannot be used without a working tree.

Note that  'git fetch' and 'git merge origin/master' work fine, so 'git pull' should be easy to fix :)

# git --git-dir=/Users/loki/sandbox/git/child/.git --work-tree=/Users/loki/sandbox/git/child merge origin/master
Already up-to-date.


----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
