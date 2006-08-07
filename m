From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Problem with clone hanging
Date: Mon, 7 Aug 2006 23:05:40 +0300
Message-ID: <20060807200540.GA24206@mellanox.co.il>
References: <20060807183230.GA14955@procyon.home>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan O'Sullivan <bos@serpentine.com>,
	Erik Mouw <erik@harddisk-recovery.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 22:04:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GABKf-00063K-K5
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 22:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWHGUEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWHGUEJ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 16:04:09 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:52461 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S932337AbWHGUEI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 16:04:08 -0400
Received: from unknown [194.90.237.34]
	by p02c11o141.mxlogic.net (mxl_mta-3.0.0-12)
	with SMTP id 4bc97d44.2257021872.46149.00-046.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 07 Aug 2006 14:04:04 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 7 Aug 2006 23:09:46 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  7 Aug 2006 23:05:40 +0300
To: Sergey Vlasov <vsu@altlinux.ru>
Content-Disposition: inline
In-Reply-To: <20060807183230.GA14955@procyon.home>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 07 Aug 2006 20:09:46.0718 (UTC) FILETIME=[6E04EFE0:01C6BA5D]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25038>

Quoting r. Sergey Vlasov <vsu@altlinux.ru>:
> Subject: Re: Problem with clone hanging
> 
> On Mon, Aug 07, 2006 at 11:23:20AM -0700, Bryan O'Sullivan wrote:
> > On Mon, 2006-08-07 at 21:52 +0400, Sergey Vlasov wrote:
> > 
> > > In the meantime, you can try to specify a local clone of the mainline
> > > Linux repository with the --reference=... option to git-clone. 
> > 
> > Thanks.  I don't know if what I'm cloning is actually a kernel tree,
> > unfortunately.
> 
> At least git ls-remote git://www.mellanox.co.il/~git/infiniband
> suggests this.  Of course, it might contains some completely unrelated
> branches (with git this is possible), but at least you won't need to
> download the whole kernel history since 2.6.12-rc2.

Exactly. It's a kernel-tree + other stuff.

-- 
MST
