From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Restricting access to a branch
Date: Wed, 21 May 2008 16:36:16 -0700
Organization: Vyatta
Message-ID: <20080521163616.31fad56f@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 22 01:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jyxrs-0002pv-Jt
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 01:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763910AbYEUXgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 19:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762943AbYEUXgU
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 19:36:20 -0400
Received: from mail.vyatta.com ([216.93.170.194]:60105 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762902AbYEUXgU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 19:36:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id 00D494F4241
	for <git@vger.kernel.org>; Wed, 21 May 2008 16:36:20 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -1.92
X-Spam-Level: 
X-Spam-Status: No, score=-1.92 tagged_above=-10 required=3 tests=[AWL=-1.204,
	BAYES_00=-2.599, FH_HOST_EQ_VERIZON_P=0.001, RCVD_IN_PBL=0.905,
	RCVD_IN_SORBS_DUL=0.877, RDNS_DYNAMIC=0.1]
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z1k-m-tgs6aI for <git@vger.kernel.org>;
	Wed, 21 May 2008 16:36:19 -0700 (PDT)
Received: from extreme (pool-71-245-98-107.ptldor.fios.verizon.net [71.245.98.107])
	by mail.vyatta.com (Postfix) with ESMTP id 9A83D4F4229
	for <git@vger.kernel.org>; Wed, 21 May 2008 16:36:19 -0700 (PDT)
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82586>

Is there some standard way to freeze a branch and not allow anymore changes to
be pushed?

Yes, I know it is possible by playing with hook files, but that doesn't seem
very admin friendly.
