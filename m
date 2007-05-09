From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Thu, 10 May 2007 00:23:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705100015120.4167@racer.site>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site>
 <20070509123205.GN4489@pasky.or.cz> <Pine.LNX.4.64.0705091447110.4167@racer.site>
 <Pine.LNX.4.64.0705091210570.18541@iabervon.org> <Pine.LNX.4.64.0705091822590.4167@racer.site>
 <20070509170725.GB23778@fieldses.org> <Pine.LNX.4.64.0705092208230.4167@racer.site>
 <Pine.LNX.4.64.0705091625200.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Petr Baudis <pasky@suse.cz>, kha@treskal.com, junio@cox.net,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 10 00:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HluZh-0002Sn-Sd
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759793AbXEIWXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759711AbXEIWXv
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:23:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:47433 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759854AbXEIWXu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 18:23:50 -0400
Received: (qmail invoked by alias); 09 May 2007 22:23:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 10 May 2007 00:23:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XOT0bruTXnTXINvveOyuawjQnw4vBTzvfmyCCJx
	tlWNCokxhEUg/L
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0705091625200.18541@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46802>

Hi,

On Wed, 9 May 2007, Daniel Barkalow wrote:

> On Wed, 9 May 2007, Johannes Schindelin wrote:
> 
> > If you tell Git that it should look for commit e83c6516..., it will 
> > store the sha1 as 0xe8 0x3c 0x65 0x16 ... in memory, no matter which 
> > endianness the processor has.
> 
> But it would be really weird to get 0x90 0xf2 0x4a 0x60 ... 0x16 0x65 
> 0x3c 0xe8 unless you've got a 160-bit little-endian processor. That 
> would be as strange as having "Test" stored as 0x74 0x73 0x65 0x54, I 
> think.

I was not aware originally, that no arithmetic is involved in SHA-1 
computation.

If you store large integers, it makes tons of sense to follow the 
endianness, especially if you do _both_ boolean and integer operations on 
them.

> > Which was positively confusing for me, since I automatically searched 
> > for the sequence 0x90 0xf2 0x4a 0x60 ... (which is the tail of that 
> > hash).
> > 
> > But if all this sounds too confusing, I agree to delete the 
> > "(big-endian)".
> 
> If it confused you, there should be something there. Maybe "(in order)" 
> or something else implying that the underlying type is an octet 
> sequence, rather than a 160-bit integer?

Well, I am convinced by now that nobody could be as stupid as me, so I 
think it is good without such a hint :-)

Ciao,
Dscho
