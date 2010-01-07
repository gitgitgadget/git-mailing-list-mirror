From: layer <layer@known.net>
Subject: 1.6.1.3: git merge --no-commit ... DID commit
Date: Wed, 06 Jan 2010 17:41:58 -0800
Message-ID: <11785.1262828518@relay.known.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 02:47:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NShTd-0007Nk-Ac
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 02:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab0AGBrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 20:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755461Ab0AGBrs
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 20:47:48 -0500
Received: from relay.known.net ([173.13.135.57]:40196 "EHLO relay.known.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab0AGBrs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 20:47:48 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2010 20:47:48 EST
Received: from localhost (127.0.0.1) by relay.known.net
    (Allegro Maild v1.2.19) id 000000074769; Wed, 6 Jan 2010 17:41:58 -0800
X-Mailer: MH-E 8.2; nmh 1.3; GNU Emacs 23.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136312>

quadra% git merge --no-commit duane-acl82/acl82
Updating 621f935..a94f7fc
Fast forward
 ChangeLog               |   23 ++++++++++++++
 src/c/fio.c             |    2 +-
 src/c/mon1.c            |    6 ++-
 src/code/debug.cl       |   10 +++++-
 src/code/lldb.cl        |   75 +++++++++++++++++++++++++++++++++++++---------
 src/code/osi-alpha.cl   |   33 ++++++++++++++++++++
 src/code/osi-alpha64.cl |   33 ++++++++++++++++++++
 src/code/x/disx86-64.cl |    4 ++
 src/rs/vrlinux.cl       |    3 +-
 src/rs/xrlinux64.cl     |   30 +++++++++++++++----
 src/rs/xrmacosx64.cl    |   44 ++++++++++++++++++++++++----
 src/rs/xrms64.cl        |   28 ++++++++++++++---
 src/rs/xrsol64.cl       |   28 ++++++++++++++---
 13 files changed, 276 insertions(+), 43 deletions(-)
quadra% git status
# On branch acl82
# Your branch is ahead of 'origin/acl82' by 2 commits.
#
nothing to commit (working directory clean)
quadra% 



Has this been fixed in a later version?
