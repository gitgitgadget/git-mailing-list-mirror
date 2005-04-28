From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 23:33:06 +0200
Message-ID: <1114723987.4212.51.camel@localhost.localdomain>
References: <200504271251.00635.mason@suse.com>
	 <200504280745.05505.mason@suse.com>
	 <1114715496.4212.36.camel@localhost.localdomain>
	 <200504281658.39300.mason@suse.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 23:29:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGYJ-0004do-S8
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVD1Vd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVD1Vd3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:33:29 -0400
Received: from soundwarez.org ([217.160.171.123]:442 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262225AbVD1VdM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 17:33:12 -0400
Received: from dhcp-113.off.vrfy.org (c196135.adsl.hansenet.de [213.39.196.135])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 09E4F2822F;
	Thu, 28 Apr 2005 23:33:06 +0200 (CEST)
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504281658.39300.mason@suse.com>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 16:58 -0400, Chris Mason wrote:
> On Thursday 28 April 2005 15:11, Kay Sievers wrote:
> >
> > Can you confirm this with the kernel tree?
> >   file-changes -c 9acf6597c533f3d5c991f730c6a1be296679018e
> > drivers/usb/core/usb.c
> >
> > lists the commit:
> >   diff-tree -r 1d66c64c3cee10a465cd3f8bd9191bbeb718f650
> > c79bea07ec4d3ef087962699fe8b2f6dc5ca7754
> > f0534ee064901d0108eb7b2b1fcb59a98bb53c2b->c231b4bef314284a168fedb6c5f6c47ae
> >c5084fc drivers/usb/core/usb.c cat-file commit
> > c79bea07ec4d3ef087962699fe8b2f6dc5ca7754
> >
> > which seems not to have changed the file asked for.
> 
> Hmmm, that does work here:
> 
> coffee:/src/git # diff-tree -r 1d66c64c3cee10a465cd3f8bd9191bbeb718f650 c79bea07ec4d3ef087962699fe8b2f6dc5ca7754 | grep usb.core.usb.c
> *100644->100644 blob    f0534ee064901d0108eb7b2b1fcb59a98bb53c2b->c231b4bef314284a168fedb6c5f6c47aec5084fc      drivers/usb/core/usb.c
> 
> -chris
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Sure. But file-changes lists the commit:
  c79bea07ec4d3ef087962699fe8b2f6dc5ca7754

when asked for:
  "drivers/usb/core/usb.c"

and that file isn't touched there. Actually it lists merge-commits which
are not related to the file.

Thanks,
Kay


