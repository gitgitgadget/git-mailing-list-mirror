From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] cvsserver: Fix handling of diappeared files on update
Date: Wed, 11 Apr 2007 18:02:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704111755120.27922@iabervon.org>
References: <Pine.LNX.4.64.0704111158220.27922@iabervon.org>
 <11763238991005-git-send-email-frank@lichtenheld.de> <461D5890.1000605@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:02:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbktP-0008R9-BT
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 00:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbXDKWCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 18:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbXDKWCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 18:02:16 -0400
Received: from iabervon.org ([66.92.72.58]:1713 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030185AbXDKWCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 18:02:15 -0400
Received: (qmail 7085 invoked by uid 1000); 11 Apr 2007 22:02:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Apr 2007 22:02:14 -0000
In-Reply-To: <461D5890.1000605@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44265>

On Thu, 12 Apr 2007, Martin Langhoff wrote:

> Frank Lichtenheld wrote:
> > Only send a modified response if the client sent a
> > "Modified" entry. This fixes the case where the
> > file was locally deleted on the client without
> > being removed from CVS. In this case the client
> > will only have sent the Entry for the file but nothing
> > else.
> > 
> > Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
> 
> Ack. With this, git-cvsserver matches cvs's behaviour. The only
> difference is that cvs also spits out
> 
>   E cvs update: warning: $path was lost

My cvs client says:

cvs update: warning: $path unexpectedly disappeared

I'm not sure if something suitable is generated client-side in general, 
but mine seems to.

	-Daniel
*This .sig left intentionally blank*
