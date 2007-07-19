From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH (REVISED)] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 15:28:53 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707191525160.22541@xanadu.home>
References: <11848281302504-git-send-email-aroben@apple.com>
 <200707191148.46228.andyparkins@gmail.com>
 <Pine.LNX.4.64.0707191213300.14781@racer.site>
 <200707191523.42086.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 21:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBbhA-0007tW-A2
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 21:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940265AbXGST3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 15:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939694AbXGST26
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 15:28:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59072 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939236AbXGST2z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 15:28:55 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JLF00EUAY453M30@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Jul 2007 15:28:54 -0400 (EDT)
In-reply-to: <200707191523.42086.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53024>

On Thu, 19 Jul 2007, Andy Parkins wrote:

> On Thursday 2007 July 19, Johannes Schindelin wrote:
> > And how would having "core.pager" but "porcelain.editor" be easier to
> > remember?  Nah, not really.
> 
> If there is no difference, then do you object so strongly?

If anything I think it is core.pager which is a misnommer.  A pager is 
certainly more porcelainish. by nature.

Given that core.pager already exists, I think it would be yet another 
mistake to put editor in a different section separate from pager.

IMHO both of them should have been user.pager and user.editor.


Nicolas
