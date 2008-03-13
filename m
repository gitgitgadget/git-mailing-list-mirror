From: Ping Yin <pkufranky@gmail.com>
Subject: builtin-status submodule summary
Date: Thu, 13 Mar 2008 21:48:01 +0800
Message-ID: <1205416085-23431-1-git-send-email-pkufranky@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 14:49:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZnnh-0002ba-Dl
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 14:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYCMNsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 09:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbYCMNsP
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 09:48:15 -0400
Received: from mail.qikoo.org ([60.28.205.235]:36322 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752858AbYCMNsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 09:48:10 -0400
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 02EFC470AE; Thu, 13 Mar 2008 21:48:05 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77085>

This patch series builds on top of next. It teaches builtin-status/commit
summary for submodules.

It contains
      git-submodule summary: --for-status option
      builtin-status: submodule summary support
      builtin-status: configurable submodule summary size
      buitin-status: Add tests for submodule summary

with diffstat

 git-submodule.sh             |   17 +++++-
 t/t7401-submodule-summary.sh |   13 ++++
 t/t7502-status.sh            |  136 ++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  |   38 ++++++++++++
 4 files changed, 203 insertions(+), 1 deletions(-)
