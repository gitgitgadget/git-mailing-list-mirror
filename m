From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Interaction between clean/smudge and git status
Date: Sun, 13 Apr 2008 23:25:14 +0000 (UTC)
Message-ID: <loom.20080413T231611-113@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 01:26:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlBaK-0005E1-N6
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 01:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbYDMXZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 19:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbYDMXZX
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 19:25:23 -0400
Received: from main.gmane.org ([80.91.229.2]:33797 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbYDMXZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 19:25:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JlBZY-0002c1-GA
	for git@vger.kernel.org; Sun, 13 Apr 2008 23:25:20 +0000
Received: from host40-61-dynamic.6-87-r.retail.telecomitalia.it ([87.6.61.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 23:25:20 +0000
Received: from sergio.callegari by host40-61-dynamic.6-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 23:25:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.6.61.40 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080325 Ubuntu/7.10 (gutsy) Firefox/2.0.0.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79425>

Hi,

I have tried for the first time the .gitattributes filter option, setting a
clean and a smudge filter for a certain type of files.

What makes me wonder is that using filters, after a clean checkout git status
says that everything is changed.

My filter is a very short script that operates on zip files.
The clean command re-zips them so that the content is merely stored.
The smudge one re-zips them so that the content is deflated again.

This kind of filter helps very much the git repacking when zip files or
openoffice files are around.

But unfortunately, with it git shows everything as changed, which is not that
nice.

Is this the expected behaviour of the smudge filter?
Unfortunately I have been able to find very little documentation on it (only a
bit in the gitattributes man page), so maybe I am missing something.
