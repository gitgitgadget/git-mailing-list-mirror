From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 0/2] git-branch: improve command line handling of --abbrev=
Date: Sat,  3 Mar 2007 00:31:15 +0000
Message-ID: <11728818772136-git-send-email-julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 01:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNI9k-00013T-6i
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 01:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992798AbXCCAbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 19:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992800AbXCCAbT
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 19:31:19 -0500
Received: from neutron.datavampyre.co.uk ([212.159.54.235]:47302 "EHLO
	neutron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992798AbXCCAbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 19:31:18 -0500
Received: (qmail 6425 invoked by uid 103); 3 Mar 2007 00:31:17 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2691. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024047 secs); 03 Mar 2007 00:31:17 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 3 Mar 2007 00:31:17 +0000
X-Mailer: git-send-email 1.5.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41263>

When playing with git-branch I discovered that it handled the --abbrev= option
differently to other commands, which surprised me.

This update the parsing code in builtin_branch.c to be the same as
setup_revisions in revision.c, and documents the new --no-abbrev option.

-- 
Julian
