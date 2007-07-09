From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Per-path attribute based hunk header selection.
Date: Sun, 08 Jul 2007 23:22:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707082320480.26459@xanadu.home>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
 <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
 <7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
 <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
 <7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707051223520.9789@racer.site>
 <7v8x9uexji.fsf_-_@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0707061051020.9434@woody.linux-foundation.org>
 <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 05:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7jpv-0000ZX-34
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 05:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758452AbXGIDWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 23:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758057AbXGIDWn
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 23:22:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45340 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495AbXGIDWm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 23:22:42 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKW00I5Q6PT4O40@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 08 Jul 2007 23:22:41 -0400 (EDT)
In-reply-to: <7v8x9tdlbv.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51946>

On Fri, 6 Jul 2007, Junio C Hamano wrote:

> About the comment from Johannes regarding hunk_header vs
> funcname, I would actually prefer hunk_header, since that is
> what this is about ("funcname" and "find_func" were misnomer
> from the beginning), but I'd rename hunk_header to funcname for
> the sake of consistency and minimizing the diff.

I think "minimizing the diff" in this case is a bad reason.  Using 
hunk_header is so much better than funcname IMHO.


Nicolas
