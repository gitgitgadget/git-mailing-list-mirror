From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach the --cover-letter option to format-patch
Date: Tue, 10 Jul 2007 18:20:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707101819350.4047@racer.site>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org>
 <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707101424140.4047@racer.site>
 <Pine.LNX.4.64.0707101300450.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:28:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8JVk-0007E7-A7
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 19:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762904AbXGJR2W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 13:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762978AbXGJR2V
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 13:28:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:42743 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759039AbXGJR2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 13:28:19 -0400
Received: (qmail invoked by alias); 10 Jul 2007 17:28:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 10 Jul 2007 19:28:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18n9zMdBBYnI332+jhhv1a5Kx0CR5q7O40Awyiyzi
	jkdnaIIQkSsdQ0
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707101300450.6977@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52097>

Hi,

On Tue, 10 Jul 2007, Daniel Barkalow wrote:

> I think this is missing the ultra-important "extra_headers" stuff, which 
> is what makes my messages actually reach the right people. That's why 
> I'd like the code shared for generating headers (except for Subject) for 
> a rev_info between the code that does it for patch messages and the code 
> for the cover letter. I think it's also missing making [PATCH 1/N] a 
> reply to it if the series is set up as replies.

Ah yes. Both issues should be relatively easy to integrate into my patch.

> I like the design, in any case. I want the blurb actually stored in the 
> objects directory somehow, so that I don't have to trawl through my sent 
> email for it when I send the series again for some reason, but that's a 
> relatively straightforward extension to your code. (Read an object with 
> a hash and stick the text in instead of the ***...*** parts.)

I do not understand. But then, my patch should be a good starting point. 
Go wild.

Ciao,
Dscho
