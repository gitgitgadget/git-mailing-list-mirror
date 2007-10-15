From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH 0/5] Add easy access to SVN properties in git-svn.
Date: Mon, 15 Oct 2007 17:34:45 +0200
Message-ID: <1192462485-3730-1-git-send-email-tsuna@lrde.epita.fr>
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 16:38:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhnYz-0006fy-KU
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbXJPOhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932851AbXJPOhh
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:37:37 -0400
Received: from 1.139.39-62.rev.gaoland.net ([62.39.139.1]:56269 "EHLO
	tsunaxbook.lrde.epita.fr" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759203AbXJPOh3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 10:37:29 -0400
Received: by tsunaxbook.lrde.epita.fr (Postfix, from userid 501)
	id D9D68B411B1; Mon, 15 Oct 2007 17:34:45 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.4.214.g6f43
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61181>


Hello,
this is a fairly simple patch series that adds easy access to SVN properties
from within git-svn.

The first patch simply factors some code that was used for
git-svn show-ignore in order to easily implement git-svn create-ignore (2nd
patch).  The 3rd and 4th patch implement git-svn propget / proplist to easily
access SVN properties.  The last patch does some cleanup because I found it
more convenient to not have to remember to add a `\n' at the end of each
error message.

 git-svn.perl             |  201 +++++++++++++++++++++++++++++++++++++---------
 t/t9101-git-svn-props.sh |   72 ++++++++++++++++-
 2 files changed, 233 insertions(+), 40 deletions(-)
