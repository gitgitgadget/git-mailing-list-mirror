From: Sergei Organov <osv@javad.com>
Subject: git-merge: inconsistent manual page.
Date: Tue, 30 Oct 2007 16:22:31 +0300
Message-ID: <fg7b6o$k1f$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 14:23:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imr3i-0004BU-Ud
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 14:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979AbXJ3NWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 09:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbXJ3NWw
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 09:22:52 -0400
Received: from main.gmane.org ([80.91.229.2]:35738 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960AbXJ3NWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 09:22:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Imr3M-0004CC-Dg
	for git@vger.kernel.org; Tue, 30 Oct 2007 13:22:44 +0000
Received: from 87.236.81.130 ([87.236.81.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 13:22:44 +0000
Received: from osv by 87.236.81.130 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 13:22:44 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

git-merge has inconsistent manual page:

1. In the SYNOPSIS, there is [-m <msg>], but OPTIONS section lacks it.
   The latter has just  description of <msg>, suggesting it could be
   used without -m, but SYNOPSIS doesn't reflect this. 

   BTW, git-merge options are described in
   Documentation/merge-options.txt that is also used fot git-pull
   options, and it's not clear for me if git-pull supports [-m
   <msg>]. Does it?

2. In the SYNOPSIS, there is no <head> that is described in the
   OPTIONS.

Overall, it seems that either SYNOPSIS should be changed (see patch
below), or historical syntax should be wiped from the manual page.

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index bca4212..0ea7aea 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-merge' [-n] [--summary] [--no-commit] [--squash] [-s <strategy>]...
-	[-m <msg>] <remote> <remote>...
+	[[-m] <msg>] [<head>] <remote> <remote>...
 
 DESCRIPTION
 -----------

-- 
Sergei.
