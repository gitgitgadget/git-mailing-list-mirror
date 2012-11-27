From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH v2 0/3] Add option to change order of parents in merge commit
Date: Wed, 28 Nov 2012 00:00:14 +0100
Message-ID: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
Cc: Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:18:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUPr-00006C-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504Ab2K0XRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:17:45 -0500
Received: from carme.pld-linux.org ([193.239.45.140]:13594 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756359Ab2K0XRk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 18:17:40 -0500
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1TdU8X-000H9M-5E; Wed, 28 Nov 2012 00:00:17 +0100
X-Mailer: git-send-email 1.8.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210625>

The second version of patches introducing option to change order
of parents in merge commits. The changes in respect to the previous
version:

- I have divided the changes to the preparatory ones, which
  only refactore the code without introducing new functionality, and
  the commit which introduces the new option

- The documentation for the new options has been added

This is not yet a final version, as the tests are missing. But maybe while I'm working
on them there will be some comments.

Kacper Kornet (3):
  Process MERGE_MODE before MERGE_HEAD
  Allow for MERGE_MODE to specify more then one mode
  Add option to transpose parents of merge commit

 Documentation/merge-options.txt |  7 +++++++
 builtin/commit.c                | 22 ++++++++++++++--------
 builtin/merge.c                 | 16 ++++++++++++----
 commit.c                        | 11 +++++++++++
 commit.h                        |  2 ++
 git-pull.sh                     |  4 +++-
 6 files changed, 49 insertions(+), 13 deletions(-)

-- 
1.8.0.1
