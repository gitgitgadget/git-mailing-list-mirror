From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/2] Teach `git remote` howto prune all remotes
Date: Tue, 23 Sep 2008 23:13:23 +0200
Message-ID: <1222204405-30454-1-git-send-email-hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 23:14:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiFDT-0005sI-Vq
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 23:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbYIWVNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 17:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752697AbYIWVNb
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 17:13:31 -0400
Received: from mail46.e.nsc.no ([193.213.115.46]:40813 "EHLO mail46.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbYIWVN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 17:13:29 -0400
Received: from localhost.localdomain (ti0025a380-3500.bb.online.no [83.108.111.180])
	by mail46.nsc.no (8.13.8/8.13.5) with ESMTP id m8NLDPbM011664
	for <git@vger.kernel.org>; Tue, 23 Sep 2008 23:13:26 +0200 (MEST)
X-Mailer: git-send-email 1.6.0.2.309.gc1f46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96599>

Lars Hjemli (2):
  git remote: split part of prune() into prune_one()
  git remote: prune all remotes with `prune -a`

 Documentation/git-remote.txt |    4 +-
 builtin-remote.c             |   97 ++++++++++++++++++++++++++++-------------
 2 files changed, 69 insertions(+), 32 deletions(-)
