From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 13 Dec 2007 14:18:43 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712131417110.27959@racer.site>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
 <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
 <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
 <20071212041002.GN14735@spearce.org> <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com>
 <20071212052329.GR14735@spearce.org> <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com>
 <Pine.LNX.4.64.0712121814260.27959@racer.site>
 <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com>
 <Pine.LNX.4.64.0712121931050.27959@racer.site> <7vhcin3rv4.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712131248500.27959@racer.site> <47613BA6.1060705@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 15:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ov8-0005tl-Jc
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 15:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbXLMOSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 09:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbXLMOSw
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 09:18:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:34098 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754111AbXLMOSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 09:18:51 -0500
Received: (qmail invoked by alias); 13 Dec 2007 14:18:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 13 Dec 2007 15:18:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/p9p5ZEgnp7vkDB+JnLw9W6VA3uEalZuU2P7jT5N
	ALEYNLUEA14mCi
X-X-Sender: gene099@racer.site
In-Reply-To: <47613BA6.1060705@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68159>

Hi,

On Thu, 13 Dec 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Thu, 13 Dec 2007, Junio C Hamano wrote:
> > 
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >>> For this to work, apply has to be called with --unidiff-zero, since 
> >>> the new hunks can start or stop with a "-" or "+" line.
> >> You do not have to do "unidiff zero".  Suppose you have this hunk you 
> >> need to split.
> >>
> >> [describes to pick zero or more '-' lines and zero or more '+' lines]
> > 
> > I thought about that, but the UI is not trivial.  The UI for my 
> > solution is.
> 
> It's probably sufficient to have an option "Stage this Line": Once you 
> have staged enough lines, the hunk will be split automatically by the 
> current number-of-context-lines setting.

And your hand falls off... ;-)

Seriously, I often have a big chunk of changes, for example with 
an indentation change, where I want to stage everything _but_ one line in 
the middle.  Just staging that, "git checkout <file>" and fixing the 
indentation of that single line speeds up my procedure vastly.

Ciao,
Dscho
