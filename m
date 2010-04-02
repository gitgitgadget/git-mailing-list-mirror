From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 0/4] fix regression that "git status" doesn't refresh the index
Date: Fri,  2 Apr 2010 14:27:17 +0200
Message-ID: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 14:25:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxfwg-0003Lj-V7
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 14:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220Ab0DBMZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 08:25:42 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51456 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab0DBMZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 08:25:41 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2F86F15B2B6C3;
	Fri,  2 Apr 2010 14:25:40 +0200 (CEST)
Received: from [91.19.8.199] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NxfwR-0001ud-00; Fri, 02 Apr 2010 14:25:40 +0200
X-Mailer: git-send-email 1.7.0.4.300.gc535b
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/eRPBqs0f7X/aTfSmE5ESFUHvWG1tVlTXglmMP
	a1L5S240ddVnc2IXQMaqL8JW2mZTFCs3mUBCKXaTDPnTmliktb
	bp+s09ayQhb3BG/duWYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143809>

Patches 1 and 2 are minor unrelated fixes, noticed while working on the regression.
Patches 3 and 4 add a test and fix the regression.

Markus Heidelberg (4):
  builtin/commit: fix duplicated sentence in a comment
  builtin/commit: remove unnecessary variable definition
  t7508: add test for "git status" refreshing the index
  git status: refresh the index

 builtin/commit.c  |   11 ++++++++---
 t/t7508-status.sh |   10 ++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)
