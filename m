From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Since when is a tag a commit?
Date: Mon, 7 Aug 2006 23:28:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0608072325390.9789@iabervon.org>
References: <20060808021251.GA19548@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 05:27:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAIFo-0002PF-Od
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 05:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWHHD1H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 23:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWHHD1H
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 23:27:07 -0400
Received: from iabervon.org ([66.92.72.58]:54535 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932137AbWHHD1G (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 23:27:06 -0400
Received: (qmail 3926 invoked by uid 1000); 7 Aug 2006 23:28:32 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Aug 2006 23:28:32 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060808021251.GA19548@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25059>

On Mon, 7 Aug 2006, Shawn Pearce wrote:

> What the heck is going on?  Since when did git cat-file happily
> consider a tag to be a tag, a commit and a tree?  Its that
> intentional that we're peeling back the object to the requested type?

I think it's done that for a long time now. All of the other commands that 
take a tree or a commit will accept a tag, so why shouldn't "git cat-file 
tree"?

	-Daniel
*This .sig left intentionally blank*
