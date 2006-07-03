From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compression speed for large files
Date: Mon, 3 Jul 2006 17:17:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607031702420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <loom.20060703T124601-969@post.gmane.org> 
 <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com> 
 <44A91C7A.6090902@fys.uio.no>  <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain>
 <f36b08ee0607030754k4d10548pfb71dc62c6ee0b21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 17:18:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxQBL-0008DZ-QF
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 17:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWGCPRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 11:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWGCPRs
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 11:17:48 -0400
Received: from mail.gmx.de ([213.165.64.21]:47831 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751197AbWGCPRr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 11:17:47 -0400
Received: (qmail invoked by alias); 03 Jul 2006 15:17:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 03 Jul 2006 17:17:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0607030754k4d10548pfb71dc62c6ee0b21@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23182>

Hi,

On Mon, 3 Jul 2006, Yakov Lerner wrote:

> It would be arguable whether, say, 10% better compression is worth 
> x(3-8) slower compression. But 3-4% better compression at the cost of 
> x(3-8) slower compression time as data suggest ? I think this begs for 
> switching the default to Z_DEFAULT_COMPRESSION

The real problem, of course, is that you cannot know before you tried, if 
your data is really well compressible or not.

Ciao,
Dscho
