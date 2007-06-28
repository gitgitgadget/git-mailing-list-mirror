From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid perl in t1300-repo-config
Date: Thu, 28 Jun 2007 15:19:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706281412190.4438@racer.site>
References: <81b0412b0706270545w65ca2556yaafaac6ff31b5961@mail.gmail.com> 
 <7vmyykog4e.fsf@assigned-by-dhcp.pobox.com>
 <81b0412b0706280041i535efdf0r87e552551b796044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 16:25:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3uwP-00044l-Qd
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 16:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754309AbXF1OZo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 10:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbXF1OZo
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 10:25:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:43744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753249AbXF1OZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 10:25:43 -0400
Received: (qmail invoked by alias); 28 Jun 2007 14:25:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 28 Jun 2007 16:25:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Vm9c/fUYVa/QPk25c2nlbsA7Pz3haOAT2T3knrD
	6b/cAxxz+pLA3Y
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0706280041i535efdf0r87e552551b796044@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51109>

Hi,

On Thu, 28 Jun 2007, Alex Riesen wrote:

> On 6/28/07, Junio C Hamano <gitster@pobox.com> wrote:
> 
> > By the way, is it possible for gmail users to avoid attachments when 
> > sending patches in?
> 
> No. The message text is unpredictably garbled

It is not really unpredictable.

- whitespace at the end of line is stripped
- too long lines are _always_ broken (and our diffstat lines qualify for 
  that)
- empty lines at the end of the message are stripped (does not concern us)
- empty lines at the beginning of the message are stripped (does not 
  concern us either)
- encodings different from UTF-8 are a problem

Of course, the first reason already precludes diffs from being sent. Just 
think of an empty line, which is in both versions (or even worse, a single 
space on the line).

Ciao,
Dscho
