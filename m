From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git bash completion pull request
Date: Mon, 10 Mar 2008 20:07:23 -0400
Message-ID: <20080311000723.GK8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 01:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYs3X-0001n0-VI
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 01:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499AbYCKAIE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Mar 2008 20:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478AbYCKAID
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 20:08:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42233 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbYCKAH0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 20:07:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYs1R-0000Zp-OU; Mon, 10 Mar 2008 20:07:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6C67920FBAE; Mon, 10 Mar 2008 20:07:23 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76773>

The following changes since commit 50753d00d691c1ea16bc72446705aee2c128=
fc2f:
  Jeff King (1):
        Add a test for read-tree -u --reset with a D/F conflict

are available in the git repository at:

  git://repo.or.cz/git/spearce.git for-junio

Kevin Ballard (1):
      bash: Properly quote the GIT_DIR at all times to fix subdirectory=
 paths with spaces

SZEDER G=C3=A1bor (6):
      bash: remove unnecessary conditions when checking for subcommands
      bash: refactor searching for subcommands on the command line
      bash: add new 'git stash' subcommands
      bash: add 'git svn' subcommands and options
      bash: use __gitdir when completing 'git rebase' options
      bash: fix long option with argument double completion

Shawn O. Pearce (1):
      bash: Remove completion of core.legacyheaders option

Teemu Likonen (1):
      bash: Add more long options to be completed with "git --<TAB>"

 contrib/completion/git-completion.bash |  192 +++++++++++++++++++++++-=
--------
 1 files changed, 137 insertions(+), 55 deletions(-)

--=20
Shawn.
