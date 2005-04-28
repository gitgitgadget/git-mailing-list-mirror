From: Chris Mason <mason@suse.com>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 16:58:38 -0400
Message-ID: <200504281658.39300.mason@suse.com>
References: <200504271251.00635.mason@suse.com> <200504280745.05505.mason@suse.com> <1114715496.4212.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 22:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRG0W-0000PF-Tt
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 22:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVD1U6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 16:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVD1U6p
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 16:58:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:63143 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262160AbVD1U6n (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 16:58:43 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9FB0F9C74;
	Thu, 28 Apr 2005 22:58:42 +0200 (CEST)
Received: from watt.suse.com (cpe-66-66-175-36.rochester.res.rr.com [66.66.175.36])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by extimap.suse.de (Postfix) with ESMTP
	id 5360514D25C; Thu, 28 Apr 2005 22:58:42 +0200 (CEST)
To: Kay Sievers <kay.sievers@vrfy.org>
User-Agent: KMail/1.8
In-Reply-To: <1114715496.4212.36.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 28 April 2005 15:11, Kay Sievers wrote:
>
> Can you confirm this with the kernel tree?
>   file-changes -c 9acf6597c533f3d5c991f730c6a1be296679018e
> drivers/usb/core/usb.c
>
> lists the commit:
>   diff-tree -r 1d66c64c3cee10a465cd3f8bd9191bbeb718f650
> c79bea07ec4d3ef087962699fe8b2f6dc5ca7754
> f0534ee064901d0108eb7b2b1fcb59a98bb53c2b->c231b4bef314284a168fedb6c5f6c47ae
>c5084fc drivers/usb/core/usb.c cat-file commit
> c79bea07ec4d3ef087962699fe8b2f6dc5ca7754
>
> which seems not to have changed the file asked for.

Hmmm, that does work here:

coffee:/src/git # diff-tree -r 1d66c64c3cee10a465cd3f8bd9191bbeb718f650 c79bea07ec4d3ef087962699fe8b2f6dc5ca7754 | grep usb.core.usb.c
*100644->100644 blob    f0534ee064901d0108eb7b2b1fcb59a98bb53c2b->c231b4bef314284a168fedb6c5f6c47aec5084fc      drivers/usb/core/usb.c

-chris
