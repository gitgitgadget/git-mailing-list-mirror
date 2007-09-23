From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: The EGIT Chronicles Issue Volume 1, Issue 2.
Date: Mon, 24 Sep 2007 01:06:18 +0200
Message-ID: <200709240106.19595.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Watson <dwatson@mimvista.com>,
	Ben Konrath <bkonrath@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 01:09:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZaa2-0005qR-V2
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 01:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbXIWXJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 19:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbXIWXJa
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 19:09:30 -0400
Received: from [83.140.172.130] ([83.140.172.130]:25969 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754155AbXIWXJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 19:09:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9A794802877;
	Mon, 24 Sep 2007 01:01:15 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25721-01; Mon, 24 Sep 2007 01:00:55 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 1DA6B80264B;
	Mon, 24 Sep 2007 01:00:43 +0200 (CEST)
User-Agent: KMail/1.9.6
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59000>


Version 0.3 of the Eclipse plugin is out. 

As the zero implies this plugin doesn't do everything, but it makes your 
coffee stronger.

FEATURES

Visualization:
	See the history graphically with highlighting for commits affected
	by the selected resource (Eclipse speak for file or directory).
	Resources are decorated with status.
	Branch name on projects
	Quick diff marks you latest changes visible and revertable in the editor

Actions:
	Connect to repositories
	Add, remove files, rename, update index
	Checkout including some cases of dirty work trees
	Compare revisions using the structured compare
	Commit files selectively, amend and sign-off commits

It even works on Windows, with either cygwin or msysgit (but doesn't do CRLF 
conversions) and OS X.

For advanced stuff you still need the "Real Git" (clone, push, fetch, merge 
etc).

Special thanks to Dave Watson for the Commit and checkout stuff and Shawn 
Pearce for making it possible by doing the initial work on the plugin and 
most importantly a fast pack reader that doesn't involve JNI. The base that 
Shawn formed made it possible to extend the plugin a small piece at a time 
without knowing very much about either Eclipse or Git internals.

BUGS
	Yes, probably.

URL:
	http://repo.or.cz/w/egit.git

-- robin
