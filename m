From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Mon, 9 Jul 2007 12:40:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707091236300.5546@racer.site>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
 <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
 <7vejjnhpap.fsf@assigned-by-dhcp.cox.net> <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
 <7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707051223520.9789@racer.site>
 <7v8x9uexji.fsf_-_@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0707061051020.9434@woody.linux-foundation.org>
 <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707082320480.26459@xanadu.home>
 <7vd4z2xj34.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 13:48:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7rj2-0004B3-Bk
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 13:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbXGILsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 07:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbXGILsR
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 07:48:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:43265 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750957AbXGILsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 07:48:16 -0400
Received: (qmail invoked by alias); 09 Jul 2007 11:48:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 09 Jul 2007 13:48:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1811o41qmU1OlH22zDhWMj0pntPmlmIc2ISPJYAN4
	kMStkDBSpzltD6
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4z2xj34.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51983>

Hi,

On Sun, 8 Jul 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Fri, 6 Jul 2007, Junio C Hamano wrote:
> >
> >> About the comment from Johannes regarding hunk_header vs
> >> funcname, I would actually prefer hunk_header, since that is
> >> what this is about ("funcname" and "find_func" were misnomer
> >> from the beginning), but I'd rename hunk_header to funcname for
> >> the sake of consistency and minimizing the diff.
> >
> > I think "minimizing the diff" in this case is a bad reason.  Using 
> > hunk_header is so much better than funcname IMHO.
> 
> Well, even then it turns out to be a good reason, as the patch
> to rename function and field can be a separate patch.  After
> adding that "latex pattern" stuff, I am even more inclined to
> rename them.

Not to mention that even the name "hunk_header_pattern_ident" would be a 
misnomer to begin with.  It is the diff attribute we are storing there.  
Did you have any chance to look at

	http://thread.gmane.org/gmane.comp.version-control.git/51828

yet?  That should clarify things, and

	http://article.gmane.org/gmane.comp.version-control.git/51829

on top of it should clarify things even more, besides making the code a 
little faster again.

Ciao,
Dscho
