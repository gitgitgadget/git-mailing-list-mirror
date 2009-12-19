From: Thomas Johnson <thomas.j.johnson@gmail.com>
Subject: Git as electronic lab notebook
Date: Sat, 19 Dec 2009 12:23:04 +0000 (UTC)
Message-ID: <loom.20091219T130946-844@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 13:25:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLyN4-0008OV-2n
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 13:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbZLSMZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 07:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbZLSMZJ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 07:25:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:40811 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750948AbZLSMZH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 07:25:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NLyMq-0008K7-C3
	for git@vger.kernel.org; Sat, 19 Dec 2009 13:25:05 +0100
Received: from st0195.nas811.p-tokyo.nttpc.ne.jp ([202.229.98.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 13:25:04 +0100
Received: from thomas.j.johnson by st0195.nas811.p-tokyo.nttpc.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Dec 2009 13:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 202.229.98.67 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091109 Ubuntu/9.10 (karmic) Firefox/3.5.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135477>

Hello group,

I've been using git on a few different projects over the last couple of months,
and as a former svn user I really like it. Recently, I've been using it as an
'electronic lab notebook' for an empirical project. My workflow looks like this:
1. Start with the stable code base on head
2. Create  and change to branch 'Experiment123'
3. Make some changes
4. Run the program, which generates a giant (10MB-4G) output text file,
Experiment123.log. Update my LabNotebook.txt file.
5. Were the new changes helpful?
5.yes: Bzip Experiment123.log, and commit it on the branch. Merge the
Experiment123 branch to head and goto 1.
5.no: Bzip Experiment123.log, and commit it on the branch. Merge LabNotebook.txt
and Experiment123.log back to head. Switch back to head and goto 1.

The thing is, Experiment123.log is going to be very similar to Experiment122.log
and Experiment124.log except for a few details. My understanding is that git is
great at compressing groups of files like this, is that correct? Should I not be
bzipping them myself? On the other hand, I don't want HEAD to contain hundreds
of gigs of uncompressed files that bzip down to only a few hundred megs.

Any thoughts on the workflow itself would also be very welcome.
