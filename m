From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v2 0/3] INSTALL updates
Date: Tue,  8 Sep 2009 21:50:58 -0400
Message-ID: <1252461061-75840-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 03:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlCLB-0003Tc-KC
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 03:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272AbZIIBvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 21:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbZIIBvK
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 21:51:10 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46392 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbZIIBvK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 21:51:10 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 1197A1FFC08E; Wed,  9 Sep 2009 01:51:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	by silverinsanity.com (Postfix) with ESMTPA id A818E1FFC06B;
	Wed,  9 Sep 2009 01:50:54 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.2.420.g30ecf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128052>

I'm now up to a three patch series for this minor documentation update.
:-/

The first one simply removes the references to code that no longer exists
in our tree.  This paragraph will be changed again in 3/3 so this patch
could be dropped, but I left it since the factual error is a different
issue than the later enhancements.

The second patch mostly reorders the text so that later changes are more
obvious.  It does contain the changes Junio suggested regarding shell and
perl, since the old wording is archaic and confusing to new users.

The third contains the additions concerning the Makefile switches.  It has
been updated based on Junio's commends.

Brian Gernhardt (3):
  INSTALL: Update description of our SHA-1 code
  INSTALL: Reorder dependencies, split shell and Perl
  INSTALL: Describe dependency knobs from Makefile

 INSTALL |   48 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 17 deletions(-)
