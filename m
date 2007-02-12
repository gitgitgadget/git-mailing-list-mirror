From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 07:40:18 +0200
Message-ID: <20070212054018.GC28231@mellanox.co.il>
References: <20070211230204.GE31488@spearce.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 06:39:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGTut-0001Yl-BY
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 06:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933000AbXBLFjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 00:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933001AbXBLFjt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 00:39:49 -0500
Received: from p02c11o145.mxlogic.net ([208.65.145.68]:46545 "EHLO
	p02c11o145.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933000AbXBLFjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 00:39:48 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o145.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 4adffc54.1724353456.45669.00-003.p02c11o145.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sun, 11 Feb 2007 22:39:48 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 12 Feb 2007 07:42:01 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 12 Feb 2007 07:37:48 +0200
Content-Disposition: inline
In-Reply-To: <20070211230204.GE31488@spearce.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 12 Feb 2007 05:42:01.0502 (UTC) FILETIME=[84CE33E0:01C74E68]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14988.001
X-TM-AS-Result: No--12.478200-4.000000-2
X-Spam: [F=0.0745021047; S=0.074(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39368>

> Quoting Shawn O. Pearce <spearce@spearce.org>:
> Subject: Re: Merge git-gui into 1.5.0 ?
> 
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > It may make patching slightly more interesting though, as some
> > > users new to git-gui development may generate a patch in git.git
> > > (using a/git-gui/git-gui.sh as the path) which then would not apply
> > > as-is to the master git-gui development tree.
> > 
> > In this case, a "-p <n>" option to git-am would make sense, no?
> 
> Are you saying we just suddenly found a vaild use for a flag which
> nobody (except the original submitter) thought was useful?  ;-)
> 
> Yes, clearly a -p<n> on git-am would solve the problem quite nicely.

Actually, -p<n> option to git-am is also useful for piping
patches to git-am directly from mail: sometimes people would generate
a patch by hand and this results in patches incorrect -p level.
	
-- 
MST
