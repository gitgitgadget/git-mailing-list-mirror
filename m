From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 11/11] Support bundles in builtin-clone
Date: Sun, 9 Mar 2008 15:00:58 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803091447230.19665@iabervon.org>
References: <alpine.LNX.1.00.0803081804280.19665@iabervon.org> <alpine.LSU.1.00.0803090027570.3975@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 09 20:02:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYQmW-0000g8-5i
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 20:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbYCITBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 15:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbYCITBB
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 15:01:01 -0400
Received: from iabervon.org ([66.92.72.58]:59762 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbYCITBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 15:01:00 -0400
Received: (qmail 1341 invoked by uid 1000); 9 Mar 2008 19:00:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Mar 2008 19:00:58 -0000
In-Reply-To: <alpine.LSU.1.00.0803090027570.3975@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76664>

On Sun, 9 Mar 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sat, 8 Mar 2008, Johannes Schindelin wrote:
> 
> > This forward-ports c6fef0bb(clone: support cloning full bundles) to the
> > builtin clone.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Wow... Is this a new send-email feature?  I did not send this email...

Nope, it's an old format-patch feature. format-patch generates the 
messages with the From: being the commit author, and my MTA doesn't 
complain about the fact that I'm sending email with some entirely 
different From:. It would probably be more clever to have format-patch use 
the committer or the current user as the From:, and put an additional 
From: in the message body with the author if it's not the email From:.

Of course, you did sort of send that email 
(http://permalink.gmane.org/gmane.comp.version-control.git/75743). I just 
bounced it to the list again with a different subject, some other headers, 
the note removed, and the patch rebased. Or something like that. I 
actually didn't expect it to come out looking like you'd sent the email 
until it showed up (or, rather, until it didn't show up for a little while 
because vger thought it was odd).

	-Daniel
*This .sig left intentionally blank*
