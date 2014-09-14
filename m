From: Eric Wong <normalperson@yhbt.net>
Subject: [PULL] git svn updates for master
Date: Sun, 14 Sep 2014 08:21:10 +0000
Message-ID: <20140914082110.GA6666@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Lawrence =?utf-8?Q?Vel=C3=A1zquez?= <vq@larryv.me>,
	Andrej Manduch <amanduch@gmail.com>,
	Monard Vong <travelingsoul86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 10:21:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT53d-0001Al-Ip
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbaINIVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2014 04:21:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51607 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbaINIVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:21:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E533D44C00A;
	Sun, 14 Sep 2014 08:21:10 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257005>

Hi Junio, a couple of small changes and fixes.  Most of these should be
suitable for maint, too.

The following changes since commit ce1d3a93a6405b8a0313491df3099919ed3d=
150f:

  Update draft release notes to 2.2 (2014-09-11 11:19:47 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git master

for you to fetch changes up to 30d45f798d1a4b14759cd977b68be4476d66ea17=
:

  git-svn: delay term initialization (2014-09-14 08:08:54 +0000)

----------------------------------------------------------------
Eric Wong (3):
      git svn: info: correctly handle absolute path args
      git svn: find-rev allows short switches for near matches
      git-svn: delay term initialization

Lawrence Vel=C3=A1zquez (1):
      git-svn.txt: Remove mentions of repack options

Monard Vong (1):
      git-svn: branch: avoid systematic prompt for cert/pass

 Documentation/git-svn.txt | 17 ++-----------
 git-svn.perl              | 65 +++++++++++++++++++++++++++++++++++----=
--------
 t/t9119-git-svn-info.sh   | 30 ++++++++++++++++++++++
 3 files changed, 81 insertions(+), 31 deletions(-)
