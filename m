From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Allow updating the index from a pipe
Date: Sat, 10 Dec 2005 02:12:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512100210090.25300@iabervon.org>
References: <Pine.LNX.4.64.0512100145500.25300@iabervon.org>
 <7vbqzpxwg2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 08:11:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekyt6-0006TE-V7
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 08:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVLJHLS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 02:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVLJHLS
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 02:11:18 -0500
Received: from iabervon.org ([66.92.72.58]:34309 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964948AbVLJHLR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 02:11:17 -0500
Received: (qmail 27213 invoked by uid 1000); 10 Dec 2005 02:12:05 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Dec 2005 02:12:05 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqzpxwg2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13442>

On Fri, 9 Dec 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > In order to allow the index to be modified in simple ways without
> > having a working tree, this adds an option to git-update-index which
> > updates a single path with a mode of 100644 and reads the content from
> > stdin.
> 
> I wonder ...
> 
> Could you do this with existing hash-object with update-index
> --cache-info (or --index-info) please?  If you do not want a
> temporary file and prefer piping contents into a command,
> extending hash-object would be preferable.

Sure; I lost track of what hash-object was called at some point and 
thought it had been removed. I'll do a patch to extend that to take stdin 
when I get a chance.

	-Daniel
*This .sig left intentionally blank*
