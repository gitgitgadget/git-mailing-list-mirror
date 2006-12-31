From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: What commands can and can not be used with bare repositories?
Date: Sun, 31 Dec 2006 07:32:43 +0200
Message-ID: <20061231053243.GB5240@mellanox.co.il>
References: <20061231021248.GA26067@thunk.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 06:37:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0tOO-00008Q-Jf
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 06:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbWLaFhx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 00:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbWLaFhx
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 00:37:53 -0500
Received: from p02c11o142.mxlogic.net ([208.65.145.65]:41093 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932890AbWLaFhw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 00:37:52 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-4.0.1-5)
	with ESMTP id 0bc47954.2635144112.59535.00-008.p02c11o142.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sat, 30 Dec 2006 22:37:52 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 31 Dec 2006 07:34:37 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun, 31 Dec 2006 07:37:43 +0200
To: Theodore Tso <tytso@mit.edu>
Content-Disposition: inline
In-Reply-To: <20061231021248.GA26067@thunk.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 31 Dec 2006 05:34:37.0937 (UTC) FILETIME=[5CA84E10:01C72C9D]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14904.000
X-TM-AS-Result: No--4.867000-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35671>

> That makes sense, although the hueristic for determining whether or
> not "." is a Git repository might be a little interesting.  Say, if
> there is no containing directory which has a .git directory, and the
> directories "objects", "info", and "refs" are present?

Maybe, git clone --bare should create a special file under the
repository directory?
	
-- 
MST
