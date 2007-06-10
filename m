From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Silence error messages unless 'thorough_verify' is set
Date: Sun, 10 Jun 2007 11:08:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706101103160.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vwsydf1m8.fsf@assigned-by-dhcp.cox.net> <200706092028.54459.johan@herland.net>
 <200706092142.05446.johan@herland.net> <Pine.LNX.4.64.0706100741310.4059@racer.site>
 <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 12:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxKOg-0000Uk-38
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 12:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbXFJKLp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 06:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbXFJKLp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 06:11:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:44893 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752467AbXFJKLo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 06:11:44 -0400
Received: (qmail invoked by alias); 10 Jun 2007 10:11:42 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp001) with SMTP; 10 Jun 2007 12:11:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+w0L53VRiwYIuiNqmTg0VQxwu19+t9wkUeCh7iix
	DKdm+hkyNS5gM5
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49707>

Hi,

On Sun, 10 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ...  Guess how surprised 
> > _I_ was, when I hit the error message which made me go mad.
> 
> To be fair, that ugly "char%d" was taken from mktag and not
> Johan's invention.

Yes, I should have said that. I tried to hint to this by "you could just 
as well clean the code up", meaning the existing code.

Now, _that_ would be a patch I'd be really thankful for.

As for the general direction of implementing notes as tags: If you want to 
make them fetchable, you have to deal with conflicts. If you want to be 
able to amend notes, _especially_ when they should be fetchable, you want 
a history on them.

Which makes me think that tags are not the right object type for notes.

But I guess I'll just wait if somebody actually comments on my RFC for 
lightweight commit annotations (that's what I put into that discussion). 
BTW I just realized that I marked it [PATCH], while it should have been 
[RFC]. Sorry.

Ciao,
Dscho
