From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/3] builtin-branch --[no-]merged post-optimization fixes
Date: Sat, 26 Jul 2008 12:27:22 +0200
Message-ID: <1217068045-3575-1-git-send-email-hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 13:18:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMhnO-0001MI-9T
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 13:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbYGZLRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 07:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYGZLRl
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 07:17:41 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:50502 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbYGZLRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 07:17:41 -0400
Received: from localhost.localdomain (ti0025a380-0241.bb.online.no [88.89.68.241])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id m6QARRQh019909
	for <git@vger.kernel.org>; Sat, 26 Jul 2008 12:27:27 +0200 (MEST)
X-Mailer: git-send-email 1.6.0.rc0.79.gb0320
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90207>

The optimization of --[no-]merged added some code duplication and a
possible "bug" for -v output which this series tries to rectify.

Lars Hjemli (3):
  builtin-branch: remove duplicated code
  builtin-branch: factor out merge_filter matching
  builtin-branch: fix -v for --[no-]merged

 builtin-branch.c |   42 ++++++++++++++++++++++++++++++------------
 1 files changed, 30 insertions(+), 12 deletions(-)
