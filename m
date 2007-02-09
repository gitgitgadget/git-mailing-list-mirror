From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Git rescue mission
Date: Fri, 9 Feb 2007 10:58:34 +0200
Message-ID: <20070209085834.GS6560@mellanox.co.il>
References: <17867.46325.433406.974582@lisa.zopyra.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 09:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFRaE-0004XA-Gx
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 09:58:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946231AbXBII6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 03:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946232AbXBII6M
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 03:58:12 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:33741 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946231AbXBII6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 03:58:11 -0500
Received: from unknown [194.90.237.34] (EHLO p02c11o141.mxlogic.net)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 3a73cc54.1901067184.50273.00-500.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 09 Feb 2007 01:58:11 -0700 (MST)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id e973cc54.1974496176.50262.00-004.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Fri, 09 Feb 2007 01:58:06 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Feb 2007 11:00:13 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri,  9 Feb 2007 10:55:57 +0200
Content-Disposition: inline
In-Reply-To: <17867.46325.433406.974582@lisa.zopyra.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 09 Feb 2007 09:00:14.0205 (UTC) FILETIME=[B62B6AD0:01C74C28]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14986.003
X-TM-AS-Result: No--0.407300-4.000000-31
X-Spam: [F=0.4279804185; S=0.427(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39167>

> So, I assume I need to tell our developers that once we have installed
> the new git, they will need to set aside their old repos and just
> clone again from our company repo?

Hint:
If a developer has some relevant data in his old private repository, he can always
pull from old to new repository there after he clones from the public repository.

This way you won't lose any data in the conversion.

-- 
MST
