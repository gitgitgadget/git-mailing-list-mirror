From: "Steven A. Falco" <sfalco@harris.com>
Subject: How can I figure out what commits relate to a given diff?
Date: Thu, 22 May 2008 11:21:34 -0400
Message-ID: <48358F7E.6030401@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 17:43:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzCx8-00039a-9X
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 17:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbYEVPmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 11:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbYEVPmf
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 11:42:35 -0400
Received: from mlbe2k1.cs.myharris.net ([137.237.90.88]:9141 "EHLO
	mlbe2k1.cs.myharris.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbYEVPme (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 11:42:34 -0400
X-Greylist: delayed 1255 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 May 2008 11:42:34 EDT
Received: from mail pickup service by mlbe2k1.cs.myharris.net with Microsoft SMTPSVC;
	 Thu, 22 May 2008 11:21:36 -0400
Received: from saf.cs.myharris.net ([137.237.94.251]) by mlbe2k1.cs.myharris.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 22 May 2008 11:21:34 -0400
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 22 May 2008 15:21:34.0917 (UTC) FILETIME=[8575FF50:01C8BC1F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82634>

I have a patch file, and I'd like to figure out which commits were used
to produce it.

For example, one of the diffs in the patch file begins with:

diff --git a/Makefile b/Makefile
index 9ceadaa..ad31bc6 100644

Is there a way to map a blob SHA1 to a commit?  In this example, I'd
like to map 9ceadaa and ad31bc6 to their commits.  It seems easy to go
the other way, seeing what is in a commit, but I've not been able to
find a method for going "backwards" from a blob to a commit.

    Thanks,
    Steve
