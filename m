From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 0/9] User manual updates
Date: Sun, 17 Feb 2013 19:15:52 -0500
Message-ID: <cover.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EPO-0000V7-Sv
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab3BRAQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:13 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:65233 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab3BRAQM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:12 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE00D9X3EV8480@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:08 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id CEDF088564A; Sun,
 17 Feb 2013 19:16:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146566; bh=VfB+fwg7OaKxYPy2mmBm5X8p4ZC71VONsHdl7OW6FeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qa2Ku8kUC030smXHBnJWwleBL5Ugd2VBAtw/LR9Swi0ONyHeUVDblkrSSBFoIql+f
 jb/SnPbCu6ACRC+tPJBLCxj4geAqPtj+yHUAdQ3whGJnbgg4xRBewUS3zJqTjc9wTs
 5RVCl+HzZP/n3ud6DOzQhrObzfsov4zODGZB17ns=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <20130217170606.GA3432@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216412>

From: "W. Trevor King" <wking@tremily.us>

Changes since v2 (v2 numbering):

* 01: user-manual: Rewrite git-gc section for automatic packing
  - Dropped (graduated to 'maint')
* 02: user-manual: Update for receive.denyCurrentBranch=refuse
  - Dropped (graduated to 'master')
* 03: user-manual: Use 'remote add' to setup push URLs
  - Removed 'git config' examples
  - Show .git/config changes made by 'remote add'
* 04: user-manual: Use git branch --merged
  - Dropped (not an improvement)
* 05: user-manual: Add a few references to 'git rebase -i'
  - Removed an extra blank line
  - Restructured reroll sections:
    * cherry-pick suggestions removed
    * commit --amend discussion isolated in its own section
    * format-patch restructuring moved to its own section
    * new interactive rebase section.  The contents of this section
      borrow liberally from git-rebase.txt.
* 06: user-manual: Give 'git push -f' as an alternative to +master
* 07: user-manual: Mention 'git remote add' for remote branch config
  - Simplified section to avoid 'git config'
* 08: user-manual: Standardize backtick quoting
  - Fix `{plus}` -> `+` in backticked text
* 09: user-manual: Use 'git config --global user.*' for setup
  - Remove reference to "stanza".
* 10: user-manual: Fix 'both: so' -> 'both; so' typo
  - Dropped (graduated to 'maint')
* 11: user-manual: Fix 'http' -> 'HTTP' typos
  - Dropped (graduated to 'maint')
* 12: user-manual: Use request-pull to generate "please pull" text
  - Add an explicit push before request-pull
  - Use the `mytree` remote instead of an explicit example URL
* 13: user-manual: Fix 'you - Git' -> 'you--Git' typo
  - Dropped (graduated to 'maint')
* 14: user-manual: Flesh out uncommitted changes and submodule updates
* 15: user-manual: Use --format=tar.gz to create a gzipped tarball
  - Use `-o latest.tar.gz` instead of `--format=tar.gz`.

W. Trevor King (9):
  user-manual: Use 'remote add' to setup push URLs
  user-manual: Reorganize the reroll sections, adding 'git rebase -i'
  user-manual: Give 'git push -f' as an alternative to +master
  user-manual: Mention 'git remote add' for remote branch config
  user-manual: Standardize backtick quoting
  user-manual: Use 'git config --global user.*' for setup
  user-manual: Use request-pull to generate "please pull" text
  user-manual: Flesh out uncommitted changes and submodule updates
  user-manual: Use -o latest.tar.gz to create a gzipped tarball

 Documentation/user-manual.txt | 504 ++++++++++++++++++++++--------------------
 1 file changed, 267 insertions(+), 237 deletions(-)

-- 
1.8.1.336.g94702dd
