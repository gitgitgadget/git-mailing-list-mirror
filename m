From: Marcin =?iso-8859-2?q?Wi=B6nicki?= <mwisnicki@gmail.com>
Subject: Merge after directory rename ?
Date: Sun, 21 Aug 2011 21:41:38 +0000 (UTC)
Message-ID: <j2ru2h$cd$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 23:41:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvFmF-0007Ud-JR
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 23:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766Ab1HUVlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 17:41:51 -0400
Received: from lo.gmane.org ([80.91.229.12]:47229 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719Ab1HUVlu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 17:41:50 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QvFm8-0007Tp-To
	for git@vger.kernel.org; Sun, 21 Aug 2011 23:41:48 +0200
Received: from static-78-8-147-77.ssp.dialog.net.pl ([78.8.147.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 23:41:48 +0200
Received: from mwisnicki by static-78-8-147-77.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 23:41:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-8-147-77.ssp.dialog.net.pl
User-Agent: Pan/0.134 (Wait for Me; Unknown)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179818>

Is it possible to merge files after performing directory renames in such 
way that new files will end up in renamed directories ?

For example:
1. [master]  add dir1/file1
2. [branch1] branch from master
3. [branch1] add dir1/file2
4. [master]  rename dir1 to dir2
5. [master]  merge branch1

Where it should notice that dir1=>dir2 and therefore {dir1=>dir2}/file2.

Currently I end up with dir1/file2 which is undesirable as it breaks 
refactorings and requires a lot of manual effort to clean-up.
