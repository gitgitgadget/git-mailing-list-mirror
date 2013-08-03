From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: [TIG][PATCH 0/3] Refactoring of the log view
Date: Fri, 02 Aug 2013 20:23:16 -0400
Message-ID: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
Content-Transfer-Encoding: 7BIT
Cc: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
To: git@vger.kernel.org, fonseca@diku.dk
X-From: git-owner@vger.kernel.org Sat Aug 03 02:23:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5Pd2-0000kI-BS
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 02:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067Ab3HCAXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 20:23:23 -0400
Received: from mta1.srv.hcvlny.cv.net ([167.206.4.196]:34220 "EHLO
	mta1.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab3HCAXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 20:23:22 -0400
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta1.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0MQX0028JIEX8XL0@mta1.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Fri, 02 Aug 2013 20:23:22 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V5Pcu-00035r-Q0; Fri,
 02 Aug 2013 20:23:20 -0400
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231550>

Hi.

These set of patches refactor the log view to provide a behaviour that
is quite similar to, say, e-mail with Mutt. The key improvements are:

- The current commit is inferred based on the context. For example, if
  you focus on the commit message of a particular commit, the correct
  commit is inferred automagically.

- Scrolling the log view when the diff is open shows the correct
  commit on the screen, rather than have to scroll up and cross the
  commit line to display the screen.

I have decided to revert 888611dd5d407775245d574a3dc5c01b5963a5ba,
since the behaviour with the updated scrolling pattern is much more
consistent.

As always, I will gladly alter the patch based on comments on coding
style and all other aspects.

Thanks!

Kumar

Kumar Appaiah (3):
  Add log_select function to find commit from context in log view
  Display correct diff the context in split log view
  Revert "Scroll diff with arrow keys in log view"

 NEWS  |  1 +
 tig.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 63 insertions(+), 5 deletions(-)

-- 
1.8.3.2
