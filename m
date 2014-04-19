From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn.txt: Retain a description og pre-v2.0 default
 prefix
Date: Sat, 19 Apr 2014 11:43:18 +0000
Message-ID: <20140419114318.GA18939@dcvr.yhbt.net>
References: <20140419083210.GA28771@dcvr.yhbt.net>
 <1397898631-1585-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tfnico@gmail.com,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 13:43:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbTg3-0007qT-UE
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 13:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbaDSLnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 07:43:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45883 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495AbaDSLnT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 07:43:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF6F1FD6E;
	Sat, 19 Apr 2014 11:43:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1397898631-1585-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246513>

Johan Herland <johan@herland.net> wrote:
> Feel free to add/squash this on top.

Thanks!  Squashed and pushed.

The following changes since commit cc291953df19aa4a97bee3590e708dc1fc557500:

  Git 2.0-rc0 (2014-04-18 11:21:43 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git master

for you to fetch changes up to fe191fcaa58cb785c804465a0da9bcba9fd9e822:

  Git 2.0: git svn: Set default --prefix='origin/' if --prefix is not given (2014-04-19 11:30:13 +0000)

----------------------------------------------------------------
Johan Herland (1):
      Git 2.0: git svn: Set default --prefix='origin/' if --prefix is not given

 Documentation/git-svn.txt                        | 20 ++-------
 git-svn.perl                                     | 12 +-----
 t/t9107-git-svn-migrate.sh                       | 54 ++++++++++++------------
 t/t9114-git-svn-dcommit-merge.sh                 |  4 +-
 t/t9116-git-svn-log.sh                           | 46 ++++++++++----------
 t/t9117-git-svn-init-clone.sh                    | 16 +++----
 t/t9118-git-svn-funky-branch-names.sh            | 20 ++++-----
 t/t9120-git-svn-clone-with-percent-escapes.sh    | 14 +++---
 t/t9125-git-svn-multi-glob-branch-names.sh       |  6 +--
 t/t9128-git-svn-cmd-branch.sh                    | 18 ++++----
 t/t9135-git-svn-moved-branch-empty-file.sh       |  2 +-
 t/t9141-git-svn-multiple-branches.sh             | 28 ++++++------
 t/t9145-git-svn-master-branch.sh                 |  2 +-
 t/t9155-git-svn-fetch-deleted-tag.sh             |  4 +-
 t/t9156-git-svn-fetch-deleted-tag-2.sh           |  6 +--
 t/t9161-git-svn-mergeinfo-push.sh                | 22 +++++-----
 t/t9163-git-svn-reset-clears-caches.sh           |  4 +-
 t/t9165-git-svn-fetch-merge-branch-of-branch.sh  |  2 +-
 t/t9166-git-svn-fetch-merge-branch-of-branch2.sh |  2 +-
 t/t9167-git-svn-cmd-branch-subproject.sh         |  2 +-
 20 files changed, 131 insertions(+), 153 deletions(-)
