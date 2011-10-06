From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: git remote doesn't show remotes from .git/remotes
Date: Thu, 6 Oct 2011 19:33:23 +0400
Message-ID: <26866FC7-4D4D-46D0-89DE-85AF459AC48C@jetbrains.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 17:40:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBq3Q-0005D2-GQ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 17:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758558Ab1JFPkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 11:40:06 -0400
Received: from mail1.intellij.net ([46.137.178.215]:38418 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab1JFPkG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 11:40:06 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Oct 2011 11:40:05 EDT
Received: (qmail 19539 invoked by uid 89); 6 Oct 2011 15:33:24 -0000
Received: by simscan 1.1.0 ppid: 19502, pid: 19529, t: 0.0856s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 6 Oct 2011 15:33:24 -0000
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182960>

Hello,

It seems that 'git remote' doesn't display remotes registered not in .git/config but in .git/remotes/.
Is it a bug?

# git version
git version 1.7.6
# git remote
origin
# ls .git/remotes
test
# git fetch test         // succeeds

Btw, are there advantages in using .git/remotes/ instead of .git/config ? 
If not, are there plans to remove .git/remotes/ support in future versions?

Thanks.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
