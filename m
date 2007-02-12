From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 07:59:03 +0200
Message-ID: <20070212055903.GD28231@mellanox.co.il>
References: <7vvei89b9k.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 06:58:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUCz-0001mK-6N
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 06:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017AbXBLF6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 00:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933010AbXBLF6e
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 00:58:34 -0500
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:42705 "EHLO
	p02c11o146.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933017AbXBLF6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 00:58:33 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o146.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 90200d54.1787718576.49438.00-002.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sun, 11 Feb 2007 22:58:33 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 12 Feb 2007 08:00:47 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 12 Feb 2007 07:56:33 +0200
Content-Disposition: inline
In-Reply-To: <7vvei89b9k.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 12 Feb 2007 06:00:47.0127 (UTC) FILETIME=[23BAF270:01C74E6B]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14988.001
X-TM-AS-Result: No--12.400300-4.000000-31
X-Spam: [F=0.0371778475; S=0.037(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39371>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: Merge git-gui into 1.5.0 ?
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> > Actually, -p<n> option to git-am is also useful for piping
> > patches to git-am directly from mail: sometimes people would generate
> > a patch by hand and this results in patches incorrect -p level.
> 
> You also would need negative -p option to deal with it as well.
> Think of getting "diff a/git-add.txt b/git-add.txt" and wanting
> to apply it to Documentation/git-add.txt.

Heh, right. With patch I just switch to another shell, cd to the correct
directory, start mutt *there* and pipe the message to patch.  Since this already
seems to work for git-apply, maybe this can be made to work with git-am as well?

Currently:
$git-am mbox
fatal: Not a git repository: '.git'
You need to run this command from the toplevel of the working tree.

-- 
MST
