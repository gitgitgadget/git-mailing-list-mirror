From: Johannes Sixt <j.sixt@viscovery.net>
Subject: diff-tree -r and new directories
Date: Thu, 10 Apr 2008 08:29:47 +0200
Message-ID: <47FDB3DB.8020705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 10 08:30:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjqIt-0005Ak-HY
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbYDJG3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752350AbYDJG3u
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:29:50 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:6155 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYDJG3t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:29:49 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JjqI7-0007K4-O2
	for git@vger.kernel.org; Thu, 10 Apr 2008 08:29:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP id 83F2A6C4
	for <git@vger.kernel.org>; Thu, 10 Apr 2008 08:29:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79169>

In one of my scriptlets I have this:

   git diff-tree -r --name-only --diff-filter=AM -z "$rev" HEAD --

and I had assumed that only files would ever be listed because of the -r
switch. But this is not true: If there is a new directory, it lists only
the directory's name instead of the files. Is this the intent? Is it worth
changing?

-- Hannes
