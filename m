From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Refactor recv_sideband()
Date: Tue, 14 Jun 2016 11:04:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1606141059420.1714@knanqh.ubzr>
References: <20160613195224.13398-1-lfleischer@lfos.de> <alpine.LFD.2.20.1606131704060.1714@knanqh.ubzr> <alpine.DEB.2.20.1606141542040.22630@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Lukas Fleischer <lfleischer@lfos.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 14 17:19:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCq7i-00066T-I0
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 17:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbcFNPTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 11:19:22 -0400
Received: from alt32.smtp-out.videotron.ca ([24.53.0.21]:38844 "EHLO
	alt32.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750832AbcFNPTW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 11:19:22 -0400
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jun 2016 11:19:21 EDT
Received: from yoda.home ([96.23.157.65])
	by Videotron with SMTP
	id CpszbUi5QJE3dCpt0b6aek; Tue, 14 Jun 2016 11:04:15 -0400
X-Authority-Analysis: v=2.1 cv=DYG30qZW c=1 sm=1 tr=0
 a=keA3yYpnlypCNW5BNWqu+w==:117 a=keA3yYpnlypCNW5BNWqu+w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=kj9zAlcOel0A:10
 a=pD_ry4oyNxEA:10 a=8tHSct8SZZ8Are3vbLsA:9 a=CjuIK1q_8ugA:10
Received: from xanadu.home (xanadu.home [192.168.2.2])
	by yoda.home (Postfix) with ESMTPSA id 96D3B2DA01A5;
	Tue, 14 Jun 2016 11:04:13 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1606141542040.22630@virtualbox>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
X-CMAE-Envelope: MS4wfB2wEIvykkoRmI8/4HDAjSbnpog32mkDHutPLRQQd2CQbVfRXzkEvDzFxXH/2xpYU9t0wZqxnF2qYEzkp4uEiBHKRNtftMOHNDwzDT9qLMcdWapzxinL
 tQsa+6xhbZTnfoibuGeqkIWmbpz2PpQLCONY1IycbcO10OJfIIX3zHwi2VlXKqp3JEdxwluMHy+KtgqugogZ0tv/1Gp0RZJHUN0MbmsSlTtQAS/lQnyFSloN
 cyleTi+9zGlUVe8pTVS2Dg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297298>

On Tue, 14 Jun 2016, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 13 Jun 2016, Nicolas Pitre wrote:
> 
> > On Mon, 13 Jun 2016, Lukas Fleischer wrote:
> > 
> > > Improve the readability of recv_sideband() significantly by replacing
> > > fragile buffer manipulations with more sophisticated format strings.
> > > Also, reorganize the overall control flow, remove some superfluous
> > > variables and replace a custom implementation of strpbrk() with a call
> > > to the standard C library function.
> > > 
> > > Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
> > 
> > The previous code was a total abomination, even if I happen to know who 
> > wrote it.
> 
> Let's give Junio a break, okay? He does a kick-ass job at maintaining Git.
> What we see here is simply good software development, nothing more,
> nothing less: an initial, working code being improved. No need to make the
> original author feel bad... :-)

In case my sarcasm wasn't clear, _I_ am the author of the alluded 
abomination.


Nicolas
