From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL] git-svn updates for master
Date: Thu, 26 Feb 2015 21:35:16 +0000
Message-ID: <20150226213515.GB2930@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike <ipso@snappymail.ca>, Minty <mintywalker@gmail.com>,
	Nico =?utf-8?B?U2NobMO2bWVy?= <nico.schloemer@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ryuichi Kokubo <ryu1kkb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:35:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR65c-00089e-Ot
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 22:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbbBZVfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 16:35:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58510 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539AbbBZVfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 16:35:16 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146BC200CD;
	Thu, 26 Feb 2015 21:35:16 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264467>

Hi Junio, mainly bugfixes but a tiny amount of progress on lazy-loading.
The bugfixes from Kyle and Ryuichi should also be applied to maint.
Thanks.

The following changes since commit 7f4ba4b6e3ba7075ca6b379ba23fd3088cbe69a8:

  Post 2.3 cyle (batch #5) (2015-02-25 15:44:04 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git master

for you to fetch changes up to e0b4cad4fd77e4cd787c3ed26e7650fc4de8bcd2:

  Git::SVN::*: avoid premature FileHandle closure (2015-02-26 20:19:41 +0000)

----------------------------------------------------------------
Eric Wong (1):
      git-svn: lazy load some modules

Kyle J. McKay (1):
      Git::SVN::*: avoid premature FileHandle closure

Ryuichi Kokubo (1):
      git-svn: fix localtime=true on non-glibc environments

 git-svn.perl            | 13 +++++++------
 perl/Git/SVN.pm         | 25 +++++++++++++++----------
 perl/Git/SVN/Editor.pm  |  3 +--
 perl/Git/SVN/Fetcher.pm | 11 +++++++++--
 perl/Git/SVN/Ra.pm      |  8 +++++++-
 5 files changed, 39 insertions(+), 21 deletions(-)
