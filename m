From: Stephen Hemminger <stephen.hemminger@vyatta.com>
Subject: submodules and branches
Date: Thu, 24 Apr 2008 17:41:42 -0700
Organization: Vyatta
Message-ID: <20080424174142.5dbb6ae3@speedy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 02:42:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpC1O-0003aj-Q8
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 02:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbYDYAlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 20:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbYDYAlr
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 20:41:47 -0400
Received: from mail.vyatta.com ([216.93.170.194]:42139 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346AbYDYAlq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 20:41:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id 1405A4F8052
	for <git@vger.kernel.org>; Thu, 24 Apr 2008 17:41:46 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=3
	tests=[BAYES_00=-2.599, RDNS_DYNAMIC=0.1]
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vtk0oDmPXtcF for <git@vger.kernel.org>;
	Thu, 24 Apr 2008 17:41:43 -0700 (PDT)
Received: from speedy (97-115-66-101.ptld.qwest.net [97.115.66.101])
	by mail.vyatta.com (Postfix) with ESMTP id 82C934F804D
	for <git@vger.kernel.org>; Thu, 24 Apr 2008 17:41:43 -0700 (PDT)
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80318>

Our CM team likes to use both submodules and branches and it doesn't
always work cleanly.  Some examples:

1. The new release on branch "next_release" adds a submodule, but then the
submodule shows up on all branches including the production branch.

2. For next release on branch "next_release" a submodule was renamed by
moving the target directory, but now git submodule update makes two copies.

Git generally does a good job of tracking renames and deletions, so the fact
that submodules leave stuff behind is surprising.
