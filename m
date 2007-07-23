From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: RFC: git pull or git rebase?
Date: Mon, 23 Jul 2007 12:31:42 +0300
Message-ID: <20070723093142.GE20614@mellanox.co.il>
References: <20070723052223.GA20614@mellanox.co.il>
	<81b0412b0707230207k2fa33eb3hdc23319d1f8dbd80@mail.gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 11:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICuGe-0001Q4-0J
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 11:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755529AbXGWJbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 05:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbXGWJbl
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 05:31:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:56792 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbXGWJbk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 05:31:40 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1137120ugf
        for <git@vger.kernel.org>; Mon, 23 Jul 2007 02:31:38 -0700 (PDT)
Received: by 10.67.29.12 with SMTP id g12mr4059993ugj.1185183098061;
        Mon, 23 Jul 2007 02:31:38 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTPS id p32sm1748523ugc.2007.07.23.02.31.34
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2007 02:31:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0707230207k2fa33eb3hdc23319d1f8dbd80@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53418>

> Quoting Alex Riesen <raa.lkml@gmail.com>:
> Subject: Re: RFC: git pull or git rebase?
> 
> On 7/23/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> >However, I wonder whether this happens to others, too.
> >Would it make sense to add a branch attribute that says
> >"do not pull this branch" or "do not rebase this branch"?
> >Maybe even make git do the right thing automatically,
> >so that git would look at this attribute and perform
> >pull or rebase as appropriate?
> 
> If you have a recent enough git, it will refuse to pull into
> a branch for which there is no configured remote branch.
> Exactly for a reason like yours.

Aha. I created the tree by git clone, so my master
is configured to merge from origin automatically.

-- 
MST
