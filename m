From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: gitk handling of -- on commandline?
Date: Sun, 18 Mar 2007 23:36:48 -0400
Message-ID: <20070319033648.GA13374@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 04:36:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8fy-0000d1-RW
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbXCSDgu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbXCSDgu
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:36:50 -0400
Received: from mail.fieldses.org ([66.93.2.214]:38412 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965034AbXCSDgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:36:49 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HT8fw-0003ip-Fs
	for git@vger.kernel.org; Sun, 18 Mar 2007 23:36:48 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42577>

Since I often use "TMP" as a name both for files and branches, I wasn't
that suprised recently when

	gitk TMP

complained that "TMP" was ambiguous and asked me to use -- to separate
filenames from revisions.  I was a bit more surprised when it still did
that after I gave it

	gitk TMP --

I looked through the source code very quickly but it wasn't obvious to
me why this was happening.  The reverse,

	gitk -- TMP

interestingly doesn't seem to have the same problem.

--b.
