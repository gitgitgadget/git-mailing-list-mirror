From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use only the PATH for exec'ing git commands
Date: Tue, 23 Oct 2007 00:40:15 +0200
Message-ID: <20071022224015.GG23714@steel.home>
References: <1193091122.v2.fusewebmail-240137@f>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Tue Oct 23 00:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik5wo-0005M3-TR
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 00:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbXJVWkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 18:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbXJVWkU
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 18:40:20 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:41707 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbXJVWkS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 18:40:18 -0400
Received: from tigra.home (Fab70.f.strato-dslnet.de [195.4.171.112])
	by post.webmailer.de (mrclete mo9) (RZmta 13.6)
	with ESMTP id m06122j9MJuu2S ; Tue, 23 Oct 2007 00:40:16 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0803E277AE;
	Tue, 23 Oct 2007 00:40:16 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D30F856D22; Tue, 23 Oct 2007 00:40:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1193091122.v2.fusewebmail-240137@f>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKf+sU=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62050>

Scott R Parish, Tue, Oct 23, 2007 00:12:02 +0200:
> > Alex Riesen, Mon, Oct 22, 2007 12:01
> > Scott R Parish, Mon, Oct 22, 2007 19:01:48 +0200:
> > > +                strbuf_addch(out, ':');
> >
> > Shouldn't it break MingW32 native port?
> 
> What can i do here to better accommodate MingW32? You're
> right, just because the original code did it this way
> isn't a good excuse for me not to do it better.

someone here mentioned "higher abstractions". Maybe he meant moving
the routines operating on path names and path lists out of the generic
code into platform specific (like compat/). Maybe he was even going to
do that himself, but I could be mistaken
