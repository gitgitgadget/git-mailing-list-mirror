From: funeeldy <Marlene_Cote@affirmednetworks.com>
Subject: Re: git checkout no longer warning about uncommitted/untracked
 files!
Date: Mon, 23 May 2011 14:05:04 -0700 (PDT)
Message-ID: <1306184704408-6396225.post@n2.nabble.com>
References: <1306171797211-6395441.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 23:05:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOcJQ-0001GZ-HU
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 23:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474Ab1EWVFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 17:05:08 -0400
Received: from sam.nabble.com ([216.139.236.26]:33830 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030490Ab1EWVFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 17:05:05 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <Marlene_Cote@affirmednetworks.com>)
	id 1QOcJE-0008TI-Dj
	for git@vger.kernel.org; Mon, 23 May 2011 14:05:04 -0700
In-Reply-To: <1306171797211-6395441.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174274>

This is with version 1.7.5.2 - it just keeps the files as modified when I
checkout a different branch.  The bad thing about this is that if I make a
change on both branches, only the last change is kept, silently.
Earlier today when I tried this new version, the first checkout failed with
the error message I expected, but I cannot get it to show me that again.

private/marlene_cote/test/anroot/projects/kernel main_int $ git st
# On branch main_int
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#	modified:   Makefile
#
no changes added to commit (use "git add" and/or "git commit -a")
/private/marlene_cote/test/anroot/projects/kernel main_int $ git checkout
main
M	Makefile
Branch main set up to track remote branch main from origin.
Switched to a new branch 'main'
/private/marlene_cote/test/anroot/projects/kernel main $ git checkout
main_int
M	Makefile
Switched to branch 'main_int'
/private/marlene_cote/test/anroot/projects/kernel main_int $ git checkout
main
M	Makefile
Switched to branch 'main'
v/private/marlene_cote/test/anroot/projects/kernel main $ vi Makefile 
/private/marlene_cote/test/anroot/projects/kernel main $ git checkout
main_int
M	Makefile
Switched to branch 'main_int'


--
View this message in context: http://git.661346.n2.nabble.com/git-checkout-no-longer-warning-about-uncommitted-untracked-files-tp6395441p6396225.html
Sent from the git mailing list archive at Nabble.com.
