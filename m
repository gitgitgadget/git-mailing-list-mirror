From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Sun, 22 Jul 2007 15:16:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707221511410.29679@iabervon.org>
References: <Pine.LNX.4.64.0707221956210.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:16:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgv6-0002j6-2Q
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762408AbXGVTQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762305AbXGVTQh
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:16:37 -0400
Received: from iabervon.org ([66.92.72.58]:2126 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761391AbXGVTQg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 15:16:36 -0400
Received: (qmail 27367 invoked by uid 1000); 22 Jul 2007 19:16:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jul 2007 19:16:34 -0000
In-Reply-To: <Pine.LNX.4.64.0707221956210.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53301>

On Sun, 22 Jul 2007, Johannes Schindelin wrote:

> A word of warning: switching to _same_ branch that is checked out in
> the other repository is asking for trouble.  You are really working not
> only on the same object database, but also the same (i.e. not copied)
> refs namespace.

It's probably time to revive Junio's patch for keeping the 
fully-dereferenced value of HEAD in the index, to make this safer.

	-Daniel
*This .sig left intentionally blank*
