From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [tig] [PATCH 0/3] log: colour the diffstat.
Date: Fri, 11 Apr 2014 08:20:02 -0400
Message-ID: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 14:50:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYaum-0007tg-UE
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 14:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbaDKMu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 08:50:28 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.4.196]:35115 "EHLO
	mta1.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757181AbaDKMuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 08:50:24 -0400
Received: from odessa (ool-44c07830.dyn.optonline.net [68.192.120.48])
 by mta1.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0N3V00FYX8XUETC0@mta1.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Fri, 11 Apr 2014 08:20:18 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.82)
	(envelope-from <kumar.a@utexas.edu>)	id 1WYaRN-0000jY-O7; Fri,
 11 Apr 2014 08:20:17 -0400
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246084>

These patches add colourization to the log view. They reuse the diff
stat drawing functions from the diff module directly.

Kumar Appaiah (3):
  diff: Move diff stat addition to a common function
  diff: Move diff stat drawing to a common function
  log: Colour the diff stat

 include/tig/diff.h |  2 ++
 src/diff.c         | 57 +++++++++++++++++++++++++++++++------------------
 src/log.c          | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 98 insertions(+), 23 deletions(-)

-- 
1.9.1
