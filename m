From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git diff woes
Date: Mon, 12 Nov 2007 10:01:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711120958500.4362@racer.site>
References: <4738208D.1080003@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 12 11:02:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrW83-00057H-0s
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 11:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758319AbXKLKCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 05:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758320AbXKLKCh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 05:02:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:59579 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758319AbXKLKCf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 05:02:35 -0500
Received: (qmail invoked by alias); 12 Nov 2007 10:02:34 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 12 Nov 2007 11:02:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Av0Z/YbeAK2MA0gmwBJGipco76iZcfy08eJV4TG
	w3aYh+6LrJuV9f
X-X-Sender: gene099@racer.site
In-Reply-To: <4738208D.1080003@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64588>

Hi,

On Mon, 12 Nov 2007, Andreas Ericsson wrote:

> I recently ran into an oddity with the excellent git diff output
> format. When a function declaration changes in the same patch as
> something else in a function, the old declaration is used with the
> diff hunk-headers.
> 
> [...]
> 
> It definitely looks like a bug, but really isn't, since an earlier hunk
> (pasted below) changes the declaration.
>
> [...]
>
> This makes it impossible to trust the hunk-header info if the declaration
> changes.

Huh?  You admit yourself that it is not a bug.  And sure you can trust the 
hunk header.  Like most of the things, the relate to the _original_ 
version, since the diff is meant to be applied as a forward patch.

So for all practical matters, the diff shows the correct thing: "in this 
hunk, which (still) belongs to that function, change this and this."

Of course, that is only the case if you accept that the diff should be 
applied _in total_, not piecewise.  IOW if you are a fan of GNU patch 
which happily clobbers your file until it fails with the last hunk, you 
will not be happy.

Ciao,
Dscho
