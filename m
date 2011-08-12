From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/7] Comments and refactoring in attr.c
Date: Fri, 12 Aug 2011 23:43:03 +0200
Message-ID: <1313185390-19724-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 23:43:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrzVq-00084c-6E
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 23:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab1HLVnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 17:43:25 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40847 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab1HLVnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 17:43:25 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.homenet.telecomitalia.it (p54BEAA34.dip.t-dialin.net [84.190.170.52])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7CLhCvF007606;
	Fri, 12 Aug 2011 23:43:15 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179248>

This patch series adds comments for some non-obvious things in attr.c,
simplifies the interface of parse_attr(), and unrolls the loop over
passes in parse_attr_line() (which IMO makes the code easier to
understand).  It does not change the observable behavior in any way.

The patch series is against master, but can be rebased to next without
conflicts.

Michael Haggerty (7):
  Add a file comment
  Document struct match_attr
  Increment num_attr in parse_attr_line(), not parse_attr()
  Change parse_attr() to take a pointer to struct attr_state
  Determine the start of the states outside of the pass loop
  Change while loop into for loop
  Unroll the loop over passes

 attr.c |  113 +++++++++++++++++++++++++++++++++++----------------------------
 1 files changed, 63 insertions(+), 50 deletions(-)

-- 
1.7.6.8.gd2879
