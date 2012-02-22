From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL git-svn] various git svn updates
Date: Wed, 22 Feb 2012 00:38:57 +0000
Message-ID: <20120222003857.GA1212@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Steven Walter <stevenrwalter@gmail.com>,
	Steven Walter <swalter@lexmark.com>,
	Wei-Yin Chen <chen.weiyin@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederic Heitzmann <frederic.heitzmann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 01:39:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S00EY-0007br-W6
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 01:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab2BVAi6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 19:38:58 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:33736 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab2BVAi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 19:38:58 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA6851F7A8;
	Wed, 22 Feb 2012 00:38:57 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191205>

The following changes since commit b3a769dc355b32c95783dc07f59e4dfebdd8=
bdc7:

  Update draft release notes to 1.7.10 (2012-02-20 00:29:40 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn master

for you to fetch changes up to 379862ec5a413e636d977a6ea3d618f0b3eafceb=
:

  git-svn.perl: fix a false-positive in the "already exists" test (2012=
-02-21 21:37:31 +0000)

----------------------------------------------------------------
=46rederic Heitzmann (1):
      completion: add --interactive option to git svn dcommit

Steven Walter (2):
      git-svn.perl: perform deletions before anything else
      git-svn.perl: fix a false-positive in the "already exists" test

Wei-Yin Chen (=E9=99=B3=E5=A8=81=E5=B0=B9) (1):
      git-svn: Fix time zone in --localtime

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
      git-svn: remove redundant porcelain option to rev-list
      git-svn: un-break "git svn rebase" when log.abbrevCommit=3Dtrue

 contrib/completion/git-completion.bash |    2 +-
 git-svn.perl                           |   68 +++++++++++++++++++-----=
--------
 t/t9100-git-svn-basic.sh               |   33 +++++++++-------
 3 files changed, 59 insertions(+), 44 deletions(-)
