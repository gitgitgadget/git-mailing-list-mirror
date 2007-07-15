From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Draft release notes for v1.5.3, as of -rc1
Date: Mon, 16 Jul 2007 00:53:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707160053130.14781@racer.site>
References: <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net> <7vejl0546b.fsf@assigned-by-dhcp.cox.net>
 <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net> <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
 <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
 <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com> <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
 <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> <7vlkdkq00o.fsf_-_@assigned-by-dhcp.cox.net>
 <20070713092908.GO1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707141517450.14781@racer.site> <7vvecmj1ju.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:54:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADuq-0006LF-Sp
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbXGOXyO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756185AbXGOXyO
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:54:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:38598 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755125AbXGOXyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:54:13 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:54:11 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp044) with SMTP; 16 Jul 2007 01:54:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/nFMJaHt7nZNsb5h7lnAMm645tIsXChJZMbpnbCO
	5eEOGWt/mtyW+1
X-X-Sender: gene099@racer.site
In-Reply-To: <7vvecmj1ju.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52611>

Hi,

On Sat, 14 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It is really unfortunate that rewrite-commits came in so late in the 
> > release cycle, and I am quite sure it should not be in 1.5.3.  There is 
> > just too much new in it, and too many things to flesh out.
> >
> > Junio, if you want to include it in 1.5.3, it should be marked as alpha 
> > code, as it has not seen any time in "next", let alone "master".
> 
> I am not considering rewrite-commits for inclusion right now.

Fair enough.

> I was hoping that filter-branch will stay.  Its interface is something 
> people are already familiar with since the days of its its older 
> incarnation cg-admin-rewritehist, and it would be really really nice 
> that anything that attempts to replace it builds on and extends its 
> external interface.
> 
> Maybe rewrite-commits can be used to delegate the implementation of 
> heavy lifting from filter-branch?  IOW can the latter be just a thin 
> wrapper around the former?

That is a very good idea.

Ciao,
Dscho
