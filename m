From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Submodules and rewind
Date: Tue, 19 Feb 2008 14:06:04 -0800
Organization: Vyatta
Message-ID: <20080219140604.04afc91f@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 23:07:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRacH-0002FA-Lw
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 23:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667AbYBSWGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 17:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756441AbYBSWGM
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 17:06:12 -0500
Received: from mail.vyatta.com ([216.93.170.194]:43286 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755272AbYBSWGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 17:06:10 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id 92F7A4F8055;
	Tue, 19 Feb 2008 14:06:09 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.321
X-Spam-Level: 
X-Spam-Status: No, score=-2.321 tagged_above=-10 required=5 tests=[AWL=0.179,
	BAYES_00=-2.599, RDNS_DYNAMIC=0.1]
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Giwof-nrEDm; Tue, 19 Feb 2008 14:06:06 -0800 (PST)
Received: from extreme (75-175-36-117.ptld.qwest.net [75.175.36.117])
	by mail.vyatta.com (Postfix) with ESMTP id EFED04F804E;
	Tue, 19 Feb 2008 14:06:05 -0800 (PST)
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74465>

I am beginning to think sub-modules in git are as fragile
and error prone as master documents in Microsuck word.

Because of a bone headed merge, I had to rewind one project back
to a known good state, but the sub module stuff is now wedged and
brain stuck on the old commit id.

Isn't there some simple way to do 'git sub-module remove' followed
by 'git sub-module add' to reset the internal index?
