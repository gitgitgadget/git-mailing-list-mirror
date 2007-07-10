From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Teach the --cover-letter option to format-patch
Date: Tue, 10 Jul 2007 13:20:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707101300450.6977@iabervon.org>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org>
 <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707101424140.4047@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:20:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8JNj-000547-64
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 19:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756784AbXGJRUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 13:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755162AbXGJRUG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 13:20:06 -0400
Received: from iabervon.org ([66.92.72.58]:1732 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756784AbXGJRUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 13:20:05 -0400
Received: (qmail 31440 invoked by uid 1000); 10 Jul 2007 17:20:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Jul 2007 17:20:03 -0000
In-Reply-To: <Pine.LNX.4.64.0707101424140.4047@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52096>

I think this is missing the ultra-important "extra_headers" stuff, which 
is what makes my messages actually reach the right people. That's why I'd 
like the code shared for generating headers (except for Subject) for a 
rev_info between the code that does it for patch messages and the code for 
the cover letter. I think it's also missing making [PATCH 1/N] a reply to 
it if the series is set up as replies.

I like the design, in any case. I want the blurb actually stored in the 
objects directory somehow, so that I don't have to trawl through my sent 
email for it when I send the series again for some reason, but that's a 
relatively straightforward extension to your code. (Read an object with a 
hash and stick the text in instead of the ***...*** parts.)

	-Daniel
*This .sig left intentionally blank*
