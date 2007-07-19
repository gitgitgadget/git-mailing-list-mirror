From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 12:10:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707191209200.14781@racer.site>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net> <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
 <200707191158.37713.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alberto Bertogli <albertito@gmail.com>,
	Johan Herland <johan@herland.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:10:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTti-0008MS-2T
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 13:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbXGSLKK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 07:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbXGSLKK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 07:10:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:37770 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754775AbXGSLKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 07:10:08 -0400
Received: (qmail invoked by alias); 19 Jul 2007 11:10:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 19 Jul 2007 13:10:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/H9EUSRVLHAAkhInuoe2yqz7ostMc+6I64eb+bgq
	zaLjzY9t+dpghh
X-X-Sender: gene099@racer.site
In-Reply-To: <200707191158.37713.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52968>

Hi,

On Thu, 19 Jul 2007, Andy Parkins wrote:

> On Thursday 2007 July 19, Junio C Hamano wrote:
> 
> > I've long time ago concluded that if we care about reliability
> > (and we do very much), a bisectable tree without breaking
> > backward compatibility is impossible.  I was hoping to find a
> > "hole" in tree object format so that I can place an extended
> 
> In the case of the notes system, is there not a big hole available 
> because the layout is under tight control?

No.  It is a tree object, referenced from a ref.  You can always check it 
out, modify it, and check it in.  If only by mistake.

Ciao,
Dscho
