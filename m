From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/5 v2] Introduce the .gitfile
Date: Mon, 18 Feb 2008 11:44:18 +0100
Message-ID: <1203331463-13857-1-git-send-email-hjemli@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 11:47:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR3W3-0003jG-3J
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 11:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757278AbYBRKpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 05:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756993AbYBRKpz
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 05:45:55 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:52699 "EHLO mail45.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbYBRKpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 05:45:55 -0500
Received: from localhost.localdomain (ti231210a341-0179.bb.online.no [88.88.168.179])
	by mail45.nsc.no (8.13.8/8.13.5) with ESMTP id m1IAjYWI026988;
	Mon, 18 Feb 2008 11:45:35 +0100 (MET)
X-Mailer: git-send-email 1.5.4.1.188.g3ea1f5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74258>

The patch-series has been reordered and updated according to comments on
the earlier series.

Shortlog:
 Simplify setup of $GIT_DIR in git-sh-setup.sh
 Add platform-independent .git "symlink"
 Teach resolve_gitlink_ref() about the .git file
 git-submodule: prepare for the .git-file
 Teach GIT-VERSION-GEN about the .git file

Diffstat:
 Documentation/repository-layout.txt |    5 ++-
 GIT-VERSION-GEN                     |    2 +-
 cache.h                             |    1 +
 environment.c                       |    2 +
 git-sh-setup.sh                     |    8 +---
 git-submodule.sh                    |    4 +-
 refs.c                              |   17 +++++++-
 setup.c                             |   47 ++++++++++++++++++++++
 t/t0002-gitfile.sh                  |   74 +++++++++++++++++++++++++++++++++++
 9 files changed, 146 insertions(+), 14 deletions(-)
