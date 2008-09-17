From: Johannes Sixt <j.sixt@viscovery.net>
Subject: combined diff, but not condensed, howto?
Date: Wed, 17 Sep 2008 10:00:07 +0200
Message-ID: <48D0B907.7040903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 17 10:02:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfryZ-0005kY-J9
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 10:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbYIQIAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 04:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYIQIAU
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 04:00:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12989 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYIQIAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 04:00:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KfrxP-0008Hv-B5
	for git@vger.kernel.org; Wed, 17 Sep 2008 10:00:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP id 37CC4AFCC
	for <git@vger.kernel.org>; Wed, 17 Sep 2008 10:00:07 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96072>

After a merge conflict, 'git diff' shows a combined diff, which presents
only the parts that conflicted or where there are near-by changes from
different parents (potential conflicts). Is there a command line switch so
that *all* changes are shown, even non-conflicting ones?

'git diff', 'git diff --cc', and 'git diff -c' all show the same output.

-- Hannes
