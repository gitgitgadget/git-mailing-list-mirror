From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Sat, 24 Feb 2007 03:15:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240314250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <alpine.LRH.0.82.0702232046300.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 24 03:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKmRc-0002cX-2I
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 03:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340AbXBXCPZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 21:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933342AbXBXCPZ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 21:15:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:43209 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933340AbXBXCPY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 21:15:24 -0500
Received: (qmail invoked by alias); 24 Feb 2007 02:15:22 -0000
X-Provags-ID: V01U2FsdGVkX18+edlrYa4+RdraiNGVie7uZbPzjC5kJRy0jBT54U
	0ASQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LRH.0.82.0702232046300.29426@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40496>

Hi,

On Fri, 23 Feb 2007, Nicolas Pitre wrote:

> On Sat, 24 Feb 2007, Johannes Schindelin wrote:
> 
> > Since most servers will not have a no-progress aware upload-pack, how 
> > about this? (It is slightly ugly, but at least works...)
> 
> Just slightly.
> 
> Why not simply filtering any string that ends in '\r' ?

As I mentioned in another mail, I find this issue not so ugly as that the 
patch touches a totally unrelated file, builtin-archive.c.

Ciao,
Dscho
