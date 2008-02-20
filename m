From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/4 v3] Introducing the .git file
Date: Wed, 20 Feb 2008 23:13:12 +0100
Message-ID: <1203545596-6337-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxF2-0006aQ-Vd
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbYBTWPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbYBTWPl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:15:41 -0500
Received: from mail43.e.nsc.no ([193.213.115.43]:47337 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755064AbYBTWPj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:15:39 -0500
Received: from localhost.localdomain (ti231210a341-0590.bb.online.no [88.88.170.78])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id m1KMEQAI024249;
	Wed, 20 Feb 2008 23:14:28 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.g3ea1f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74551>

This is a resend of my previous series implementing the .git file,
rebased on top of todays master (e3c58f8b). The patches are identical
to the final suggestions in http://thread.gmane.org/gmane.comp.version-control.git/74258
except for the previous 1/5 which is dropped from the series (since it
already appears in master). There are also some minor touch-ups to the
commit messages.

Shortlog:
 Add platform-independent .git "symlink"
 Teach resolve_gitlink_ref() about the .git file
 Teach git-submodule.sh about the .git file
 Teach GIT-VERSION-GEN about the .git file

Diffstat:
 Documentation/repository-layout.txt |    5 ++-
 GIT-VERSION-GEN                     |    2 +-
 cache.h                             |    1 +
 environment.c                       |    2 +
 git-submodule.sh                    |    4 +-
 refs.c                              |   17 +++++-
 setup.c                             |   47 ++++++++++++++++
 t/t0002-gitfile.sh                  |  103 +++++++++++++++++++++++++++++++++++
 8 files changed, 174 insertions(+), 7 deletions(-)
