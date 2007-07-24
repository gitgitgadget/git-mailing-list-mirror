From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: broken link - what is it?
Date: Tue, 24 Jul 2007 12:17:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241214160.14781@racer.site>
References: <20070724102457.GB18701@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIOX-0001XF-2i
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933376AbXGXLRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbXGXLRe
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:17:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:54867 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765001AbXGXLRd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:17:33 -0400
Received: (qmail invoked by alias); 24 Jul 2007 11:17:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 24 Jul 2007 13:17:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/D6CsNZnbDMBiFG6ViIwyUtjYxR+8KAB4n9RucLL
	41slg4XrlZIlX3
X-X-Sender: gene099@racer.site
In-Reply-To: <20070724102457.GB18701@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53569>

Hi,

On Tue, 24 Jul 2007, Michael S. Tsirkin wrote:

> man git-fsck does not document what "broken link" is.
> Can someone enlighten me please?

A broken link is when an object references another object, and the 
latter was not found in the object database.

For example, commits reference parent commits and a tree.  A tree 
references trees and blobs.  A tag references arbitrary objects.

I am not very good in writing documentation... could you give it a try?

Thanks,
Dscho
