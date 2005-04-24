From: Christopher Li <git@chrisli.org>
Subject: NULL check for malloc?
Date: Sun, 24 Apr 2005 10:03:41 -0400
Message-ID: <20050424140341.GA15158@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 24 20:00:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPlP1-0005a6-LS
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 20:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVDXSFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 14:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVDXSFJ
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 14:05:09 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:43165 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262358AbVDXSFH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 14:05:07 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005042418050601400olc79e>; Sun, 24 Apr 2005 18:05:06 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 00B653F1AC; Sun, 24 Apr 2005 10:03:41 -0400 (EDT)
To: git mailing list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I notice that there are lots of malloc call without
checking the return NULL pointer.

Should we just have some wrapper function for malloc
just die if malloc fails?

Chris
