From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [tig] [PATCHv2 0/3] log: colour the diffstat
Date: Sun, 13 Apr 2014 17:54:25 -0400
Message-ID: <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in>
References: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: Jonas Fonseca <jonas.fonseca@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 23:58:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZSPz-0002sc-2K
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 23:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbaDMV6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2014 17:58:08 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:36668 "EHLO
	mta5.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbaDMV6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2014 17:58:07 -0400
Received: from odessa (ool-44c07830.dyn.optonline.net [68.192.120.48])
 by mta5.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0N3Z009VLP0R7790@mta5.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Sun, 13 Apr 2014 17:58:04 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.82)
	(envelope-from <kumar.a@utexas.edu>)	id 1WZSPb-0004cM-HB; Sun,
 13 Apr 2014 17:58:03 -0400
In-reply-to: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246215>

These patches add colourization to the log view. They reuse the diff
stat drawing functions from the diff module directly.

This version just includes some code reformatting and minor
fixes. Please comment on what other fixes could help.

Thanks.

Kumar Appaiah (3):
  diff: Move diff stat addition to a common function
  diff: Move diff stat drawing to a common function
  log: Colour the diff stat

 include/tig/diff.h |  2 ++
 src/diff.c         | 57 ++++++++++++++++++++++++++++++++++--------------------
 src/log.c          | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 91 insertions(+), 23 deletions(-)

-- 
1.9.1
