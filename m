From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git reset --hard" not cleaning up working copy?
Date: Mon, 7 May 2007 13:13:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705071312400.4167@racer.site>
References: <200705070951.39677.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 07 13:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl19d-000731-Rp
	for gcvg-git@gmane.org; Mon, 07 May 2007 13:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbXEGLNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 07:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbXEGLNS
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 07:13:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:52820 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932280AbXEGLNR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 07:13:17 -0400
Received: (qmail invoked by alias); 07 May 2007 11:13:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 07 May 2007 13:13:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mRFA9Zijm5Bg2xlM/oqRjIRS/7AZ/918WmN3vVk
	4Z0mZB4oYE4z8e
X-X-Sender: gene099@racer.site
In-Reply-To: <200705070951.39677.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46445>

Hi,

On Mon, 7 May 2007, Johan Herland wrote:

> When I "git reset --hard HEAD" to purge all my non-committed changes, it 
> seems that files I created after the last commit (but not part of the 
> index) are left lying around my working copy. Is this intended?

Bien sur it is intended! Git has no business deleting files it has not 
been told about.

What you probably want is "git clean" after that reset...

Hth,
Dscho
