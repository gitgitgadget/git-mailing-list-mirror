From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git clone behaviour change in 1.5.6 (vs 1.5.5.1)
Date: Mon, 23 Jun 2008 15:56:41 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806231554380.19665@iabervon.org>
References: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: zuh@iki.fi
X-From: git-owner@vger.kernel.org Mon Jun 23 21:57:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsAX-00058Q-Sh
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 21:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763645AbYFWT4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 15:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755101AbYFWT4o
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 15:56:44 -0400
Received: from iabervon.org ([66.92.72.58]:54315 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763645AbYFWT4n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 15:56:43 -0400
Received: (qmail 1487 invoked by uid 1000); 23 Jun 2008 19:56:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jun 2008 19:56:41 -0000
In-Reply-To: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85911>

On Mon, 23 Jun 2008, Kalle Vahlman wrote:

> Hi!
> 
> Switching to the 1.5.6 release from 1.5.5.1, I found out that the
> rewritten git-clone command changed its behaviour wrt cloning to a
> non-existing destination directory structure. In the shell version the
> destination (work tree) is created with 'mkdir -p' but in the C
> version with just the mkdir() call which doesn't create the parent
> directories.
> 
> I can't find any indication that this would be intended in the repo
> history nor in the mailing list, so I'm left thinking that this is an
> unwanted regression. Could someone confirm this?

It wasn't an intentional change, anyway.

	-Daniel
*This .sig left intentionally blank*
