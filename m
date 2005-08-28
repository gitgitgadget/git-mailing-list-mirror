From: Robert Fitzsimons <robfitz@273k.net>
Subject: git-apply patches
Date: Sun, 28 Aug 2005 15:22:51 +0000
Message-ID: <20050828152251.GA26331@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 28 17:23:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9Oye-0005zd-31
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 17:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVH1PVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 11:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVH1PVV
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 11:21:21 -0400
Received: from igraine.blacknight.ie ([217.114.173.147]:34285 "EHLO
	igraine.blacknight.ie") by vger.kernel.org with ESMTP
	id S1751194AbVH1PVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 11:21:20 -0400
Received: from [212.17.39.138] (helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.42)
	id 1E9Oxr-0004NQ-3Y
	for git@vger.kernel.org; Sun, 28 Aug 2005 16:20:55 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 7.5)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7871>

Here is a series of patches which fix some bugs in and add some new
command line options to git-apply.

[PATCH 1/9] Fix git patch header processing in git-apply.
[PATCH 2/9] Fix detection of files with only one line in git-apply.
[PATCH 3/9] Fix processing of a patch file which modifies the same file in git-apply.
[PATCH 4/9] Fix the procssing of multiple patch files with --check in git-apply.
[PATCH 5/9] New option --force-delete for git-apply.
[PATCH 6/9] New option --ignore-whitespace for git-apply.
[PATCH 7/9] New option --ignore-applied for git-apply.
[PATCH 8/9] New git-apply test cases for patches with mulitple fragments.
[PATCH 9/9] New git-apply test cases for scanning forwards and backwards.

Robert Fitzsimons
robfitz@273k.net
