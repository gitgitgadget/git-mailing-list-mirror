From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: should git push . from:to work?
Date: Thu, 1 Feb 2007 16:56:59 +0200
Message-ID: <20070201145659.GA30716@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 15:56:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCdMc-0002W7-71
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 15:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422892AbXBAO4d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 09:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422907AbXBAO4d
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 09:56:33 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:33074 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422892AbXBAO4c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 09:56:32 -0500
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l11EuWwZ027473
	for <git@vger.kernel.org>; Thu, 1 Feb 2007 16:56:33 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu,  1 Feb 2007 16:56:59 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38358>

Should I not be able to use . as a URL?
git push seems to think . is a remote, not a URL:

mst@mst-lt:~/scm/sdpnetstat$ git push . refs/heads/master:refs/heads/ofed_1_2
fatal: remote '.' has no URL
mst@mst-lt:~/scm/sdpnetstat$ git push $PWD refs/heads/master:refs/heads/ofed_1_2
updating 'refs/heads/ofed_1_2' using 'refs/heads/master'
  from c16c0acb0906209868d5682d0668ada0f250da02
  to   cfc08ab244ece514f7c453d27397281129f14264
Generating pack...
Done counting 0 objects.
Writing 0 objects.
Total 0 (delta 0), reused 0 (delta 0)
Unpacking 0 objects

refs/heads/ofed_1_2: c16c0acb0906209868d5682d0668ada0f250da02 -> cfc08ab244ece514f7c453d27397281129f14264

So there's an easy workaround, but why does this work for pull but not for push?

-- 
MST
