From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Draft release notes for v1.5.3, as of -rc1
Date: Sat, 14 Jul 2007 15:22:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707141517450.14781@racer.site>
References: <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net> <7vejl0546b.fsf@assigned-by-dhcp.cox.net>
 <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net> <7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
 <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
 <7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com> <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
 <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> <7vlkdkq00o.fsf_-_@assigned-by-dhcp.cox.net>
 <20070713092908.GO1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jul 14 16:22:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9iWF-0002UN-UG
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 16:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbXGNOWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 10:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757204AbXGNOWf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 10:22:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:57840 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752162AbXGNOWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 10:22:34 -0400
Received: (qmail invoked by alias); 14 Jul 2007 14:22:32 -0000
Received: from R526b.r.pppool.de (EHLO noname) [89.54.82.107]
  by mail.gmx.net (mp017) with SMTP; 14 Jul 2007 16:22:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NOqkRJzBNUg16Dz+v77ZSmEkoaXuvqyOwwaV9pJ
	+zGnxGUZX+rlr6
X-X-Sender: gene099@racer.site
In-Reply-To: <20070713092908.GO1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52482>

Hi,

On Fri, 13 Jul 2007, Sven Verdoolaege wrote:

> On Thu, Jul 12, 2007 at 11:40:39PM -0700, Junio C Hamano wrote:
> >   - "git-filter-branch" lets you rewrite the revision history of
> >     the current branch, creating a new branch. You can specify a
> >     number of filters to modify the commits, files and trees.
> 
> Are you sure you want to announce this so publicly given that
> Dscho has basically declared git-filter-branch dead?
> (I know, I'm mostly to blame.)

It is really unfortunate that rewrite-commits came in so late in the 
release cycle, and I am quite sure it should not be in 1.5.3.  There is 
just too much new in it, and too many things to flesh out.

Junio, if you want to include it in 1.5.3, it should be marked as alpha 
code, as it has not seen any time in "next", let alone "master".

However, no matter if rewrite-commits is included in 1.5.3, I am not sure 
what to do about filter-branch.

Since it saw a lot of testing in its admin-rewritehist form, and has had 
at least some eye pairs looking over it, I have the feeling that it is 
stable enough to include.  How to tell people that it will soon be 
obsoleted by rewrite-commits, I have no idea.

It would be a much less difficult problem if the syntax of filter-branch 
and rewrite-commits was identical.  Maybe we should make it so, by 
changing filter-branch?

Thoughts?

Ciao,
Dscho
