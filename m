From: Neil Schemenauer <nas@arctrix.com>
Subject: State of the art svn to git conversion?
Date: Mon, 7 Apr 2008 12:50:16 -0600
Message-ID: <20080407185016.GA834@arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 20:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiwQo-0001xU-6R
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 20:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYDGSuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 14:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbYDGSuS
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 14:50:18 -0400
Received: from vapor.arctrix.com ([66.220.1.99]:37964 "HELO vapor.arctrix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751814AbYDGSuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 14:50:17 -0400
Received: (qmail 918 invoked by uid 1000); 7 Apr 2008 18:50:16 -0000
Content-Disposition: inline
X-PGP-Fingerprint: 9B3B 987B F40E 9320 0619  0A17 A366 302E B1DE 86CE
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78987>

Hi,

I'm attempting to convert a fairly large SVN repository to git
(about 60000 revisions, quite a few branches and tags).  It looks
like git-svn is the main tool for this purpose but it is very slow.
The initial fetch takes many hours to finish (yes, I'm working
locally) and seems to periodically die after a few thousand
revisions.

Is git-svn really the best tool?  Ideally I would like to feed an
svn dump into some tool and end up with a git repository.  If I
would feed incremental dumps into tool after the initial conversion
that would be even better.

  Neil
