From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 04:40:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709040439070.28586@racer.site>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com> 
 <20070904025153.GS18160@spearce.org> <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 05:41:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISPHe-0004T3-SG
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 05:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbXIDDkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 23:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbXIDDkx
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 23:40:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:33462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750997AbXIDDkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 23:40:53 -0400
Received: (qmail invoked by alias); 04 Sep 2007 03:40:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 04 Sep 2007 05:40:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/g4twFvhTg0kje4YYJ5exwKjIj98O/C26B/4j32Q
	BUq1dGm4NLWdUj
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57516>

Hi,

On Mon, 3 Sep 2007, Jon Smirl wrote:

> Are tree objects really needed?

Yes.  For performance reasons, since a simple commit would kill you in any 
reasonably sized repo.

Hth,
Dscho
