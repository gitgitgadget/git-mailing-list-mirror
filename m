From: "W. Trevor King" <wking@tremily.us>
Subject: =?UTF-8?q?=5BPATCH=20v2=2000/15=5D=20User=20manual=20updates?=
Date: Sun, 10 Feb 2013 10:10:26 -0500
Message-ID: <cover.1360508415.git.wking@tremily.us>
References: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4YZd-0000ov-2y
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 16:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759377Ab3BJPLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2013 10:11:18 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:49287 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758942Ab3BJPLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 10:11:16 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MI000D9BFIBIO90@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 10 Feb 2013 09:11:00 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 39FE6879264; Sun,
 10 Feb 2013 10:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360509059; bh=pyAVzNFHIqBTrCNDjFc005EdGk2eBjlWxsz4TEqU0yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=stVjBzZTigycUEiplgQ9ohxQjqrL4mjzLy3UxbDKEtDfEzWsllr+sCDx+rbYonNLX
 rGWe7fYFFASGM+wj/mQ6sZQsrLNgZqAvJUavFeRTwSbGYfAXteVGo8oJs9d7oFOwXZ
 qHp3OYISJs/NBWvIKqPwUBMe2/aLYNefI7Clo60Y=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <7vzjzexv8l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215915>

=46rom: "W. Trevor King" <wking@tremily.us>

This combines my ealier patches:

* user-manual: Rewrite git-gc section for automatic packing
* user-manual: Update for receive.denyCurrentBranch=3Drefuse

With a number of additional fixups.  Changes since v1:

* user-manual: Rewrite git-gc section for automatic packing:
  - Reworded following suggestions from Junio.  This removed the
    phrase containing the 'comression' typo pointed out by Javier.
* user-manual: Update for receive.denyCurrentBranch=3Drefuse
  - No changes.

Most of the patches are well-focused, with the exception of
"Standardize backtick quoting".  I can break this up into smaller
chunks (e.g. "Standardize backtick quoting in Chapter 1", "Standardize
backtick quoting in Chapter 2", =E2=80=A6) if this is too much to bite =
off in
one patch.

I may add additional patches onto the end of this series as I make new
fixes and the series cooks on the list.

W. Trevor King (15):
  user-manual: Rewrite git-gc section for automatic packing
  user-manual: Update for receive.denyCurrentBranch=3Drefuse
  user-manual: Use 'remote add' to setup push URLs
  user-manual: Use git branch --merged
  user-manual: Add a few references to 'git rebase -i'
  user-manual: Give 'git push -f' as an alternative to +master
  user-manual: Mention 'git remote add' for remote branch config
  user-manual: Standardize backtick quoting
  user-manual: Use 'git config --global user.*' for setup
  user-manual: Fix 'both: so' -> 'both; so' typo
  user-manual: Fix 'http' -> 'HTTP' typos
  user-manual: Use request-pull to generate "please pull" text
  user-manual: Fix 'you - Git' -> 'you--Git' typo
  user-manual: Flesh out uncommitted changes and submodule updates
  user-manual: Use --format=3Dtar.gz to create a gzipped tarball

 Documentation/user-manual.txt | 436 +++++++++++++++++++++++-----------=
--------
 1 file changed, 243 insertions(+), 193 deletions(-)

--=20
1.8.1.336.g94702dd
