From: Semen Vadishev <Semen.Vadishev@gmail.com>
Subject: Using both JGit and C Git
Date: Mon, 03 Aug 2009 22:05:21 +0400
Message-ID: <4A7726E1.2020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 20:12:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY21U-000252-ET
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 20:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbZHCSMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 14:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbZHCSMK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 14:12:10 -0400
Received: from mail.intellij.net ([213.182.181.98]:57477 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbZHCSMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 14:12:09 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2009 14:12:08 EDT
Received: (qmail 11373 invoked by uid 89); 3 Aug 2009 18:05:27 -0000
Received: by simscan 1.1.0 ppid: 10943, pid: 11365, t: 0.0156s
         scanners: regex: 1.1.0
Received: from unknown (HELO vs.labs.intellij.net) (172.26.240.171)
  by mail.intellij.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 3 Aug 2009 18:05:27 -0000
User-Agent: Thunderbird 2.0.0.22 (Macintosh/20090605)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124712>

Hello everyone,

I'm working on git client written in Java. Now the application uses both
implementations but our team is interested in switching to JGit
completely some day. We consider that for the first version all
read-only operations should be implemented with JGit and read-write
functionality should use exec calls to git executable. We would keep
that approach until we have even the smallest suspect that pure Java
implementation could corrupt repository somehow. Also we have a number
of read-write operations implemented with JGit and we will use them
internally to collect more experience and to see if any problems will
appear.

Does anyone here already have any experience with using both JGit and C
Git together. Is there any kind of test suites which allow to check
JGit's behavior on different platforms comparing with native git. Is
there any known issues/workarounds? Any feedback is much appreciated.

I've noticed that such a question was raised here, but the answers are
probably out of date now.

Thanks in advance!
-- Semyon.
