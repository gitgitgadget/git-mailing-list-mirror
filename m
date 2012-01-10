From: Victor Engmark <victor.engmark@terreactive.ch>
Subject: git svn dcommit sends to wrong branch
Date: Tue, 10 Jan 2012 17:18:43 +0100
Message-ID: <20120110161843.GC8196@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 17:19:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkePb-0007GE-BH
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 17:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478Ab2AJQSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 11:18:54 -0500
Received: from gate.terreactive.ch ([212.90.202.121]:39477 "EHLO
	mail.terreactive.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417Ab2AJQSx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 11:18:53 -0500
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-terreActive-From: victor.engmark@terreactive.ch
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188265>

Commands:

git svn clone -s -r 1:HEAD http://svn/repo
cd repo
git commit [thrice, in master only]
git rebase --interactive HEAD~20 [i.e., started rebase in commits before
the clone]
[Merged two commits I had made *after* the clone]
git commit ...
git dcommit

This created commits on
<http://svn/repo/branches/branch_name>! Why? Is it because HEAD~20's
git-svn-id <http://svn/repo/branches/branch_name@22481> is on that
branch?

And more importantly, how do I "replay" my commits on trunk?

-- 
terreActive AG
Kasinostrasse 30
CH-5001 Aarau
Tel: +41 62 834 00 55
Fax: +41 62 823 93 56
www.terreactive.ch

Wir sichern Ihren Erfolg - seit 15 Jahren
