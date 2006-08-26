From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/7] gitweb: Cleanups, fixes and small improvements
Date: Sat, 26 Aug 2006 19:13:12 +0200
Message-ID: <1156612392716-git-send-email-jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 26 19:13:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH1il-0003pw-Sz
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 19:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422697AbWHZRNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 13:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWHZRNS
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 13:13:18 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:47326 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S964771AbWHZRNR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 13:13:17 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7QHC13e004317
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 19:12:01 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7QHDDCM032704
	for <git@vger.kernel.org>; Sat, 26 Aug 2006 19:13:13 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7QHDCvx032703
	for git@vger.kernel.org; Sat, 26 Aug 2006 19:13:12 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26052>

This series contains fixes, improvements and cleanups.

Fixes are patch 2 and 4, with 4 more important.

This series is based on next 
  (885a89a077c2c79e1fac81c57711566ec30f9bc1)
---
 gitweb/gitweb.perl |   75 +++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 54 insertions(+), 21 deletions(-)

Shortlog:

      gitweb: Restore old git_blame using git-annotate under "annotate"
      gitweb: Remove workaround for git-diff bug fixed in f82cd3c
      gitweb: Improve comments about gitweb features configuration
      gitweb: Fix typo in git_patchset_body
      gitweb: Use 'local $/ = undef;' before 'print <$fd>;'
      gitweb: blobs defined by non-textual hash ids can be cached
      gitweb: Always link to plain version of the blob
