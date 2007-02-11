From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 00:08:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702120003450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702111252.28393.bruno@clisp.org>
 <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070211230035.GD31488@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bruno Haible <bruno@clisp.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:08:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGNoD-00062a-HE
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbXBKXIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbXBKXIe
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:08:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:36944 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750909AbXBKXId (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:08:33 -0500
Received: (qmail invoked by alias); 11 Feb 2007 23:08:32 -0000
X-Provags-ID: V01U2FsdGVkX1/tP/1Fj+btj+pE11Xy/SPbW8bCelCmumTVuZthQ2
	klUQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070211230035.GD31488@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39324>

Hi,

On Sun, 11 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > 1) Why so much user CPU time?
> > 
> > See above.
> 
> Some of the ideas Nico and I have kicked around for a pack v4 (post
> 1.5.0, obviously) would speed up revision traversal by bypassing
> some of the costly decompression overheads.

Maybe. But my point (which you did not quote) was this: git log _starts_ 
very fast, and the information you are most likely after is shown right 
away. So I don't think it makes sense investing much time to enhance 
performance for a full log.

> > > 2) Why so much system CPU time, but only on MacOS X?
> > 
> > Probably the mmap() problem. Does it go away when you use git 1.5.0-rc4?
> 
> What does 1.5.0-rc4 do here that didn't happen before?  Are you
> referring to the mmap sliding window?

No. I was referring to v1.5.0-rc0~62, but was too lazy to look that up.

Ciao,
Dscho
