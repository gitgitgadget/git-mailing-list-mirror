From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 22:35:34 +0200
Message-ID: <20070520203534.GB25462@steel.home>
References: <20070520181447.GA10638@ferdyx.org> <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net> <20070520184959.GA25462@steel.home> <20070520190024.GE13197@ferdyx.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "Fernando J. Pereda" <ferdy@ferdyx.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 20 22:35:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hps7z-0005hf-JU
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756085AbXETUfh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756069AbXETUfh
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:35:37 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:63052 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085AbXETUfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:35:37 -0400
Received: from tigra.home (Faeaf.f.strato-dslnet.de [195.4.174.175])
	by post.webmailer.de (klopstock mo56) (RZmta 6.5)
	with ESMTP id H0478dj4KHesi5 ; Sun, 20 May 2007 22:35:35 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0187D277BD;
	Sun, 20 May 2007 22:35:34 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 95986D195; Sun, 20 May 2007 22:35:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520190024.GE13197@ferdyx.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jEE44=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47908>

Fernando J. Pereda, Sun, May 20, 2007 21:00:24 +0200:
> On Sun, May 20, 2007 at 08:49:59PM +0200, Alex Riesen wrote:
> > Junio C Hamano, Sun, May 20, 2007 20:36:25 +0200:
> > > > +IMPORTANT: Maildir splitting relies upon filenames being sorted to output
> > > > +patches in the correct order.
> > > 
> > > I am sure there are many users who uses Maildir layout on this
> > > list.  Happy with this patch?  Please speak out.
> > 
> > I do use maildirs, but I have a suggestion: --maildir or something, to
> > create a non-existing maildir and split into it, so that the user does
> > not have to pre-create it.
> 
> I can't think of a use case for this...
> 

You actually enjoy typing "mkdir tmp && git mailsplit tmp"?
