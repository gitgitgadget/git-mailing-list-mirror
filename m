From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: How to commit removed file?
Date: Tue, 2 Jan 2007 22:10:41 +0200
Message-ID: <20070102201041.GB10451@mellanox.co.il>
References: <20061231102444.GD26552@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 02 21:10:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1pxs-0004Ma-OU
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 21:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbXABUKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 15:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754930AbXABUKZ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 15:10:25 -0500
Received: from p02c11o142.mxlogic.net ([208.65.145.65]:54263 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbXABUKY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 15:10:24 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-4.0.1-5)
	with ESMTP id 03cba954.2405587888.458.00-003.p02c11o142.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Tue, 02 Jan 2007 13:10:24 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 2 Jan 2007 22:11:48 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Tue,  2 Jan 2007 22:08:33 +0200
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20061231102444.GD26552@mellanox.co.il>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 02 Jan 2007 20:11:48.0768 (UTC) FILETIME=[3BE74A00:01C72EAA]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14912.000
X-TM-AS-Result: No--6.256700-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35811>

> I'd like to remove a file and commit the removal while
> leaving out other changes in repository/index.
> 
> $git rm kernel_patches/fixes/ib_verbs_warning_fix.patch
> rm 'kernel_patches/fixes/ib_verbs_warning_fix.patch'
> 
> $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
> error: pathspec 'kernel_patches/fixes/ib_verbs_warning_fix.patch' did not match
> any file(s) known to git.
> Did you forget to 'git add'?
> 
> A similiar thing works with "git add".

Any ideas? Can this be done with git?

-- 
MST
