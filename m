From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: fix overzealous output redirection
Date: Thu, 26 Jul 2007 07:48:16 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707260746470.14781@racer.site>
References: <Pine.LNX.4.64.0707260735150.14781@racer.site>
 <7vejivacun.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 08:48:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDx96-0004uw-Sb
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 08:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757955AbXGZGsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 02:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757774AbXGZGsV
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 02:48:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:57233 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757143AbXGZGsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 02:48:21 -0400
Received: (qmail invoked by alias); 26 Jul 2007 06:48:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 26 Jul 2007 08:48:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18afHMbbnkavLPbk/Ci3lqb0lWFRXt1q7lh/hP3Iz
	dA+wfKNH6pB31t
X-X-Sender: gene099@racer.site
In-Reply-To: <7vejivacun.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53788>

Hi,

On Wed, 25 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When squashing, you no longer saw what the editor had to say to you
> > after commit 'Shut "git rebase -i" up when no --verbose was given'
> > (if you used a console based editor, at least).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > 	This bit me real hard when cleaning up the work-tree patch
> > 	series.
> 
> Heh, good catch.
> 
> At least you are eating your own dog food, which is a very
> assuring thing before the feature release.  Thanks.

I try my very best!  Though I have to go to bed without having had a 
chance to work on the send-pack bug :-(

Good night, and good luck,
Dscho
