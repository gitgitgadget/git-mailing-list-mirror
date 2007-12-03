From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Incorrect git-blame result if I use full path to file
Date: Mon, 3 Dec 2007 18:09:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031807410.27959@racer.site>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
 <7vhcj0seok.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.9999.0712030922250.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:09:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzFjp-0004Wb-4N
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbXLCSJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbXLCSJ3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:09:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:42573 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750969AbXLCSJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:09:28 -0500
Received: (qmail invoked by alias); 03 Dec 2007 18:09:26 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 03 Dec 2007 19:09:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/oUgNrQo/UWA+othNbvKWXFpx3+qNZjuiviRMpr
	gnHw6Pwe01Fwue
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.9999.0712030922250.8458@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66936>

Hi,

On Mon, 3 Dec 2007, Linus Torvalds wrote:

> It [the patch] makes "get_pathspec()" make all the paths it returns 
> relative, if it can. HOWEVER! I think it should actually die() if it 
> sees an absolute path that it cannot convert (because it really cannot 
> do anything sane about it), but I commented that out for now because 
> that requires some test case change: right now we actually have a few 
> test cases for insane filename arguments, and they expect the old 
> behaviour.

I have the slight suspicion that this could break diff --no-index.  And it 
does not contain any symlink resolution, right?

Ciao,
Dscho
