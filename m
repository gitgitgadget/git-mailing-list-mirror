From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 0/3] msysgit fallout
Date: Wed, 21 Nov 2007 21:27:18 +0100
Message-ID: <11956768414090-git-send-email-prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 21:28:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuwB3-0008Rz-9I
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 21:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbXKUU12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 15:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbXKUU11
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 15:27:27 -0500
Received: from mailer.zib.de ([130.73.108.11]:42017 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313AbXKUU1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 15:27:24 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lALKRMil007520
	for <git@vger.kernel.org>; Wed, 21 Nov 2007 21:27:22 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lALKRLdF013767;
	Wed, 21 Nov 2007 21:27:21 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65703>

Here are three patches that come from msysgit.  They do not bring
any functional changes, but only clean up code, or fix warnings.

    Steffen

 builtin-init-db.c |    4 +---
 git.c             |    6 +++---
 path.c            |    2 +-
 setup.c           |    2 +-
 sha1_file.c       |   10 ++++++----
 5 files changed, 12 insertions(+), 12 deletions(-)

 [PATCH 1/3] sha1_file.c: Fix size_t related printf format warnings
 [PATCH 2/3] builtin-init-db: use get_git_dir() instead of getenv()
 [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
