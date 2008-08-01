From: Stefan Naewe <stefan.naewe+git@gmail.com>
Subject: Filtering mode changes
Date: Fri, 1 Aug 2008 11:25:45 +0000 (UTC)
Message-ID: <loom.20080801T111754-982@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 13:27:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOsn5-0005e6-PU
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 13:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435AbYHAL0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 07:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754499AbYHAL0A
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 07:26:00 -0400
Received: from main.gmane.org ([80.91.229.2]:41152 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435AbYHAL0A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 07:26:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KOsld-0001Wy-PL
	for git@vger.kernel.org; Fri, 01 Aug 2008 11:25:54 +0000
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 11:25:53 +0000
Received: from stefan.naewe+git by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 11:25:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91058>

Hi there.

Here's my story:

- I did some minor modifications to a repo that I want to 'give back'.
- I worked on my own branch (of course).
- I was stupid to edit the files (that live on a linux box) through a windows
  network share.
- When I created diffs (using 'git format-patch') to send send 'upstream', I 
  noticed that the edited files got their executable bit set (old mode 100644 ->
  new mode 100755)
- I created another commit to undo the mode changes.

My question:

Is there a way to create clean diffs (between master and my branch) that don't
contain the 'double mode change' (from 644 to 755 to 644) ? 

TIA

Stefan
