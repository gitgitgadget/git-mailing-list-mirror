From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: git log --pretty=format joins lines in the subject of commit message
Date: Wed, 15 Sep 2010 16:55:20 +0400
Message-ID: <DDB24DEE-934B-4C8D-8DAA-595905035AC4@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 14:55:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvrWZ-0003Ec-7M
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 14:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753225Ab0IOMzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 08:55:38 -0400
Received: from mail.intellij.net ([213.182.181.98]:52907 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983Ab0IOMzh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 08:55:37 -0400
Received: (qmail 12037 invoked by uid 89); 15 Sep 2010 12:55:33 -0000
Received: by simscan 1.1.0 ppid: 11921, pid: 11967, t: 8.1454s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 15 Sep 2010 12:55:24 -0000
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156235>

Commit something to a git repository with a commit message with several newlines like this:

==== commit message starts below ===
first line
second line
third line

fifth line
=== commit message ends above ===

Git treats the first 3 lines as commit message subject and the last line as its body.

'git log' shows the commit message correctly - exactly like I've entered. So does 'git log --pretty=raw'

But 'git log --pretty=format:%s#%b' joins the first three lines:
first line second line third line#fifth line

Is it a bug or a feature?
If it is a feature how can I acquire the original subject of the commit message by using custom format?

Thanks a lot.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
