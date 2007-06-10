From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Change softrefs file format from text (82 bytes per
 entry) to binary (40 bytes per entry)
Date: Sun, 10 Jun 2007 10:46:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706101022210.4059@racer.site>
References: <200706040251.05286.johan@herland.net> <200706092019.13185.johan@herland.net>
 <200706092025.30156.johan@herland.net> <Pine.LNX.4.64.0706100900420.4059@racer.site>
 <7vir9w8b4a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:49:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxK32-0005lk-Fq
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbXFJJtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 05:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbXFJJtX
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:49:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:35869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751188AbXFJJtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:49:22 -0400
Received: (qmail invoked by alias); 10 Jun 2007 09:49:21 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp040) with SMTP; 10 Jun 2007 11:49:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Kxic7NJgKTg+/65bSGPzJl/o4nQDmLxPSYFJ2j4
	36qPjezDDhYRBp
X-X-Sender: gene099@racer.site
In-Reply-To: <7vir9w8b4a.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49697>

Hi,

On Sun, 10 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 9 Jun 2007, Johan Herland wrote:
> >
> >> The text-based softrefs file format uses 82 bytes per entry (40 bytes 
> >> from_sha1 in hex, 1 byte SP, 40 bytes to_sha1 in hex, 1 byte LF).
> >> 
> >> The binary softrefs file format uses 40 bytes per entry (20 bytes 
> >> from_sha1, 20 bytes to_sha1).
> >> 
> >> Moving to a binary format increases performance slightly, but sacrifices 
> >> easy readability of the softrefs files.
> >
> > It is bad style to introduce one type, and then change it to another in a 
> > backwards-incompatible way. Either you make it backwards compatible, or 
> > you start with the second format, never even mentioning that you had 
> > another format.
> 
> While I agree with that in principle, I think you are being a
> bit too harsh to a set of patches that shows possible
> alternatives for an idea that is not even in any unreleased
> version of git.
> 
> Got out of the wrong side of bed this morning?

Possibly. Except it was not a bed, but an airplane passenger seat.

And it did not help that I totally disagree with the approach: "sorted 
list does not do this well, unsorted not that... let's take both!"

So, please take my words with a grain of salt. But I still think that 
_what_ I was saying is correct.

Yes, the patch series shows an alternative, but I would have wished for 
either a smaller quick-n-dirty proof-of-concept implementation ([RFC]), or 
a better thought-through one ([PATCH]).

Ciao,
Dscho
