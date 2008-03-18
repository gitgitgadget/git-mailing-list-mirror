From: Neil Schemenauer <nas@arctrix.com>
Subject: How to undo git-rm?
Date: Tue, 18 Mar 2008 17:04:41 -0600
Message-ID: <20080318230441.GA664@arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 01:15:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8Re-00025w-HA
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:15:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbYCTAOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 20:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940009AbYCTAOr
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:14:47 -0400
Received: from vapor.arctrix.com ([66.220.1.99]:35644 "HELO vapor.arctrix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S939983AbYCTAOo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:14:44 -0400
X-Greylist: delayed 11639 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Mar 2008 20:14:44 EDT
Received: (qmail 712 invoked by uid 1000); 18 Mar 2008 23:04:41 -0000
Content-Disposition: inline
X-PGP-Fingerprint: 9B3B 987B F40E 9320 0619  0A17 A366 302E B1DE 86CE
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77593>

Hi,

This seemingly simple operation has me stumped.  I removed something
from my try using "git rm" and now I want it back.  With SVN I would
use "svn cat <path> > <path>".  After some searching around, I
though git-cat-file would do the trick.  Alas, it appears as though
it looks up the SHA for the path in the index and so it too fails.

  Neil
