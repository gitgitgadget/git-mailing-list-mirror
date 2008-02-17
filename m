From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: segfault in http-push
Date: Sun, 17 Feb 2008 23:23:38 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802172321551.30505@racer.site>
References: <20080217220013.GA12419@hash.localnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bob Copeland <me@bobcopeland.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 00:24:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQssC-00069y-PN
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 00:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbYBQXXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 18:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754197AbYBQXXu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 18:23:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:43787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753111AbYBQXXu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 18:23:50 -0500
Received: (qmail invoked by alias); 17 Feb 2008 23:23:47 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 18 Feb 2008 00:23:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+W/pxh/oeWRkfCExnn2s+8uSYipe00Op67Oigtf+
	Mze0gfFU5+Bt5B
X-X-Sender: gene099@racer.site
In-Reply-To: <20080217220013.GA12419@hash.localnet>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74203>

Hi,

On Sun, 17 Feb 2008, Bob Copeland wrote:

> With 1.4.5.2, I see this whenever I try to push a new branch over http:

I can only suspect that you mean 1.5.4.2, not 1.4.5.2 (which I could not 
find).

Alas, a fix I provided for exactly this case did not make it into master 
yet, let alone into any released version.  Can you please test the current 
"next"?

FWIW, the fix is add8e8ce(http-push: avoid invalid memory accesses).

Thanks,
Dscho
