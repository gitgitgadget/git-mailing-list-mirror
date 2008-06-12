From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT RFC] Commit behaviour
Date: Fri, 13 Jun 2008 01:39:55 +0200
Message-ID: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 01:44:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6wT6-0002ZA-EB
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 01:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbYFLXnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 19:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbYFLXnN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 19:43:13 -0400
Received: from [83.140.172.130] ([83.140.172.130]:29438 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754035AbYFLXnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 19:43:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DBB3C1434DF5;
	Fri, 13 Jun 2008 01:43:10 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGg80iy5+kKG; Fri, 13 Jun 2008 01:43:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id EDE3B800691;
	Fri, 13 Jun 2008 01:43:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.178.g1f811
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84813>


I got annoyed about having change my selection to a project to be able
to commit. This tentative feature allows me to hit the commit button
when any resource is selected and figure out which resources have been
modified. This makes it much easier to commit. Only the toolbar commit
is affected for now.

Another twist would be to list all changed resources, but only enable
the selected ones, or only the ones in in the same projects as the selected
resources. Comments?

Code is not efficient either. This is question about the user interface.

Then we could ask ourselved, should we do something similar for Checkout
and reset too? I think that is not as important as those operations are
much less frequent.

-- robin
